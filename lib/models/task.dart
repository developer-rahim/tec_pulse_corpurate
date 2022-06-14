import 'package:tacpulse/models/ambulance.dart';
import 'package:tacpulse/models/crew.dart';

class Task {
  int? id;
  bool? serviceCompletedByParamedic;
  Ambulance? parent;
  Crew? forCrew;

  Task({
    this.id,
    this.serviceCompletedByParamedic,
    this.parent,
    this.forCrew,
    // this.paramedics,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceCompletedByParamedic = json['service_completed_by_paramedic'];
    parent =
        json['parent'] != null ? new Ambulance.fromJson(json['parent']) : null;
    forCrew =
        json['for_crew'] != null ? new Crew.fromJson(json['for_crew']) : null;
    // paramedics = json['paramedics'] != null
    //     ? new User.fromJson(json['paramedics'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_completed_by_paramedic'] = this.serviceCompletedByParamedic;
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
    if (this.forCrew != null) {
      data['for_crew'] = this.forCrew!.toJson();
    }
    // if (this.paramedics != null) {
    //   data['paramedics'] = this.paramedics!.toJson();
    // }
    return data;
  }
}
