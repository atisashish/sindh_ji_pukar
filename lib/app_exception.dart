import 'dart:io';

import 'package:get/get.dart';
import 'package:sindh_ji_pukar/app_flush_bar.dart';

class AppException implements Exception {
  late String message;
  String? tag;
  int errorCode;

  AppException({required this.message, required this.errorCode, this.tag});

  int getErrorCode() => errorCode;

  String getMessage() => message;

  String getMessageWithTag() => "${tag ?? 'No Tag'} : $message";

  String? getTag() => tag;

  @override
  String toString() {
    return "${errorCode.toString()} : ${tag ?? 'No Tag'} : $message";
  }

  static void showException(dynamic exception, [dynamic stackTrace]) {
    if (exception is AppException) {
      exception.show();
    } else if (exception is SocketException) {
      AppException(
        message: exception.message,
        errorCode: exception.osError?.errorCode ?? 0,
      ).show();
    } else if (exception is HttpException) {
      AppException(
        message: "Couldn't find the requested data",
        errorCode: 0,
      ).show();
    } else if (exception is FormatException) {
      AppException(message: "Bad response format", errorCode: 0).show();
    } else {
      AppException(message: "Something went wrong", errorCode: 0).show();
    }
  }

  void show() {
    AppFlushBar.error(Get.context!, message: message);
  }
}
