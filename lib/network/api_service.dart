import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:o2findermyanmar/constant/key_constant.dart';
import 'package:o2findermyanmar/constant/url_constant.dart';
import 'package:o2findermyanmar/network/model/divisions_model.dart';
import 'package:o2findermyanmar/network/model/service_detail_model.dart';
import 'package:o2findermyanmar/network/model/services_model.dart';
import 'package:o2findermyanmar/network/model/township_model.dart';
import 'package:o2findermyanmar/network/model/volunteers_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  final String _endPoint = "https://api.mmc19care.com";
  static Dio dio() {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));
    dio.options.headers["api_key"] = KeyConstant.apiKey;

    return dio;
  }

  final storage = FlutterSecureStorage();

  Future<DivisionsModel> getDivisions() async {
    try {
      Response response = await dio().get(_endPoint + UrlConstants.REGIONS);
      // print(response.data);
      return DivisionsModel.fromJson(response.data);
    } on DioError catch (error) {
      throw error.response!.statusCode!;
    }
  }

  Future<TownshipModel> getTownships(int divisionId) async {
    try {
      Response response = await dio()
          .get(_endPoint + UrlConstants.TOWNSHIPS + divisionId.toString());
      return TownshipModel.fromJson(response.data);
    } on DioError catch (error) {
      throw error.response!.statusCode!;
      // print("Exception occured: $error");
    }
  }

  Future<ServicesModel> getServices(
      String divisionId, String townshipId, int page) async {
    try {
      if (townshipId == 'null') {
        Response response = await dio().get(_endPoint + UrlConstants.SERVICES,
            queryParameters: {'region': divisionId, 'page': page});
        print(response.data);
        return ServicesModel.fromJson(response.data);
      } else {
        Response response = await dio().get(_endPoint + UrlConstants.SERVICES,
            queryParameters: {
              'region': divisionId,
              'township': townshipId,
              'page': page
            });
        print(response.data);
        return ServicesModel.fromJson(response.data);
      }
    } on DioError catch (error) {
      print("PAGEERROR" + error.message);
      throw error.response!.statusCode!;
      // print("Exception occured: $error");
    }
  }

  Future<ServiceDetailModel> getServiceDetail(String id) async {
    try {
      Response response =
          await dio().get(_endPoint + UrlConstants.SERVICES_DETAIL + id);
      return ServiceDetailModel.fromJson(response.data);
    } on DioError catch (error) {
      throw error.response!.statusCode!;
      // print("Exception occured: $error");
    }
  }

  Future<VolunteersModel> getVolunteers() async {
    try {
      Response response = await dio().get(_endPoint + UrlConstants.VOLUNTEERS);
      // print(response.data);
      return VolunteersModel.fromJson(response.data);
    } on DioError catch (error) {
      throw error.response!.statusCode!;
    }
  }
}
