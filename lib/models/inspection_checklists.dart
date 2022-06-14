class InspectionChecklists {
  final String? type;
  final String? output;
  final String? detail;

  InspectionChecklists({this.type, this.detail, this.output});

  factory InspectionChecklists.fromJson(Map<String, dynamic> json) {
    return InspectionChecklists(
      type: json['inspection_type'],
      output: json['inspection_output'],
      detail: json['inspection_detail'],
    );
  }
}
