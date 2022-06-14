class AssignedUnit {
  int? id;
  String? uniName;

  AssignedUnit({this.id, this.uniName});

  AssignedUnit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniName = json['uni_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uni_name'] = this.uniName;
    return data;
  }
}
