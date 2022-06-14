import 'package:tacpulse/models/assigned_unit.dart';

class Crew {
  int? id;
  String? vehicleTotal;
  String? unitReg;
  String? loc;
  // Ambulance? parent;
  AssignedUnit? assignedUnit;
  String? senior;
  String? assist01;
  String? assist02;

  Crew(
      {this.id,
      this.vehicleTotal,
      this.unitReg,
      this.loc,
      // this.parent,
      this.assignedUnit,
      this.senior,
      this.assist01,
      this.assist02});

  Crew.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleTotal = json['vehicle_total'];
    unitReg = json['unit_reg'];
    loc = json['loc'];
    // parent =
    //     json['parent'] != null ? new Ambulance.fromJson(json['parent']) : null;
    assignedUnit = json['assigned_unit'] != null
        ? new AssignedUnit.fromJson(json['assigned_unit'])
        : null;
    senior = json['senior'];
    assist01 = json['assist01'];
    assist02 = json['assist02'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vehicle_total'] = this.vehicleTotal;
    data['unit_reg'] = this.unitReg;
    data['loc'] = this.loc;
    // if (this.parent != null) {
    //   data['parent'] = this.parent!.toJson();
    // }
    if (this.assignedUnit != null) {
      data['assigned_unit'] = this.assignedUnit!.toJson();
    }
    data['senior'] = this.senior;
    data['assist01'] = this.assist01;
    data['assist02'] = this.assist02;
    return data;
  }
}
