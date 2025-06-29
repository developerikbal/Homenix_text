import 'package:flutter/material.dart';
import 'package:homeonix/widgets/remedy_card.dart';
import 'package:homeonix/widgets/common_button.dart';
import 'package:homeonix/services/remedy_service.dart';
import 'package:homeonix/core/constants.dart';
import 'package:homeonix/core/app_routes.dart';
import 'package:homeonix/models/remedy_model.dart';
import 'package:flutter/material.dart';
import 'package:homeonix/widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'My Page',
        showBackButton: true,
        showSettings: true,
      ),
      body: Center(
        child: Text('Welcome to My Page!'),
      ),
    );
  }
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<RemedyModel> _topRemedies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTopRemedies();
  }

  Future<void> _loadTopRemedies() async {
    try {
      final remedies = await RemedyService().getTopRemedies();
      setState(() {
        _topRemedies = remedies;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      debugPrint('Error loading remedies: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Homeonix',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.settingsScreen);
            },
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadTopRemedies,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text(
                    'Enter Patient Symptoms',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  CommonButton(
                    label: 'Find Remedy',
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.symptomInputScreen);
                    },
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Top Suggested Remedies',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  if (_topRemedies.isEmpty)
                    const Text("No remedies available")
                  else
                    ..._topRemedies
                        .map((remedy) => RemedyCard(remedy: remedy))
                        .toList()
                ],
              ),
            ),
    );
  }
}
DeveloperEntryWidget(),