import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_pro/bloc/chat/chat_event.dart';
import 'package:map_pro/bloc/chat/chat_state.dart';
import 'package:map_pro/model/message_model.dart';
import 'package:map_pro/repository/chat_repository.dart';
import 'package:map_pro/repository/firebe_repository.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;
  final FirebaseRepository firebaseRepository;

  List<MessageModel> messages = [];
  StreamSubscription<List<MessageModel>>? chatSub;

  ChatBloc({
    required this.chatRepository,
    required this.firebaseRepository,
  }) : super(ChatInitial())
  {
    on<InitChat>(onInit);
    on<SendMessage>(onSend);
    on<MessageReceived>(onReceive);
    on<FcmTokenRequest>(onFcmToken);
  }

  void onInitial(InitialEvent event, Emitter<ChatState> emit) {
    emit(ChatInitial());
  }

  void onInit(InitChat event, Emitter<ChatState> emit) async {
    chatSub?.cancel();
    messages.clear();

    final stream = await chatRepository.subscribeToMessages();
    chatSub = stream.listen((newMessages) {
      if (newMessages.isNotEmpty) {
        add(MessageReceived(newMessages));
      }
    });
  }

  void onSend(SendMessage event, Emitter<ChatState> emit) async
  {
    try {
      await chatRepository.sendMessage(text: event.text);
      add(InitChat());
    } catch (e) {
      print("EX:  $e");
      emit(ChatError(e.toString()));
    }
  }

  void onReceive(MessageReceived event, Emitter<ChatState> emit) {
    messages.addAll(event.messageList);
    emit(ChatLoaded(List.from(messages)));
  }

  void onFcmToken(FcmTokenRequest event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    try {
      final deviceToken = await firebaseRepository.getToken();
      emit(FcmTokenState(deviceToken: deviceToken));
    } catch (e) {
      print("EX:  $e");

      emit(ChatError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    chatSub?.cancel();
    return super.close();
  }
}
