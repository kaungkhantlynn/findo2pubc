class ServiceDetailModel {
  Data? data;

  ServiceDetailModel({this.data});

  ServiceDetailModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? name;
  List<String>? phones;
  String? types;
  bool? isActive;
  Region? region;
  String? town;
  double? fees;
  Township? township;
  String? address;
  String? updatedAt;
  String? timeAgo;

  Data(
      {this.id,
      this.name,
      this.phones,
      this.types,
      this.isActive,
      this.region,
      this.town,
      this.fees,
      this.township,
      this.address,
      this.updatedAt,
      this.timeAgo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phones = json['phones'].cast<String>();
    types = json['types'];
    isActive = json['is_active'];
    region =
        json['region'] != null ? new Region.fromJson(json['region']) : null;
    town = json['town'];
    township = json['township'] != null
        ? new Township.fromJson(json['township'])
        : null;
    address = json['address'];
    updatedAt = json['updated_at'];
    timeAgo = json['time_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phones'] = this.phones;
    data['types'] = this.types;
    data['is_active'] = this.isActive;
    if (this.region != null) {
      data['region'] = this.region?.toJson();
    }
    data['town'] = this.town;
    if (this.township != null) {
      data['township'] = this.township?.toJson();
    }
    data['address'] = this.address;
    data['updated_at'] = this.updatedAt;
    data['time_ago'] = this.timeAgo;
    return data;
  }
}

class Region {
  int? id;
  String? name;
  String? pcode;
  String? type;
  String? lat;
  String? lng;

  Region({this.id, this.name, this.pcode, this.type, this.lat, this.lng});

  Region.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pcode = json['pcode'];
    type = json['type'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['pcode'] = this.pcode;
    data['type'] = this.type;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Township {
  int? id;
  String? name;
  String? pcode;
  int? regionId;
  String? lat;
  String? lng;

  Township({this.id, this.name, this.pcode, this.regionId, this.lat, this.lng});

  Township.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pcode = json['pcode'];
    regionId = json['region_id'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['pcode'] = this.pcode;
    data['region_id'] = this.regionId;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
