class Assessment {
  final String? message;
  final String? remark;
  final bool? warning;
  final String? created;
  final String? toUser;
  final String? byUser;

  Assessment(
      {this.message,
      this.remark,
      this.warning,
      this.created,
      this.toUser,
      this.byUser});

  factory Assessment.fromJson(Map<String, dynamic> json) {
    return Assessment(
      message: json['msg'],
      remark: json['rate'],
      warning: json['warning'],
      created: json['created'],
      byUser:
          json['by_user']['first_name'] + ' ' + json['by_user']['last_name'],
      toUser:
          json['to_user']['first_name'] + ' ' + json['to_user']['last_name'],
    );
  }
}
