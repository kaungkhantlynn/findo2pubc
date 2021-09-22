import 'package:o2findermyanmar/network/model/volunteers_data.dart';

class VolunteersModel {
  List<VolunteerData>? data;

  VolunteersModel({this.data});

  VolunteersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(new VolunteerData.fromJson(v));
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
