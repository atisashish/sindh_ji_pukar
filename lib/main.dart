import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sindh_ji_pukar/home_controller.dart';
import 'package:sindh_ji_pukar/send_otp_model.dart' as subscriptionModel;

void main() {
  runApp(const MyApp());
}

// 1. Auth Controller
class AuthController extends GetxController {
  final Rx<bool> isLoading = false.obs;
  final Rx<bool> isLoggedIn = false.obs;

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
    Get.to(() => OTPScreen(phoneNumber: phoneNumber));
  }

  Future<void> verifyOTP(String smsCode) async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoggedIn.value = true;
    isLoading.value = false;
    Get.offAll(() => UserPurposeScreen()); // Changed to show purpose selection
  }

  void logout() {
    isLoggedIn.value = false;
    Get.offAll(() => LoginScreen());
  }
}

// 2. Subscription Model
class SubscriptionPlan {
  final String id;
  final String name;
  final String price;
  final String duration;
  final List<String> features;

  SubscriptionPlan({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
    required this.features,
  });
}

// 3. Subscription Controller
class SubscriptionController extends GetxController {
  RxList<subscriptionModel.Data> subscriptionList =
      <subscriptionModel.Data>[].obs;
  final RxList<SubscriptionPlan> plans =
      <SubscriptionPlan>[
        SubscriptionPlan(
          id: '1',
          name: 'Basic',
          price: '\$4.99',
          duration: 'month',
          features: ['Access to all news', 'Daily updates', 'Basic support'],
        ),
        SubscriptionPlan(
          id: '2',
          name: 'Premium',
          price: '\$9.99',
          duration: 'month',
          features: [
            'Access to all news',
            'Instant updates',
            'Premium content',
            'Ad-free experience',
            'Priority support',
          ],
        ),
        SubscriptionPlan(
          id: '3',
          name: 'Annual',
          price: '\$49.99',
          duration: 'year',
          features: [
            'All Premium features',
            'Save 50%',
            'Exclusive content',
            'Early access to features',
          ],
        ),
      ].obs;

  final Rx<SubscriptionPlan?> selectedPlan = Rx<SubscriptionPlan?>(null);
  final Rx<bool> isSubscribed = false.obs;

  void selectPlan(SubscriptionPlan plan) {
    selectedPlan.value = plan;
  }

