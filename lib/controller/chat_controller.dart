import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:map_pro/bloc/chat/chat_bloc.dart';
import 'package:map_pro/bloc/chat/chat_event.dart';

class ChatController {
  final ChatBloc bloc;

  ChatController(this.bloc);
  String? myToken;

  Future<void> initChat() async {
    myToken= await FirebaseMessaging.instance.getToken();
    if (myToken == null) return;
    bloc.add(InitChat()); // self-chat for now
  }

  void sendMessage(String text) {
    bloc.add(SendMessage(text));
  }
  bool isMyMessage(String fromId) {
    return fromId == "$myToken";
  }

}
