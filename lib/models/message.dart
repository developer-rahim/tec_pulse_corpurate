class Message {
  final int? id;
  final String? senderEmail;
  final String? message;
  final String? sentTime;

  Message({
    this.id,
    this.message,
    this.senderEmail,
    this.sentTime,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      senderEmail: json['sender']['username'],
      message: json['msg'],
      sentTime: json['sent'],
    );
  }
}
