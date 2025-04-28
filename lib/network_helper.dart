import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:sindh_ji_pukar/api_constant.dart';
import 'package:sindh_ji_pukar/app_exception.dart';

class NetworkAPICall {
  static final NetworkAPICall _networkAPICall = NetworkAPICall._internal();

  factory NetworkAPICall() {
    return _networkAPICall;
  }

  static Client get httpClient => InterceptedClient.build(
    interceptors: [LoggerInterceptor()],
    retryPolicy: ExpiredTokenRetryPolicy(),
  );

  NetworkAPICall._internal();

  static String baseUrl = ApiConstants.baseUrl;

  Future<dynamic> post(
    String url,
    dynamic body, {
    Map<String, String>? header,
  }) async {
    try {
      final String fullURL = baseUrl + url;
      log('API Url: $fullURL', level: 1);
      log('body: $body', level: 1);
      final response = await httpClient
          .post(
            Uri.parse(fullURL),
            body: body,
            headers: header,
            encoding: Encoding.getByName('utf-8'),
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              return http.Response('Error', 408);
            },
          );
      log('Response : ${response.statusCode}');
      log('Response body: ${response.body.toString()}');
      return checkResponse(response);
    } catch (e) {
      httpClient.close();
      rethrow;
    }
  }

  Future<dynamic> patch(
    String url,
    Map<String, dynamic> body, {
    Map<String, String>? header,
  }) async {
    try {
      final fullURL = baseUrl + url;
      log('API Url: $fullURL');
      log('API header: $header');
      final response = await httpClient
          .patch(Uri.parse(fullURL), body: body, headers: header)
          .timeout(
            const Duration(seconds: 20),
            onTimeout: () {
              return http.Response('Error', 408);
            },
          );
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
      return checkResponse(response);
    } catch (e) {
      httpClient.close();
      rethrow;
    }
  }

  Future<dynamic> delete(
    String url, {
    Map<String, String>? header,
    dynamic body,
  }) async {
    try {
      final String fullURL = baseUrl + url;
      final response = await httpClient
          .delete(Uri.parse(fullURL), headers: header, body: body)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              return http.Response('Error', 408);
            },
          );
      return checkResponse(response);
    } catch (e) {
      httpClient.close();
      rethrow;
    }
  }

  Future<dynamic> put(
    String url,
    dynamic body, {
    Map<String, String>? header,
  }) async {
    try {
      final String fullURL = baseUrl + url;
      log('API Url: $fullURL', level: 1);
      final response = await httpClient
          .put(Uri.parse(fullURL), body: body, headers: header)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              return http.Response(
                'Error',
                408,
              ); // Request Timeout response status code
            },
          );
      return checkResponse(response);
    } catch (e) {
      httpClient.close();
      rethrow;
    }
  }

  Future<dynamic> get(String url, {Map<String, String>? header}) async {
    try {
      final String fullURL = baseUrl + url;
      log('API Url: $fullURL');
      log('API header: $header');
      final response = await httpClient
          .get(Uri.parse(fullURL), headers: header)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              return http.Response('Error', 408);
            },
          );

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
      return checkResponse(response);
    } catch (e) {
      httpClient.close();
      rethrow;
    }
  }

  dynamic checkResponse(http.Response response) async {
    try {
      switch (response.statusCode) {
        case 200:
          try {
            return response.body.isNotEmpty ? jsonDecode(response.body) : null;
          } catch (e) {
            rethrow;
          }
        case 201:
          try {
            return response.body.isNotEmpty ? jsonDecode(response.body) : null;
          } catch (e) {
            rethrow;
          }
        case 302:
          try {
            return response.body.isNotEmpty ? jsonDecode(response.body) : null;
          } catch (e) {
            rethrow;
          }
        case 400:
          try {
            return jsonDecode(response.body);
          } catch (e) {
            rethrow;
          }
        case 401:
          try {
            return jsonDecode(response.body);
          } catch (e) {
            rethrow;
          }
        case 408:
          try {
            return jsonDecode(response.body);
          } catch (e) {
            rethrow;
          }
        case 404:
          try {
            return response.body.isNotEmpty ? jsonDecode(response.body) : null;
          } catch (e) {
            rethrow;
          }
        case 409:
          try {
            return jsonDecode(response.body);
          } catch (e) {
            rethrow;
          }
        case 422:
          try {
            return response.body.isNotEmpty ? jsonDecode(response.body) : null;
          } catch (e) {
            rethrow;
          }
        case 500:
          try {
            return response.body.isNotEmpty ? jsonEncode(response.body) : null;
          } catch (e) {
            rethrow;
          }
        default:
          try {
            if (response.body.isEmpty) {
              throw AppException(
                message: 'Response body is empty',
                errorCode: response.statusCode,
              );
            }
            final Map<String, dynamic> data = jsonDecode(response.body);
            throw AppException(
              message: "error : ${data['error']}",
              errorCode: response.statusCode,
            );
          } catch (e) {
            rethrow;
          }
      }
    } catch (e) {
      rethrow;
    }
  }
}

class LoggerInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }
}

class ExpiredTokenRetryPolicy extends RetryPolicy {
  @override
  int get maxRetryAttempts => 2;

  @override
  bool shouldAttemptRetryOnException(Exception reason) {
    return false;
  }

  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    if (response.statusCode == 401) {
      return true;
    }
    return false;
  }
}
