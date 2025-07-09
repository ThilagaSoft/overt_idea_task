import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_pro/bloc/chat/chat_bloc.dart';
import 'package:map_pro/bloc/chat/chat_state.dart';
import 'package:map_pro/controller/chat_controller.dart';
import 'package:map_pro/repository/firebe_repository.dart';
import 'package:map_pro/utility/config/static_text.dart';
import 'package:map_pro/view/widgets/common_appBar.dart';

class ChatNew extends StatefulWidget {
  const ChatNew({super.key});

  @override
  State<ChatNew> createState() => _ChatNewState();
}

class _ChatNewState extends State<ChatNew> {
  final textController = TextEditingController();
  final scrollController = ScrollController();
  late final ChatController chatController;

  @override
  void initState()
  {
    super.initState();
    chatController = ChatController(context.read<ChatBloc>());
    FirebaseRepository.initFirebase().then((_)
    {
      chatController.initChat();
    });
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,

      child: Scaffold(
        appBar: CommonAppBar(title: StaticText.chatScreen, backButton: true),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state is ChatLoading)
                    {
                      return const Center(child: CircularProgressIndicator());

                    }
                    if (state is ChatLoaded) {
                      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
                      return ListView.builder(

                        controller: scrollController,
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          final message = state.messages[index];
                          final isMe = chatController.isMyMessage(message.from); // <-- Check with controller
                          return Align(
                            alignment: isMe ? Alignment.centerLeft : Alignment.centerRight,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: isMe ? Colors.blue.shade100 : Colors.green.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(message.text),
                            ),
                          );
                        },
                      );
                    } else if (state is ChatError)
                    {
                      return Center(child: Text("Error: ${state.error}"));
                    }
                    return const Center(child: Text("Have a good day"));

                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller:textController,
                        decoration: const InputDecoration(
                          hintText: "Enter message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: ()
                     {
                      final text = textController.text.trim();
                      if (text.isEmpty) return;
                      chatController.sendMessage(text);
                      textController.clear();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
