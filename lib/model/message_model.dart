import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String from;
  // final int receiverId;
  // final String receiverName;
  // final String senderName;
  final String text;
  final DateTime timestamp;
  final String to;
  // final String userDeviceToken;

  MessageModel({
    required this.from,
    // required this.receiverId,
    // required this.receiverName,
    // required this.senderName,
    required this.text,
    required this.timestamp,
    required this.to,
    // required this.userDeviceToken,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    final rawTimestamp = json['timestamp'];

    DateTime parsedTimestamp;
    if (rawTimestamp is Timestamp) {
      parsedTimestamp = rawTimestamp.toDate();
    } else if (rawTimestamp is String) {
      parsedTimestamp = DateTime.tryParse(rawTimestamp) ?? DateTime.now();
    } else {
      parsedTimestamp = DateTime.now();
    }

    return MessageModel(
      from: json['from']??"" ,
      text: json['text'] ?? '',
      timestamp: parsedTimestamp,
      to: json['to'] ?? '',
    );
  }

}
