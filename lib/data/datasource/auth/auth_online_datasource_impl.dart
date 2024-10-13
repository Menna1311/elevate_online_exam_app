import 'package:elevate_online_exam_app/domain/common/api_result.dart';
import 'package:elevate_online_exam_app/data/api/api_extentions.dart';
import 'package:elevate_online_exam_app/data/api/api_manager.dart';
import 'package:elevate_online_exam_app/data/api/models/response/auth_response/auth_response/user.dart';
import 'package:elevate_online_exam_app/data/api/models/user_dto.dart';
import 'package:elevate_online_exam_app/data/contracts/auth/auth_online_datasource.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthOnlineDatasource)
class AuthOnlineDatasourceImpl implements AuthOnlineDatasource {
  ApiManager apiManager;
  AuthOnlineDatasourceImpl({required this.apiManager});

  @override
  Future<Result<String>> forgotPassword(String email) {
    return executeApi(() async {
      var result = await apiManager.fogotPassword(email);
      return result;
    });
  }

  @override
  Future<Result<bool>> verifyResetPassword(String resetCode) {
    return executeApi(() async {
      var result = await apiManager.verifyResetPassword(resetCode);
      return result;
    });
  }

  @override
  Future<Result<User?>> resetPasswprd(String email, String newPassword) {
    return executeApi(() async {
      var result = await apiManager.resetPassword(email, newPassword);
      var user = result?.user;
      var userDto = UserDto(isVerified: user?.isVerified, token: result?.token);
      return userDto.toUser();
    });
  }
}
