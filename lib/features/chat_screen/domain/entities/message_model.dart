class MessageModel {
  final String senderId;
  final String text;
  final DateTime? timestamp;

  MessageModel({
    required this.senderId,
    required this.text,
    this.timestamp,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'] ?? '',
      text: map['text'] ?? '',
      timestamp: map['timestamp']?.toDate(),
    );
  }
}