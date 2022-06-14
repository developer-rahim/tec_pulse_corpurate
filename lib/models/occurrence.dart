class Occurrence {
  final String? date;
  final String? reason;
  final String? department;

  Occurrence({this.date, this.reason, this.department});

  factory Occurrence.fromJson(Map<String, dynamic> json) {
    return Occurrence(
      date: json['occurrence_date'],
      reason: json['reason_for_report'],
      department: json['department'],
    );
  }
}
