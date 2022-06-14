class Notifications {
  final String? firstName;
  final String? lastName;
  final String? notification;

  Notifications({this.firstName, this.lastName, this.notification});

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      firstName: json['first_name'],
      lastName: json['last_name'],
      notification: json['noti_text'],
    );
  }
}
