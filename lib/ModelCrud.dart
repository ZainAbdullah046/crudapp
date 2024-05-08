class ModelCrud {
  String? sId;
  String? name;
  int? age;

  ModelCrud({this.sId, this.name, this.age});

  ModelCrud.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['age'] = this.age;
    return data;
  }
}
