import 'package:dio/dio.dart';
import 'package:elevate_online_exam_app/data/api/api_consts.dart';
import 'package:elevate_online_exam_app/data/api/models/response/auth_response/auth_response/auth_response.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class ApiManager {
  late Dio _dio;

  ApiManager() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConsts.baseUrl,
    ));
  }

  Future<String> fogotPassword(String email) async {
    var response =
        await _dio.post(ApiConsts.forgetPasswordPath, data: {"email": email});
    return response.data['message'];
  }

  Future<bool> verifyResetPassword(String resetCode) async {
    await _dio
        .post(ApiConsts.verifyResetCodePath, data: {"resetCode": resetCode});
    return true;
  }

  Future<AuthResponse?> resetPassword(String email, String newPassword) async {
    var response = await _dio.put(ApiConsts.resetPasswordPath,
        data: {"email": email, "newPassword": newPassword});
    return AuthResponse.fromJson(response.data);
  }
}
