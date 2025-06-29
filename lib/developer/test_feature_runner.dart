import 'package:flutter/material.dart';

import '../services/remedy_service.dart'; // Remedy suggestion engine
import '../services/book_service.dart'; // Book processing
import '../services/image_analysis_service.dart'; // Image analysis to symptoms
import '../logic/pdf_processor.dart'; // PDF parsing (if used separately)
import '../logic/ocr_translate.dart'; // OCR + Translation
import '../services/firebase_auth_service.dart'; // Firebase Auth testing
import '../payment/payment_gateway.dart'; // Payment simulation

class TestFeatureRunner extends StatelessWidget {
  const TestFeatureRunner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Developer Test Panel")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: () async {
              try {
                final result = await RemedyService().suggestRemedies(["headache", "chilly"]);
                debugPrint("Remedy Suggestion Result: $result");
              } catch (e) {
                debugPrint("Error in Remedy Suggestion: $e");
              }
            },
            child: const Text("Test Remedy Suggestion"),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                final result = await BookService().processBook('assets/books/sample.pdf');
                debugPrint("Book processed successfully: $result");
              } catch (e) {
                debugPrint("Error processing book: $e");
              }
            },
            child: const Text("Test Book Upload"),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                final result = await OCRTranslator().extractAndTranslate('assets/images/sample_text.png');
                debugPrint("OCR Translation Result: $result");
              } catch (e) {
                debugPrint("OCR Translation Error: $e");
              }
            },
            child: const Text("Test OCR & Translate"),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                final result = await ImageAnalysisService().analyzeImage('assets/images/rash.png');
                debugPrint("Image Analysis Result: $result");
              } catch (e) {
                debugPrint("Image Analysis Error: $e");
              }
            },
            child: const Text("Test Image Analysis"),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                final user = await FirebaseAuthService().signInTest();
                if (user != null) {
                  debugPrint("Signed in user: ${user.email}");
                } else {
                  debugPrint("Sign-in returned null");
                }
              } catch (e) {
                debugPrint("Firebase Sign In Error: $e");
              }
            },
            child: const Text("Test Firebase Auth"),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                final status = await PaymentGateway().simulateTestPayment("test_user");
                debugPrint("Payment Simulation Status: $status");
              } catch (e) {
                debugPrint("Payment Simulation Error: $e");
              }
            },
            child: const Text("Test Payment Flow"),
          ),
        ],
      ),
    );
  }
}