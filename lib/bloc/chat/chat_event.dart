import 'package:map_pro/model/message_model.dart';

abstract class ChatEvent {}

/// Initialize chat session
class InitChat extends ChatEvent {

  InitChat();
}

class SendMessage extends ChatEvent {
  final String text;
  SendMessage(this.text);
}
class InitialEvent extends ChatEvent
{

}

class MessageReceived extends ChatEvent {
List<MessageModel> messageList;
  MessageReceived(this.messageList);
}
// NEW: Request to generate QR code data (e.g. userId or chatId)
class GenerateQRCode extends ChatEvent {
  final String dataToEncode; // e.g., userId or chatId
  GenerateQRCode(this.dataToEncode);
}

// NEW: Scanned QR code data received
class QRCodeScanned extends ChatEvent
{
  final String scannedData; // e.g., scanned peerId
  QRCodeScanned(this.scannedData);
}
class FcmTokenRequest extends ChatEvent
{
  FcmTokenRequest();
}
class LoadMyChatsOnly extends ChatEvent {
  final String myId;
  LoadMyChatsOnly(this.myId);
}