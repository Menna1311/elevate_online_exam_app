import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:elevate_online_exam_app/domain/common/api_result.dart';
import 'package:elevate_online_exam_app/domain/common/custom_exeption.dart';

Future<Result<T>> executeApi<T>(Future<T> Function() apiCall) async {
  try {
    var result = await apiCall.call();
    return Success(result);
  } on TimeoutException {
    return Fail(NoInternetError());
  } on IOException {
    return Fail(NoInternetError());
  } on DioException catch (ex) {
    return Fail(DioHttpException(ex));
  } on Exception catch (ex) {
    return Fail(ex);
  }
}
