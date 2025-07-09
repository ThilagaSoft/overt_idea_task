import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map_pro/database/local_db.dart';
import 'package:map_pro/model/message_model.dart';
import 'package:map_pro/repository/firebe_repository.dart';

class ChatRepository {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseRepository firebaseRepository = FirebaseRepository();
  final LocalDatabase db = LocalDatabase.instance;
  Future<Stream<List<MessageModel>>> subscribeToMessages() async {
final  token = await firebaseRepository.getToken();
final receiveToken = await db.getSessionReceiverValue('loggedInReceiverId');
final chatId = getChatId(token.toString(), receiveToken.toString());
    return fireStore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) {
      final List<MessageModel> messages = [];
      for (var doc in snapshot.docChanges) {
        if (doc.type == DocumentChangeType.added) {
          final data = doc.doc.data();
          if (data != null) {
            messages.add(MessageModel(
              text: data['text'],
              timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
              to: data['to'],
              from: data['from'],
            ));
          }
        }
      }
      return messages;
    });
  }

  Future<void> sendMessage({
    required String text,
  }) async {
    final  token = await firebaseRepository.getToken();
    final  receiverToken = await db.getSessionReceiverValue('loggedInReceiverId');
    final chatId = getChatId(token.toString(), receiverToken.toString());
    print("gfhgjkhfkjhgkjfjghjhg");
    print(token.toString());
    print(receiverToken.toString());
    print(text);

await fireStore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'from': token.toString(),
      'to': receiverToken.toString(),
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    });
    await firebaseRepository.sendPushNotification(
      title: "New message",
      body: text,
      token: receiverToken.toString(),
    );
  }

  String getChatId(String a, String b) {
    return a.compareTo(b) < 0 ? '${a}_$b' : '${b}_$a';
  }
}
