class DivisionsData {
  int? id;
  String? name;

  DivisionsData({this.id, this.name});

  DivisionsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
