class TownshipData {
  int? id;
  String? name;
  int? regionId;

  TownshipData({this.id, this.name, this.regionId});

  TownshipData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    regionId = json['region_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['region_id'] = this.regionId;
    return data;
  }
}
