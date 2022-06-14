import 'package:tacpulse/models/panic.dart';

class Ambulance {
  int? id;
  String? runId;
  String? chiefComplain;
  String? incidentCategory;
  String? ppeLvl;
  String? pickUpAddress;
  String? billingType;
  String? billingSource;
  int? amountQuoted;
  String? authorizationNumber;
  String? callerName;
  String? callerNumber;
  String? callerCompany;
  String? callReceivedTime;
  String? timeCallPostedToCrewOnWhatsapp;
  String? crewOperationalStatus;
  String? howManyUnitsDispatched;
  bool? assigned;
  bool? completed;
  bool? closed;
  String? createdOn;
  // User? user;
  Panic? panic;

  Ambulance(
      {this.id,
      this.runId,
      this.chiefComplain,
      this.incidentCategory,
      this.ppeLvl,
      this.pickUpAddress,
      this.billingType,
      this.billingSource,
      this.amountQuoted,
      this.authorizationNumber,
      this.callerName,
      this.callerNumber,
      this.callerCompany,
      this.callReceivedTime,
      this.timeCallPostedToCrewOnWhatsapp,
      this.crewOperationalStatus,
      this.howManyUnitsDispatched,
      this.assigned,
      this.completed,
      this.closed,
      this.createdOn,
      // this.user,
      this.panic});

  Ambulance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    runId = json['run_id'];
    chiefComplain = json['chief_complain'];
    incidentCategory = json['incident_category'];
    ppeLvl = json['ppe_lvl'];
    pickUpAddress = json['pick_up_address'];
    billingType = json['billing_type'];
    billingSource = json['billing_source'];
    amountQuoted = json['amount_quoted'];
    authorizationNumber = json['authorization_number'];
    callerName = json['caller_name'];
    callerNumber = json['caller_number'];
    callerCompany = json['caller_company'];
    callReceivedTime = json['call_received_time'];
    timeCallPostedToCrewOnWhatsapp =
        json['time_call_posted_to_crew_on_whatsapp'];
    crewOperationalStatus = json['crew_operational_status'];
    howManyUnitsDispatched = json['how_many_units_dispatched'];
    assigned = json['assigned'];
    completed = json['completed'];
    closed = json['closed'];
    createdOn = json['created_on'];
    // user = json['user'] != null ? new User.fromJson(json['user']) : null;
    panic = json['panic'] != null ? new Panic.fromJson(json['panic']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['run_id'] = this.runId;
    data['chief_complain'] = this.chiefComplain;
    data['incident_category'] = this.incidentCategory;
    data['ppe_lvl'] = this.ppeLvl;
    data['pick_up_address'] = this.pickUpAddress;
    data['billing_type'] = this.billingType;
    data['billing_source'] = this.billingSource;
    data['amount_quoted'] = this.amountQuoted;
    data['authorization_number'] = this.authorizationNumber;
    data['caller_name'] = this.callerName;
    data['caller_number'] = this.callerNumber;
    data['caller_company'] = this.callerCompany;
    data['call_received_time'] = this.callReceivedTime;
    data['time_call_posted_to_crew_on_whatsapp'] =
        this.timeCallPostedToCrewOnWhatsapp;
    data['crew_operational_status'] = this.crewOperationalStatus;
    data['how_many_units_dispatched'] = this.howManyUnitsDispatched;
    data['assigned'] = this.assigned;
    data['completed'] = this.completed;
    data['closed'] = this.closed;
    data['created_on'] = this.createdOn;
    // if (this.user != null) {
    //   data['user'] = this.user!.toJson();
    // }
    if (this.panic != null) {
      data['panic'] = this.panic!.toJson();
    }
    return data;
  }
}
