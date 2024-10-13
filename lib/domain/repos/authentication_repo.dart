import 'package:elevate_online_exam_app/domain/common/api_result.dart';
import 'package:elevate_online_exam_app/data/api/models/response/auth_response/auth_response/user.dart';

abstract class AuthenticationRepo {
  Future<Result<String>> forgotPassword(String email);
  Future<Result<bool>> verifyResetPassword(String resetCode);
  Future<Result<User?>> resetPassword(String email, String newPassword);
}
