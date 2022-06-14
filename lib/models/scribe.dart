class Scribe {
  int? id;
  String? scribeName;
  String? created;

  Scribe({this.id, this.scribeName, this.created});

  Scribe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scribeName = json['scribe_name'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['scribe_name'] = this.scribeName;
    data['created'] = this.created;
    return data;
  }
}
