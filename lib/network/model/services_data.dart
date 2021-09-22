class ServicesData {
  String? id;
  String? name;
  bool? isActive;
  String? townshipName;
  String? regionName;
  String? updatedAt;
  String? timeAgo;

  ServicesData(
      {this.id,
      this.name,
      this.isActive,
      this.townshipName,
      this.regionName,
      this.updatedAt,
      this.timeAgo});

  ServicesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isActive = json['is_active'];
    townshipName = json['township_name'];
    regionName = json['region_name'];
    updatedAt = json['updated_at'];
    timeAgo = json['time_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['is_active'] = this.isActive;
    data['township_name'] = this.townshipName;
    data['region_name'] = this.regionName;
    data['updated_at'] = this.updatedAt;
    data['time_ago'] = this.timeAgo;
    return data;
  }
}
