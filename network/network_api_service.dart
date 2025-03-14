import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../core.dart';

class NetworkApiService extends BaseApiService {
  final Dio client;
  NetworkApiService(this.client);
  @override
  Future<Response> getResponse(
    String url, {
    required Map<String, String> header,
    List<String>? requestData,
  }) async {
    try {
      final res = await client.get(
        url,
        data: requestData,
        options: Options(
          headers: header,
        ),
      );
      return returnResponse(res);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> postResponse(String url, Map<String, dynamic> requestData,
      {Map<String, String>? header}) async {
    try {
      final res = await client.post(
        url,
        options: Options(
          headers: header,
        ),
        data: requestData,
      );
      return returnResponse(res);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> postMethod(String url, String requestData,
      {required Map<String, String> header}) async {
    var data = json.encode(requestData);
    try {
      final res = await client.post(
        url,
        options: Options(
          headers: header,
        ),
        data: data,
      );
      return returnResponse(res);
    } catch (e) {
      rethrow;
    }
  }

  Response returnResponse(Response response) {
    log(response.toString());
    switch (response.statusCode) {
      case 200:
        return Response(
          data: response.data,
          requestOptions: RequestOptions(data: response.data),
          statusCode: response.statusCode,
          statusMessage: response.statusMessage,
          extra: response.extra,
          headers: response.headers,
        );

      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.data.toString());
      case 404:
        throw UnauthorisedException(response.data.toString());
      case 500:
        throw InternalServerException(response.data.toString());
      default:
        throw "";
    }
  }
}
