class Faq {
  final String? question;
  final String? answer;

  Faq({this.question, this.answer});

  factory Faq.fromJson(Map<String, dynamic> json) {
    return Faq(
      question: json['ques'],
      answer: json['ans'],
    );
  }
}
