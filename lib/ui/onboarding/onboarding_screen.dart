// File: homeonix/ui/onboarding/onboarding_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeonix/core/app_routes.dart';
import 'package:homeonix/core/constants.dart';
import 'package:homeonix/core/themes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Welcome to Homeonix",
      "subtitle": "Your intelligent assistant for accurate homeopathic remedy finding.",
      "image": "assets/images/onboarding1.png",
    },
    {
      "title": "Symptom Input",
      "subtitle": "Input symptoms in English or Bengali and get suggestions instantly.",
      "image": "assets/images/onboarding2.png",
    },
    {
      "title": "Secure & Smart",
      "subtitle": "Your data is secure, and smart tools help you track, update, and refine results.",
      "image": "assets/images/onboarding3.png",
    },
  ];

  void _onNext() {
    if (_currentIndex < onboardingData.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      Get.offAllNamed(AppRoutes.login); // Navigates to login after onboarding
    }
  }

  Widget _buildPage(Map<String, String> data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Image.asset(
            data["image"]!,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          data["title"]!,
          style: AppTextStyles.heading1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            data["subtitle"]!,
            style: AppTextStyles.bodyText,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildPage(onboardingData[index]);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(onboardingData.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12),
                  width: _currentIndex == index ? 16 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == index ? AppColors.primary : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: _onNext,
                child: Text(_currentIndex == onboardingData.length - 1 ? "Get Started" : "Next"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}