  void subscribe() {
    if (selectedPlan.value != null) {
      isSubscribed.value = true;
      Get.back();
      Get.snackbar(
        'Success',
        'You have subscribed to ${selectedPlan.value!.name} plan',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

// 4. Advertisement Model
class Advertisement {
  final String id;
  final String title;
  final String description;
  final String contactInfo;
  final String adSize;
  final String category;
  final String duration;
  final List<String> images;
  final String userId;
  final DateTime createdAt;
  final String status;

  Advertisement({
    required this.id,
    required this.title,
    required this.description,
    required this.contactInfo,
    required this.adSize,
    required this.category,
    required this.duration,
    required this.images,
    required this.userId,
    required this.createdAt,
    this.status = "pending",
  });
}

// 6. News Article Model
class NewsArticle {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String source;
  final String publishedAt;
  final String category;
  final String content;

  NewsArticle({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.source,
    required this.publishedAt,
    required this.category,
    required this.content,
  });
}

// 7. News Controller
class NewsController extends GetxController {
  final RxList<NewsArticle> featuredArticles =
      <NewsArticle>[
        NewsArticle(
          id: '1',
          title: 'Global Climate Summit Reaches Historic Agreement',
          description:
              'World leaders have agreed on unprecedented measures to combat climate change.',
          imageUrl:
              'https://images.unsplash.com/photo-1615751072497-5f5169febe17?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
          source: 'Global News',
          publishedAt: '2 hours ago',
          category: 'Environment',
          content:
              'In a landmark decision at the Global Climate Summit, world leaders from over 190 countries have agreed on unprecedented measures to combat climate change.',
        ),
        NewsArticle(
          id: '2',
          title: 'Tech Giant Unveils Revolutionary AI Assistant',
          description:
              'The new AI system can understand and respond to complex human emotions.',
          imageUrl:
              'https://enterprisewired.com/wp-content/uploads/2024/02/Googles-AI-Revolution_-Unveiling-Gemini-as-the-Singular-Force-15-02-2024-SOURCE-LinkedIn-1.jpg',
          source: 'Tech Today',
          publishedAt: '5 hours ago',
          category: 'Technology',
          content:
              'At its annual developer conference, the tech giant unveiled a revolutionary AI assistant that can understand and respond to complex human emotions.',
        ),
      ].obs;

  final RxList<NewsArticle> trendingArticles =
      <NewsArticle>[
        NewsArticle(
          id: '4',
          title: 'Stock Markets Reach All-Time High',
          description:
              'Global markets surge as economic recovery exceeds expectations.',
          imageUrl:
              'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
          source: 'Financial Times',
          publishedAt: '3 hours ago',
          category: 'Business',
          content:
              'Global stock markets soared to record highs today as economic recovery indicators exceeded all expectations.',
        ),
      ].obs;

  final RxList<String> categories =
      [
        'All',
        'Technology',
        'Business',
        'Health',
        'Sports',
        'Entertainment',
        'Science',
        'Politics',
      ].obs;

  final RxString selectedCategory = 'All'.obs;
  final Rx<NewsArticle?> selectedArticle = Rx<NewsArticle?>(null);

  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  void selectArticle(NewsArticle article) {
    selectedArticle.value = article;
    Get.to(
      () => NewsDetailScreen(),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 600),
    );
  }
}

// 8. Login Screen
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final HomeController homeController = Get.put(HomeController());
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Hero(
                tag: 'app-logo',
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade100,
                        blurRadius: 15,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Image.asset('assets/logo.png', height: 80),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                '🌟 Welcome to Sindh Ji Pukar!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Join our community of informed citizens',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade100,
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: '📱 Mobile Number',
                    hintText: 'Please Enter Your Number',
                    prefixText: '+91 ',
                    prefixStyle: const TextStyle(fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    suffixIcon:
                        phoneController.text.isNotEmpty
                            ? IconButton(
                              icon: const Icon(Icons.clear, color: Colors.grey),
                              onPressed: () => phoneController.clear(),
                            )
                            : null,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Obx(
                () =>
                    homeController.isLoading.value
                        ? const CircularProgressIndicator()
                        : SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (phoneController.text.length == 10) {
                                homeController.login(
                                  number: phoneController.text,
                                );
                              } else {
                                Get.snackbar(
                                  '⚠️ Oops!',
                                  'Please enter a valid 10-digit phone number',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red.shade100,
                                  colorText: Colors.red.shade800,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue.shade600,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 3,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.send_rounded, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  'Send OTP',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
              ),
              const SizedBox(height: 20),
              // TextButton(
              //   onPressed: () => Get.offAll(() => HomeScreen()),
              //   child: const Text(
              //     'Skip for now ➡️',
              //     style: TextStyle(color: Colors.blue, fontSize: 16),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// 9. OTP Screen
class OTPScreen extends StatelessWidget {
  final String phoneNumber;

  OTPScreen({super.key, required this.phoneNumber});

  final AuthController authController = Get.put(AuthController());
  final HomeController homeController = Get.put(HomeController());
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Center(
              child: Text(
                'Verify +91${phoneNumber.substring(0, 5)}*****',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: const Text(
                'Enter the 4-digit OTP sent to your phone',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Pinput(
                length: 4,
                controller: otpController,
                defaultPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                showCursor: true,
                onCompleted: (pin) {
                  homeController.verifyOtp(
                    number: phoneNumber,
                    otp: otpController.text,
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            Obx(
              () =>
                  homeController.isOtpLoading.value
                      ? const CircularProgressIndicator()
                      : TextButton(
                        onPressed: () {
                          homeController.login(number: phoneNumber);
                        },
                        child: const Text('Resend OTP'),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}

// 10. User Purpose Screen
class UserPurposeScreen extends StatelessWidget {
  UserPurposeScreen({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo.png", width: 200, height: 200),
              const Text(
                'Welcome to Sindh Ji Pukar!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'What would you like to do today?',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),

              // Card for Reading News
              _buildPurposeCard(
                icon: homeController.categoryList.value[0].image ?? "",
                title: homeController.categoryList.value[0].title ?? "",
                description:
                    homeController.categoryList.value[0].description ?? "",
                color: Colors.blue,
                onTap: () => Get.to(() => AdSubmissionScreen()),
                // onTap: () => Get.offAll(() => HomeScreen()),
              ),
              const SizedBox(height: 20),

              // Card for Publishing Ads
              _buildPurposeCard(
                icon: homeController.categoryList.value[1].image ?? "",
                title: homeController.categoryList.value[1].title ?? "",
                description:
                    homeController.categoryList.value[1].description ?? "",
                color: Colors.green,
                onTap: () => Get.to(() => SubscribeScreen()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPurposeCard({
    required String icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            children: [
              CachedNetworkImage(imageUrl: icon, height: 50, width: 50),
              // Icon(icon, size: 50, color: color),
              const SizedBox(height: 15),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 11. Ad Submission Screen
class AdSubmissionScreen extends StatefulWidget {
  const AdSubmissionScreen({super.key});

  @override
  State<AdSubmissionScreen> createState() => _AdSubmissionScreenState();
}

class _AdSubmissionScreenState extends State<AdSubmissionScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());
  final HomeController homeController = Get.put(HomeController());

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _gstController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  String _selectedPrice = '';
  String? _selectedPlanId = '';
  String _selectedPaymentMethod = 'cod';

  @override
  void initState() {
    _selectedPrice = homeController.subscriptionList.first.price.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Subscription')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Subscription Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  hintText: 'Enter Your Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Shop Name',
                  border: OutlineInputBorder(),
                  hintText: 'Shop Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a shop name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  hintText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Provide Address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // TextFormField(
              //   controller: _numberController,
              //   decoration: const InputDecoration(
              //     labelText: 'Mobile',
              //     hintText: 'Mobile',
              //     border: OutlineInputBorder(),
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please Provide Mobile Number';
              //     }
              //     return null;
              //   },
              // ),
              // const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Provide Email Address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _gstController,
                decoration: const InputDecoration(
                  labelText: 'GST',
                  hintText: 'GST',
                  border: OutlineInputBorder(),
                ),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please Provide GST Number';
                //   }
                //   return null;
                // },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _numberController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: const InputDecoration(
                  labelText: 'Mobile Number',
                  hintText: 'Mobile Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Your Number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Subscription',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              DropdownButtonFormField<String>(
                value:
                    homeController.subscriptionList.isNotEmpty
                        ? homeController.subscriptionList.first.name
                        : null,
                items:
                    homeController.subscriptionList.map((data) {
                      return DropdownMenuItem<String>(
                        value: data.name ?? '',
                        child: Text(data.name ?? 'No Name'),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      final selectedData = homeController.subscriptionList
                          .firstWhere((element) => element.name == value);
                      _selectedPrice = selectedData.price?.toString() ?? '0';
                      _selectedPlanId = selectedData.sId ?? '';
                      print('✅ Selected Price: $_selectedPrice');
                      print('✅ Selected PlanId: $_selectedPlanId');
                    }
                  });
                },
                decoration: const InputDecoration(border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a subscription plan';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              const Text(
                'Price',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                value: _selectedPrice,
                items: [
                  DropdownMenuItem(
                    value: _selectedPrice,
                    child: Text(_selectedPrice),
                  ),
                ],
                onChanged: null,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Price not available';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Select Payment Method',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedPaymentMethod = 'cod';
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              _selectedPaymentMethod == 'cod'
                                  ? Colors.green[50]
                                  : Colors.white,
                          border: Border.all(
                            color:
                                _selectedPaymentMethod == 'cod'
                                    ? Colors.green
                                    : Colors.grey.shade300,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow:
                              _selectedPaymentMethod == 'cod'
                                  ? [
                                    BoxShadow(
                                      color: Colors.green.withOpacity(0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                  : [],
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.money, size: 30, color: Colors.green),
                            const SizedBox(height: 8),
                            Text(
                              'Cash',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color:
                                    _selectedPaymentMethod == 'cod'
                                        ? Colors.green
                                        : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedPaymentMethod = 'upi';
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              _selectedPaymentMethod == 'upi'
                                  ? Colors.blue[50]
                                  : Colors.white,
                          border: Border.all(
                            color:
                                _selectedPaymentMethod == 'upi'
                                    ? Colors.blue
                                    : Colors.grey.shade300,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow:
                              _selectedPaymentMethod == 'upi'
                                  ? [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                  : [],
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.payment, size: 30, color: Colors.blue),
                            const SizedBox(height: 8),
                            Text(
                              'Online Payment',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color:
                                    _selectedPaymentMethod == 'upi'
                                        ? Colors.blue
                                        : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Obx(
                () =>
                    homeController.isOtpLoading.value
                        ? Center(
                          child: CircularProgressIndicator(strokeWidth: 1),
                        )
                        : SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Map<String, dynamic> body = {
                                  "name": _titleController.text,
                                  "shopName": _descriptionController.text,
                                  "address": _contactController.text,
                                  "email": _emailController.text,
                                  "gst": _gstController.text,
                                  "phone": _numberController.text,
                                  "planId": _selectedPlanId,
                                  "paymentType": _selectedPaymentMethod,
                                };
                                if (_selectedPaymentMethod == 'cod') {
                                  homeController.addSubscription(body: body);
                                  Get.back();
                                } else {
                                  homeController.addSubscription(body: body);
                                  Get.to(
                                    () => PaymentScreen(
                                      amount: _selectedPrice,
                                      // advertisementData: body,
                                    ),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Subscribe',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add Image'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Take Photo'),
                  onTap: () {
                    Get.back();
                    // Implement camera functionality
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Choose from Gallery'),
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
    );
  }
}

// 12. Subscription Screen
class SubscriptionScreen extends StatelessWidget {
  SubscriptionScreen({super.key});

  final SubscriptionController subController = Get.put(
    SubscriptionController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(onTap: Get.back, child: const Icon(Icons.arrow_back)),
                  const SizedBox(width: 25),
                  const Text(
                    '✨ Unlock Premium Features',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GetBuilder<SubscriptionController>(
                builder: (controller) {
                  return Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: controller.plans.length,
                      separatorBuilder:
                          (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final plan = controller.plans[index];
                        final isSelected =
                            controller.selectedPlan.value?.id == plan.id;

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? Colors.blue.withOpacity(0.1)
                                    : Colors.white,
                            border: Border.all(
                              color:
                                  isSelected
                                      ? Colors.blue
                                      : Colors.grey.shade200,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              controller.selectPlan(plan);
                              controller.update();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(_getPlanEmoji(plan.name)),
                                          const SizedBox(width: 12),
                                          Text(
                                            plan.name,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getPlanColor(plan.name),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Text(
                                          '${plan.price}/${plan.duration}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  ...plan.features.map(
                                    (feature) => Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.check_circle_rounded,
                                            color: Colors.green,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(child: Text(feature)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.shade50,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: const Text(
                                          '✅ Selected',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              GetBuilder<SubscriptionController>(
                builder: (controller) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          controller.selectedPlan.value != null
                              ? () {
                                controller.subscribe();
                                Get.snackbar(
                                  '🎉 Subscription Successful',
                                  'You\'ve unlocked premium features!',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.green.shade100,
                                );
                              }
                              : null,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor:
                            controller.selectedPlan.value != null
                                ? _getPlanColor(
                                  controller.selectedPlan.value!.name,
                                )
                                : Colors.grey,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        controller.selectedPlan.value != null
                            ? '🚀 Subscribe to ${controller.selectedPlan.value!.name}'
                            : 'Select a Plan',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getPlanEmoji(String planName) {
    switch (planName) {
      case 'Basic':
        return '📌';
      case 'Premium':
        return '⭐';
      case 'Annual':
        return '🏆';
      default:
        return '📋';
    }
  }

  Color _getPlanColor(String planName) {
    switch (planName) {
      case 'Basic':
        return Colors.blue.shade400;
      case 'Premium':
        return Colors.purple.shade400;
      case 'Annual':
        return Colors.orange.shade400;
      default:
        return Colors.blue.shade400;
    }
  }
}

// 13. News Detail Screen
class NewsDetailScreen extends StatelessWidget {
  NewsDetailScreen({super.key});

  final NewsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'news-image-${controller.selectedArticle.value?.id}',
                child: CachedNetworkImage(
                  imageUrl: controller.selectedArticle.value?.imageUrl ?? '',
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(color: Colors.white),
                      ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.selectedArticle.value?.category.toUpperCase() ??
                        '',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    controller.selectedArticle.value?.title ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        controller.selectedArticle.value?.source ?? '',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      const Spacer(),
                      Text(
                        controller.selectedArticle.value?.publishedAt ?? '',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Text(
                    controller.selectedArticle.value?.content ?? '',
                    style: const TextStyle(fontSize: 16, height: 1.6),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Related News',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 200,
                    child: Obx(
                      () => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.featuredArticles.length,
                        itemBuilder: (context, index) {
                          final article = controller.featuredArticles[index];
                          if (article.id ==
                              controller.selectedArticle.value?.id) {
                            return const SizedBox.shrink();
                          }
                          return GestureDetector(
                            onTap: () => controller.selectArticle(article),
                            child: Container(
                              width: 180,
                              margin: const EdgeInsets.only(right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Hero(
                                      tag: 'news-image-${article.id}',
                                      child: CachedNetworkImage(
                                        imageUrl: article.imageUrl,
                                        height: 100,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        placeholder:
                                            (context, url) =>
                                                Shimmer.fromColors(
                                                  baseColor: Colors.grey[300]!,
                                                  highlightColor:
                                                      Colors.grey[100]!,
                                                  child: Container(
                                                    height: 100,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    article.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.bookmark_border),
      ),
    );
  }
}

// 14. Home Screen
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final AuthController authController = Get.put(AuthController());
  final SubscriptionController subController = Get.put(
    SubscriptionController(),
  );
  final NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sindh Ji Pukar'),
        actions: [
          PopupMenuButton(
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    child: const Text('Subscription'),
                    onTap: () => Get.to(() => SubscriptionScreen()),
                  ),
                  PopupMenuItem(
                    child: const Text('Logout'),
                    onTap: () => authController.logout(),
                  ),
                ],
          ),
        ],
      ),
      body: Obx(() {
        if (!subController.isSubscribed.value) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.blue.shade50,
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'Subscribe to unlock premium features',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.to(() => SubscriptionScreen()),
                      child: const Text('Upgrade Now'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCategories(),
                      const SizedBox(height: 20),
                      _buildFeaturedSection(),
                      const SizedBox(height: 25),
                      _buildTrendingSection(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCategories(),
                const SizedBox(height: 20),
                _buildFeaturedSection(),
                const SizedBox(height: 25),
                _buildTrendingSection(),
                const SizedBox(height: 20),
                _buildPremiumContent(),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildPremiumContent() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Premium Content',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 50,
      child: Obx(
        () => ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: newsController.categories.length,
          itemBuilder: (context, index) {
            final category = newsController.categories[index];
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Obx(
                () => ChoiceChip(
                  label: Text(category),
                  selected: newsController.selectedCategory.value == category,
                  selectedColor: Colors.blue[100],
                  onSelected: (selected) {
                    if (selected) {
                      newsController.changeCategory(category);
                    }
                  },
                  labelStyle: TextStyle(
                    color:
                        newsController.selectedCategory.value == category
                            ? Colors.blue
                            : Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Featured Stories',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 280,
          child: Obx(
            () => ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 20),
              itemCount: newsController.featuredArticles.length,
              itemBuilder: (context, index) {
                final article = newsController.featuredArticles[index];
                return GestureDetector(
                  onTap: () => newsController.selectArticle(article),
                  child: Hero(
                    tag: 'news-image-${article.id}',
                    child: _buildFeaturedCard(article),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedCard(NewsArticle article) {
    return Container(
      width: 260,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: CachedNetworkImage(
              imageUrl: article.imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder:
                  (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(height: 150, color: Colors.white),
                  ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.category.toUpperCase(),
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  article.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      article.source,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    const Spacer(),
                    Text(
                      article.publishedAt,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Trending Now',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: newsController.trendingArticles.length,
              itemBuilder: (context, index) {
                final article = newsController.trendingArticles[index];
                return GestureDetector(
                  onTap: () => newsController.selectArticle(article),
                  child: Hero(
                    tag: 'news-image-${article.id}',
                    child: _buildTrendingItem(article),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingItem(NewsArticle article) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(12),
            ),
            child: CachedNetworkImage(
              imageUrl: article.imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              placeholder:
                  (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.white,
                    ),
                  ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.category.toUpperCase(),
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        article.source,
                        style: TextStyle(color: Colors.grey[600], fontSize: 10),
                      ),
                      const Spacer(),
                      Text(
                        article.publishedAt,
                        style: TextStyle(color: Colors.grey[600], fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 15. Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    homeController.checkAuthStatus();
    // Future.delayed(const Duration(seconds: 2), () {
    //   Get.off(() => LoginScreen());
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade700,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'app-logo',
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 3,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Image.asset("assets/logo.png", width: 100, height: 100),
              ),
            ),
            const SizedBox(height: 30),
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 1000),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 20 - (20 * value)),
                    child: const Text(
                      'Sindh Ji Pukar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 20 - (20 * value)),
                    child: const Text(
                      'Stay informed with the latest news',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// 16. Main App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sindh Ji Pukar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// 17. Payment Screen
class PaymentScreen extends StatelessWidget {
  String? plan;
  String? amount;

  PaymentScreen({super.key, this.amount, this.plan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Animated Header
              _buildAnimatedHeader(),
              const SizedBox(height: 30),

              // QR Code Container with shimmer animation
              _buildQrCodeContainer(),
              const SizedBox(height: 30),

              // Payment Details
              _buildPaymentDetails(),
              const SizedBox(height: 30),

              // Payment Buttons
              _buildPaymentButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedHeader() {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 800),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - value)),
            child: Column(
              children: [
                Text(
                  'Scan to Pay',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Use any UPI app to scan the QR code',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQrCodeContainer() {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.elasticOut,
      tween: Tween<double>(begin: 0.5, end: 1),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade100,
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                // Static QR Code Image
                Image.asset('assets/qr_code.jpeg', height: 200, width: 200),
                const SizedBox(height: 20),
                Text(
                  'Sindh Ji Pukar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'UPI ID: sindhjipukar@upi',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentDetails() {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1200),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  _buildDetailRow('Subscription Plan', plan ?? ""),
                  const Divider(height: 30),
                  _buildDetailRow(
                    'Amount',
                    '₹${amount?.replaceAll("Rs.", '') ?? ''}.00',
                  ),
                  const Divider(height: 30),
                  // _buildDetailRow('Validity', plan ?? ""),
                  // const Divider(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Payable',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Text(
                        '₹${amount?.replaceAll("Rs.", '') ?? ''}.00',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentButtons() {
    return Column(
      children: [
        TweenAnimationBuilder(
          duration: const Duration(milliseconds: 1500),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 40 * (1 - value)),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _showPaymentSuccessDialog();
                      Future.delayed(Duration(seconds: 2), () {
                        Get.back();
                        Get.offAll(() => UserPurposeScreen());
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 15),
        TweenAnimationBuilder(
          duration: const Duration(milliseconds: 1700),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 40 * (1 - value)),
                child: TextButton(
                  onPressed: () => Get.back(),
                  child: const Text(
                    'Cancel Payment',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showPaymentSuccessDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 800),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 80,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Payment Successful!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Your subscription has been activated',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Get.offAll(UserPurposeScreen());
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.blue,
            //       padding: const EdgeInsets.symmetric(vertical: 14),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //     ),
            //     child: const Text(
            //       'Continue',
            //       style: TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}

// 18. Subscription Screen

class SubscribeScreen extends StatefulWidget {
  const SubscribeScreen({super.key});

  @override
  State<SubscribeScreen> createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());
  final HomeController homeController = Get.put(HomeController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _gstController = TextEditingController();
  String _selectedPlanId = '';
  String _adPricesSize = '';
  String _selectedPaymentMethod = 'cod';

  @override
  void initState() {
    _adPricesSize = homeController.adsList.first.price.toString();
    _selectedPlanId = homeController.adsList.first.sId.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Publish Advertisement')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Advertisement Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  hintText: 'Enter Your Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Shop Name',
                  border: OutlineInputBorder(),
                  hintText: 'Shop Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a shop name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  hintText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Provide Address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Provide Email Address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _gstController,
                decoration: const InputDecoration(
                  labelText: 'GST',
                  hintText: 'GST',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _mobileNumberController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: const InputDecoration(
                  labelText: 'Mobile Number',
                  hintText: 'Mobile Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Your Number';
                  }
                  return null;
                },
              ),
              const Text(
                'Advertised',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              DropdownButtonFormField<String>(
                value:
                    homeController.adsList.isNotEmpty
                        ? homeController.adsList.first.name
                        : null,
                items:
                    homeController.adsList.map((data) {
                      return DropdownMenuItem<String>(
                        value: data.name ?? '',
                        child: Text(data.name ?? 'No Name'),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      final selectedData = homeController.adsList.firstWhere(
                        (element) => element.name == value,
                      );
                      _adPricesSize = selectedData.price.toString() ?? '';
                      _selectedPlanId = selectedData.sId ?? '';
                    }
                  });
                },
                decoration: const InputDecoration(border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a subscription plan';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              const Text(
                'Price',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                value: _adPricesSize,
                items: [
                  DropdownMenuItem(
                    value: _adPricesSize,
                    child: Text(_adPricesSize),
                  ),
                ],
                onChanged: null,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Price not available';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              const Text(
                'Select Payment Method',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedPaymentMethod = 'cod';
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              _selectedPaymentMethod == 'cod'
                                  ? Colors.green[50]
                                  : Colors.white,
                          border: Border.all(
                            color:
                                _selectedPaymentMethod == 'cod'
                                    ? Colors.green
                                    : Colors.grey.shade300,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow:
                              _selectedPaymentMethod == 'cod'
                                  ? [
                                    BoxShadow(
                                      color: Colors.green.withOpacity(0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                  : [],
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.money, size: 30, color: Colors.green),
                            const SizedBox(height: 8),
                            Text(
                              'Cash',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color:
                                    _selectedPaymentMethod == 'cod'
                                        ? Colors.green
                                        : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedPaymentMethod = 'upi';
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              _selectedPaymentMethod == 'upi'
                                  ? Colors.blue[50]
                                  : Colors.white,
                          border: Border.all(
                            color:
                                _selectedPaymentMethod == 'upi'
                                    ? Colors.blue
                                    : Colors.grey.shade300,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow:
                              _selectedPaymentMethod == 'upi'
                                  ? [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                  : [],
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.payment, size: 30, color: Colors.blue),
                            const SizedBox(height: 8),
                            Text(
                              'Online Payment',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color:
                                    _selectedPaymentMethod == 'upi'
                                        ? Colors.blue
                                        : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Obx(
                () =>
                    homeController.isOtpLoading.value
                        ? const Center(
                          child: CircularProgressIndicator(strokeWidth: 1),
                        )
                        : SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Map<String, dynamic> body = {
                                  "name": _titleController.text,
                                  "shopName": _descriptionController.text,
                                  "address": _contactController.text,
                                  "email": _emailController.text,
                                  "gst": _gstController.text,
                                  "adSizeId": _selectedPlanId,
                                  "paymentType": _selectedPaymentMethod,
                                  "phone": _mobileNumberController.text,
                                };
                                if (_selectedPaymentMethod == 'cod') {
                                  homeController.addAdvertisements(
                                    body: body,
                                    amount: _adPricesSize,
                                  );
                                  Get.back();
                                } else {
                                  homeController.addAdvertisements(
                                    body: body,
                                    amount: _adPricesSize,
                                  );
                                  Get.to(
                                    () => PaymentScreen(
                                      amount: _adPricesSize,
                                      // advertisementData: body,
                                    ),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
