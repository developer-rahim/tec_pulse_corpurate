class MonthlyPaystub {
  final String? uploadDate;
  final String? fileLink;
  final String? amount;

  MonthlyPaystub({
    this.uploadDate,
    this.fileLink,
    this.amount,
  });

  factory MonthlyPaystub.fromJson(Map<String, dynamic> json) {
    return MonthlyPaystub(
      uploadDate: json['created_on'],
      fileLink: json['file'],
      amount: json['amount'],
    );
  }
}
