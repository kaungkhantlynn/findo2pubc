import 'package:o2findermyanmar/network/model/divisions_data.dart';

class DivisionsModel {
  List<DivisionsData>? data;

  DivisionsModel({this.data});

  DivisionsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DivisionsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
