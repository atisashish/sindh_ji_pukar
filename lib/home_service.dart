import 'dart:convert';
import 'dart:developer';

import 'package:sindh_ji_pukar/ad_advertized_model.dart';
import 'package:sindh_ji_pukar/ad_size_model.dart';
import 'package:sindh_ji_pukar/add_subscription_model.dart';
import 'package:sindh_ji_pukar/api_constant.dart';
import 'package:sindh_ji_pukar/network_helper.dart';
import 'package:sindh_ji_pukar/preference.dart';
import 'package:sindh_ji_pukar/send_otp_model.dart';
import 'package:sindh_ji_pukar/subscription_model.dart';
import 'package:sindh_ji_pukar/verify_otp_model.dart';

class HomeService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<SendOtpModel> login({
    required Map<String, dynamic> body,
  }) async {
    try {
      final request = await _networkAPICall.post(
        header: {'Content-Type': 'application/json'},
        ApiConstants.sendOtp,
        jsonEncode(body),
      );
      if (request != null) {
        return SendOtpModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return SendOtpModel();
  }

  static Future<VerifyOtpModel> verifyOtp({
    required Map<String, dynamic> body,
  }) async {
    try {
      final request = await _networkAPICall.post(
        header: {'Content-Type': 'application/json'},
        ApiConstants.verifyOtp,
        jsonEncode(body),
      );
      if (request != null) {
        return VerifyOtpModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return VerifyOtpModel();
  }

  static Future<AdSubscriptionModel> addSubscription({
    required Map<String, dynamic>? body,
  }) async {
    String token = await SharedPrefs.getToken();
    try {
      final request = await _networkAPICall.post(
        header: {
          'Content-Type': 'application/json',
          "Authorization": 'Bearer $token',
        },
        ApiConstants.subscriptions,
        jsonEncode(body),
      );
      if (request != null) {
        return AdSubscriptionModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return AdSubscriptionModel();
  }

  static Future<AdAdvertisementsModel> addAdvertisements({
    required Map<String, dynamic>? body,
  }) async {
    String token = await SharedPrefs.getToken();
    try {
      final request = await _networkAPICall.post(
        header: {
          'Content-Type': 'application/json',
          "Authorization": 'Bearer $token',
        },
        ApiConstants.advertisements,
        jsonEncode(body),
      );
      if (request != null) {
        return AdAdvertisementsModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return AdAdvertisementsModel();
  }

  static Future<SubscriptionListModel> getSubscriptionList() async {
    try {
      // String token = await SharedPrefs.getToken();
      final request = await _networkAPICall.get(
        ApiConstants.subscriptionPlans,
        header: {
          "Content-Type": "application/json",
          // "Authorization": 'Bearer $token',
        },
      );
      if (request != null) {
        return SubscriptionListModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return SubscriptionListModel();
  }

  static Future<AdSizeModel> getAdsList() async {
    try {
      final request = await _networkAPICall.get(
        ApiConstants.adSizes,
        header: {"Content-Type": "application/json"},
      );
      if (request != null) {
        return AdSizeModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return AdSizeModel();
  }
}
