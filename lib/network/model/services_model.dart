import 'package:o2findermyanmar/network/model/meta_model.dart';
import 'package:o2findermyanmar/network/model/services_data.dart';

class ServicesModel {
  List<ServicesData>? data;
  MetaModel? meta;

  ServicesModel({this.data, this.meta});

  ServicesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(new ServicesData.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new MetaModel.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta?.toJson();
    }
    return data;
  }
}
