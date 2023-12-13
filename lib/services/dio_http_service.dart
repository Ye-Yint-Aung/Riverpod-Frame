import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:riverpodstructure/services/http_service.dart';
import 'package:riverpodstructure/states/api_states/api_state.dart';

import '../utils/app_const.dart' as url;

class DioHttpService implements HttpService {
  DioHttpService({
    Dio? dioOverride,
    bool enableCaching = true,
  }) {
    dio = dioOverride ?? Dio(baseOptions);
  }

  /// The Dio Http client
  late final Dio dio;

  /// The Dio base options
  BaseOptions get baseOptions => BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
      );

  @override
  String get baseUrl => url.baseUrl;

  @override
  Map<String, String> headers = {'accept': 'application/json', 'content-type': 'application/json'};

  @override
  Future<ApiState> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    bool forceRefresh = false,
    String? customBaseUrl,
  }) async {
    Response response;
    try {
      // response = await dio.get<Map<String, dynamic>>(
      response = await dio.get<List<dynamic>>(
        baseUrl + endpoint,
        queryParameters: queryParameters,
      );
      log(baseUrl, name: "Base Url1");
      log(response.toString(), name: 'Response in Dio');
      print("Hey Here you.............. :${response.data}");
      //print("Hey Here you.............. :${response.data["data"]}");
      if (response.statusCode == 200) {
        return SuccessState(response.data);
        /* if (response.data["success"] == true && response.data["data"] != null) {
          return SuccessState(response.data["data"]);
        } else {
          return OtherState(response.data["data"]);
        } */
      } else {
        return ErrorState('Something went wrong!');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final response = e.response!;
        log(response.statusCode.toString(), name: "Exception status code");
        log(response.statusMessage.toString(), name: "Exception status message");
        return switch (response.statusCode) { 400 => BadState(response.data['errors']), 500 => ErrorState('Internal Server Error'), _ => ErrorState(response.statusMessage) };
      }
      throw Exception(e.error.toString());
    }
  }

  @override
  Future<ApiState> post(String endpoint, {Map<String, dynamic>? queryParameters, Object? body}) async {
    Response response;
    try {
      response = await dio.post<Map<String, dynamic>>(baseUrl + endpoint, data: body, queryParameters: queryParameters);
      log(baseUrl, name: "Base Url1");
      log(response.toString(), name: 'Response in Dio');
      print("Post Data Status Code : ${response.statusCode}");

      if (response.statusCode == 201) {
        return switch (response.data['success']) { true => SuccessState(response.data), _ => OtherState(response.data) };
      } else {
        return ErrorState('Something went wrong!');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final response = e.response!;
        log(response.statusCode.toString(), name: "Exception status code");
        log(response.statusMessage.toString(), name: "Exception status message");
        log(response.data.toString(), name: "Exception status data");
        return switch (response.statusCode) { 400 => BadState(response.data['error']), 500 => ErrorState('Internal Server Error'), _ => ErrorState(response.statusMessage) };
      }
      throw Exception(e.error.toString());
    } on SocketException catch (e) {
      log(e.message.toString());
      return TimeoutState(e.message);
    }
  }
}
