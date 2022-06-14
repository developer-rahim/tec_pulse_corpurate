class Panic {
  int? id;
  String? emergencyContact;
  String? reason;
  String? forWhome;
  String? place;
  String? lat;
  String? lng;
  bool? assigned;
  String? timestamp;
  bool? completed;
  // User? panicSender;

  Panic({
    this.id,
    this.emergencyContact,
    this.reason,
    this.forWhome,
    this.place,
    this.lat,
    this.lng,
    this.assigned,
    this.timestamp,
    this.completed,
    // this.panicSender,
  });

  Panic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    emergencyContact = json['emergency_contact'];
    reason = json['reason'];
    forWhome = json['for_whome'];
    place = json['place'];
    lat = json['lat'];
    lng = json['lng'];
    assigned = json['assigned'];
    timestamp = json['timestamp'];
    completed = json['completed'];
    // panicSender = json['panic_sender'] != null
    //     ? new User.fromJson(json['panic_sender'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['emergency_contact'] = this.emergencyContact;
    data['reason'] = this.reason;
    data['for_whome'] = this.forWhome;
    data['place'] = this.place;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['assigned'] = this.assigned;
    data['timestamp'] = this.timestamp;
    data['completed'] = this.completed;
    // if (this.panicSender != null) {
    //   data['panic_sender'] = this.panicSender!.toJson();
    // }
    return data;
  }
}
