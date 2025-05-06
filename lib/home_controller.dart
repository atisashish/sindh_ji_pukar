import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sindh_ji_pukar/ad_advertized_model.dart';
import 'package:sindh_ji_pukar/ad_size_model.dart' as AdSizeModel;
import 'package:sindh_ji_pukar/add_subscription_model.dart';
import 'package:sindh_ji_pukar/app_flush_bar.dart';
import 'package:sindh_ji_pukar/home_service.dart';
import 'package:sindh_ji_pukar/main.dart';
import 'package:sindh_ji_pukar/preference.dart';
import 'package:sindh_ji_pukar/send_otp_model.dart';
import 'package:sindh_ji_pukar/subscription_model.dart' as subscriptionModel;
import 'package:sindh_ji_pukar/verify_otp_model.dart';

import 'category_model.dart' as CategoryModel;

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isOtpLoading = false.obs;
  RxBool isSubscription = false.obs;
  RxBool isCategory = false.obs;
  RxBool isAdsList = false.obs;
  RxList<subscriptionModel.Data> subscriptionList =
      <subscriptionModel.Data>[].obs;
  RxList<CategoryModel.Data> categoryList = <CategoryModel.Data>[].obs;
  RxList<AdSizeModel.Data> adsList = <AdSizeModel.Data>[].obs;

  Future<void> checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    bool isLogin = await SharedPrefs.getLogin();
    if (isLogin) {
      Get.offAll(() => UserPurposeScreen());
    } else {
      Get.off(() => LoginScreen());
    }
  }

  Future<SendOtpModel> login({required String? number}) async {
    try {
      isLoading.value = true;
      Map<String, dynamic> body = {"phone": number};
      SendOtpModel user = await HomeService.login(body: body);
      isLoading.value = false;
      if (user.success == true) {
        Navigator.push(
          Get.context!,
          MaterialPageRoute(
            builder: (context) => OTPScreen(phoneNumber: number ?? ""),
          ),
        );
        AppFlushBar.success(Get.context!, message: user.data?.otp ?? "");
      } else {
        AppFlushBar.error(Get.context!, message: user.message);
      }
      return user;
    } catch (e, st) {
      print("st--->>>$st");
      isLoading.value = false;
    } finally {}
    return SendOtpModel();
  }

  Future<VerifyOtpModel> verifyOtp({
    required String? number,
    required String? otp,
  }) async {
    try {
      isOtpLoading.value = true;
      Map<String, dynamic> body = {"phone": number, "otp": otp};
      VerifyOtpModel user = await HomeService.verifyOtp(body: body);
      isOtpLoading.value = false;
      if (user.success == true) {
        Get.offAll(() => UserPurposeScreen());
        SharedPrefs.setLogin(true);
        SharedPrefs.setToken(user.token ?? "");
        AppFlushBar.success(Get.context!, message: user.message ?? "");
      } else {
        AppFlushBar.error(Get.context!, message: user.message);
      }
      return user;
    } catch (e, st) {
      print("st--->>>$st");
      isOtpLoading.value = false;
    } finally {}
    return VerifyOtpModel();
  }

  Future<AdSubscriptionModel> addSubscription({
    Map<String, dynamic>? body,
    String? amount,
  }) async {
    try {
      isOtpLoading.value = true;
      AdSubscriptionModel user = await HomeService.addSubscription(body: body);
      isOtpLoading.value = false;
      if (user.success == true) {
        // submitAd(amount: amount);
        // Get.back();
        AppFlushBar.success(Get.context!, message: user.message ?? "");
      } else {
        AppFlushBar.error(Get.context!, message: user.message);
      }
      return user;
    } catch (e, st) {
      print("st--->>>$st");
      isOtpLoading.value = false;
    } finally {}
    return AdSubscriptionModel();
  }

  Future<AdAdvertisementsModel> addAdvertisements({
    Map<String, dynamic>? body,
    String? plan,
    String? amount,
  }) async {
    try {
      isOtpLoading.value = true;
      AdAdvertisementsModel user = await HomeService.addAdvertisements(
        body: body,
      );
      isOtpLoading.value = false;
      if (user.success == true) {
        // submitAd(amount: amount);
        // Get.back();
        AppFlushBar.success(Get.context!, message: user.message ?? "");
      } else {
        AppFlushBar.error(Get.context!, message: user.message);
      }
      return user;
    } catch (e, st) {
      print("st--->>>$st");
      isOtpLoading.value = false;
    } finally {}
    return AdAdvertisementsModel();
  }

  Future<subscriptionModel.SubscriptionListModel> getSubscriptionList() async {
    try {
      isSubscription.value = true;
      subscriptionModel.SubscriptionListModel user =
          await HomeService.getSubscriptionList();
      isSubscription.value = false;
      if (user.data != []) {
        subscriptionList.value = user.data ?? [];
        print("subscriptionList--->>${subscriptionList.value}");
      } else {
        AppFlushBar.error(Get.context!, message: "Something Went Wrong");
      }
      return user;
    } catch (e, st) {
      print("st--->>>$st");
      isSubscription.value = false;
    } finally {}
    return subscriptionModel.SubscriptionListModel();
  }

  Future<CategoryModel.CategoryModel> getCategory() async {
    try {
      isSubscription.value = true;
      CategoryModel.CategoryModel user = await HomeService.getCategory();
      isSubscription.value = false;
      if (user.data != []) {
        categoryList.value = user.data ?? [];
        print("categoryList--->>${categoryList.value}");
      } else {
        AppFlushBar.error(Get.context!, message: "Something Went Wrong");
      }
      return user;
    } catch (e, st) {
      print("st--->>>$st");
      isSubscription.value = false;
    } finally {}
    return CategoryModel.CategoryModel();
  }

  Future<AdSizeModel.AdSizeModel> getAdsList() async {
    try {
      isAdsList.value = true;
      AdSizeModel.AdSizeModel user = await HomeService.getAdsList();
      isAdsList.value = false;
      if (user.data != []) {
        adsList.value = user.data ?? [];
        print("adsList--->>${adsList.value}");
      } else {
        AppFlushBar.error(Get.context!, message: "Something Went Wrong");
      }
      return user;
    } catch (e, st) {
      print("st--->>>$st");
      isAdsList.value = false;
    } finally {}
    return AdSizeModel.AdSizeModel();
  }

  Future<void> submitAd({String? amount, String? plan}) async {
    Get.to(
      () => PaymentScreen(amount: amount, plan: plan),
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void onInit() {
    getSubscriptionList();
    getAdsList();
    getCategory();
    super.onInit();
  }
}
