import 'dart:developer';

class ApiConstants {
  static const String baseUrl = "https://sindhjipukar.vercel.app/v1/api/";
  static const String sendOtp = "auth/request-otp";
  static const String verifyOtp = "auth/verify-otp";
  static const String subscriptionPlans = "subscription-plans";
  static const String subscriptions = "subscriptions";
  static const String adSizes = "ad-sizes";
  static const String advertisements = "advertisements";

  static String getParamsFromBody(Map<String, dynamic>? body) {
    String params = '?';
    for (var i = 0; i < body!.keys.length; i++) {
      params += '${List.from(body.keys)[i]}=${List.from(body.values)[i]}';
      if (i != body.keys.length - 1) {
        params += '&';
      }
    }
    log(params);
    return params;
  }
}
