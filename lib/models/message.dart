class Message {
  Message({
    required this.message,
    required this.sender,
    required this.timestamp,
  });

  final String message;
  final String sender;
  final int timestamp;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        message: json['message'],
        sender: json['sender'],
        timestamp: json['timestamp'],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'sender': sender,
        'timestamp': timestamp,
      };
}
