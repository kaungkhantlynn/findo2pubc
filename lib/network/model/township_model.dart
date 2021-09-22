import 'package:o2findermyanmar/network/model/township_data.dart';

class TownshipModel {
  List<TownshipData>? data;

  TownshipModel({this.data});

  TownshipModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(new TownshipData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
