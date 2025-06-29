import 'package:flutter/material.dart';
import 'package:homeonix/widgets/custom_textfield.dart';
import 'package:homeonix/controllers/remedy_controller.dart';
import 'package:homeonix/widgets/common_button.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:homeonix/widgets/input_chip_list.dart';

class PatientInputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Symptom Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InputChipList(
          options: ['Fever', 'Chill', 'Sweating'],
          initialSelected: ['Fever'],
          onSelectionChanged: (selectedSymptoms) {
            // TODO: Trigger remedy suggestion logic
            print("Selected symptoms: $selectedSymptoms");
          },
        ),
      ),
    );
  }
}

/// রোগীর উপসর্গ ইনপুট করার স্ক্রিন, যেখান থেকে সম্ভাব্য রেমেডি বের হয়
class PatientInputScreen extends StatefulWidget {
  const PatientInputScreen({super.key});

  @override
  State<PatientInputScreen> createState() => _PatientInputScreenState();
}

class _PatientInputScreenState extends State<PatientInputScreen> {
  final TextEditingController _symptomController = TextEditingController();
  final RemedyController _remedyController = Get.find<RemedyController>();

  final Set<String> selectedChips = {}; // InputChip এবং FilterChip এর জন্য

  bool _isLoading = false;

  void _findRemedy() async {
    if (_symptomController.text.trim().isEmpty && selectedChips.isEmpty) {
      Get.snackbar('Empty', 'Please describe at least one symptom or select chips.');
      return;
    }

    setState(() => _isLoading = true);

    // টেক্সট ইনপুট ও চিপস একত্রে পাঠানো
    final inputText = [
      _symptomController.text.trim(),
      ...selectedChips
    ].join(', ');

    await _remedyController.analyzeSymptoms(inputText);

    setState(() => _isLoading = false);
    Get.toNamed('/remedy_result');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Input'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// Input field (English or Bengali)
            CustomTextField(
              controller: _symptomController,
              hintText: 'Describe symptoms (English or Bengali)',
              maxLines: 5,
              borderColor: Colors.lightGreen,
            ),
            const SizedBox(height: 20),

            /// Selectable symptom chips
            Wrap(
              spacing: 8.0,
              children: [
                _buildFilterChip("Sadness"),
                _buildFilterChip("Anxiety"),
                _buildFilterChip("Worse at night"),
                _buildFilterChip("Better in morning"),
                _buildFilterChip("Thirstless"),
                _buildFilterChip("Headache with heat"),
              ],
            ),
            const SizedBox(height: 20),

            /// Remedy Button
            _isLoading
                ? const CircularProgressIndicator()
                : CommonButton(
                    text: 'Find Remedy',
                    onTap: _findRemedy,
                    color: Colors.lightGreen,
                  ),

            const SizedBox(height: 40),

            const Text(
              'Example: Fever with thirst, dry cough at night\nউদাহরণ: রাত্রিতে কাশি, পিপাসা বেশি, শুকনো জ্বর',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return FilterChip(
      label: Text(label),
      selected: selectedChips.contains(label),
      onSelected: (bool selected) {
        setState(() {
          selected ? selectedChips.add(label) : selectedChips.remove(label);
        });
      },
    );
  }

  @override
  void dispose() {
    _symptomController.dispose();
    super.dispose();
  }
}