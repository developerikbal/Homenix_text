// lib/payment/payment_ui.dart

import 'package:flutter/material.dart';
import '../services/subscription_service.dart'; // ✅ সাবস্ক্রিপশন প্রসেসিং সার্ভিস
import '../widgets/custom_button.dart'; // ✅ কাস্টম বাটন UI

/// 📱 UI Widget: ইউজার সাবস্ক্রিপশন প্যাকেজ বেছে নিয়ে পেমেন্ট করতে পারে
class PaymentUI extends StatefulWidget {
  const PaymentUI({Key? key}) : super(key: key);

  @override
  State<PaymentUI> createState() => _PaymentUIState();
}

class _PaymentUIState extends State<PaymentUI> {
  String _selectedPlan = 'monthly';
  bool _isProcessing = false;

  // 🔖 প্রাইস ম্যাপ (Future: Firebase থেকে dynamic আনা যাবে)
  final Map<String, String> planPrices = {
    'monthly': '₹99 / মাস',
    'yearly': '₹999 / বছর',
    'lifetime': '₹1999 এককালীন',
  };

  /// 🚀 সাবস্ক্রিপশন শুরু করে
  void _subscribe() async {
    setState(() => _isProcessing = true);

    bool result = await SubscriptionService.subscribeToPlan(_selectedPlan);

    setState(() => _isProcessing = false);

    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('সাবস্ক্রিপশন সফল হয়েছে')),
      );
      Navigator.pop(context); // সফল হলে UI থেকে বেরিয়ে যান
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('সাবস্ক্রিপশন ব্যর্থ হয়েছে')),
      );
    }
  }

  /// 🧱 মেইন বিল্ড UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('প্রিমিয়াম প্যাকেজ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'আপনার পছন্দের সাবস্ক্রিপশন প্ল্যান বেছে নিন',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),

            // ✅ সাবস্ক্রিপশন প্ল্যান রেডিও বাটন
            ...planPrices.entries.map((entry) {
              return RadioListTile(
                title: Text(entry.value),
                value: entry.key,
                groupValue: _selectedPlan,
                onChanged: (value) {
                  setState(() => _selectedPlan = value.toString());
                },
              );
            }).toList(),

            const Spacer(),

            // ✅ প্রসেসিং indicator বা সাবস্ক্রাইব বাটন
            if (_isProcessing)
              CircularProgressIndicator()
            else
              CustomButton(
                text: 'সাবস্ক্রাইব করুন',
                onPressed: _subscribe,
              ),

            const SizedBox(height: 12),

            Text(
              'যেকোনো সময় আপনার প্ল্যান আপগ্রেড/ডাউনগ্রেড করতে পারবেন।',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}