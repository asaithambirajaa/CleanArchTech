import 'package:sarpl/core/core.dart';

import '../../../splash_page.dart';

abstract class AuthRemoteDatasource {
  Future<Map<String, dynamic>> getToken();
  Future<Map<String, dynamic>> commonLoginService(Map<String, dynamic> param);
}

class AuthRemoteDatasouceImpl extends AuthRemoteDatasource {
  final BaseApiService _baseApiService;

  AuthRemoteDatasouceImpl({required BaseApiService baseApiService})
      : _baseApiService = baseApiService;

  @override
  Future<Map<String, dynamic>> getToken() async {
    try {
      final url = Environment().config!.getToken;
      final res = await _baseApiService.getResponse(url,
          header: HeaderConfig().header());
      tkn.token = res.data["Token"];
      return res.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> commonLoginService(
      Map<String, dynamic> param) async {
    try {
      await getToken();
      final url = Environment().config!.login;
      final res = await _baseApiService.postResponse(
        url,
        param,
        header: HeaderConfig().header(
          isGetToken: false,
          isLogin: true,
        ),
      );
      return res.data;
    } catch (e) {
      rethrow;
    }
  }
}
