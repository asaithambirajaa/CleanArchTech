import 'package:dio/dio.dart';

abstract class BaseApiService {
  Future<Response> getResponse(String url,
      {required Map<String, String> header, List<String>? requestData});
  Future<Response> postResponse(String url, Map<String, dynamic> requestData,
      {Map<String, String>? header});
  Future<Response> postMethod(String url, String requestData,
      {required Map<String, String> header});
}
