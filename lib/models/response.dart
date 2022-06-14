import 'package:tacpulse/models/task.dart';

class Response {
  int? id;
  String? status;
  String? medicLoc;
  String? targetLoc;
  String? actionTime;
  int? odo;
  String? dis;
  String? dur;
  Task? parent;

  Response(
      {this.id,
      this.status,
      this.medicLoc,
      this.targetLoc,
      this.actionTime,
      this.odo,
      this.dis,
      this.dur,
      this.parent});

  Response.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    medicLoc = json['medic_loc'];
    targetLoc = json['target_loc'];
    actionTime = json['action_time'];
    odo = json['odo'];
    dis = json['dis'];
    dur = json['dur'];
    parent = json['parent'] != null ? new Task.fromJson(json['parent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['medic_loc'] = this.medicLoc;
    data['target_loc'] = this.targetLoc;
    data['action_time'] = this.actionTime;
    data['odo'] = this.odo;
    data['dis'] = this.dis;
    data['dur'] = this.dur;
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
    return data;
  }
}
