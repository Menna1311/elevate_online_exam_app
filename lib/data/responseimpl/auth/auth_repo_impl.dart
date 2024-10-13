import 'package:elevate_online_exam_app/domain/common/api_result.dart';
import 'package:elevate_online_exam_app/data/api/models/response/auth_response/auth_response/user.dart';
import 'package:elevate_online_exam_app/data/contracts/auth/auth_online_datasource.dart';
import 'package:elevate_online_exam_app/domain/repos/authentication_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthenticationRepo)
class AuthRepoImpl implements AuthenticationRepo {
  final AuthOnlineDatasource _authOnlineDatasource;
  //final AuthOfflineDatasource _authOfflineDatasource;

  AuthRepoImpl(this._authOnlineDatasource);

  @override
  Future<Result<String>> forgotPassword(String email) async {
    return await _authOnlineDatasource.forgotPassword(email);
  }

  @override
  Future<Result<bool>> verifyResetPassword(String resetCode) async {
    return await _authOnlineDatasource.verifyResetPassword(resetCode);
  }

  @override
  Future<Result<User?>> resetPassword(String email, String newPassword) async {
    return await _authOnlineDatasource.resetPasswprd(email, newPassword);
  }
}
