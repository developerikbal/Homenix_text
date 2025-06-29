import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; //  FirebaseAuth Import
import 'package:firebase_messaging/firebase_messaging.dart'; //  Optional Messaging
import 'package:provider/provider.dart';

import 'config/firebase_options.dart';
import 'theme/theme_manager.dart';
import 'localization/app_localizations.dart';
import 'routes/app_routes.dart';

import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/splash_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/remedy/remedy_search_screen.dart';
import 'screens/common/welcome_screen.dart';
import 'app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}
void main() async {
  await initializeApp();
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase Init
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //  Local Storage Init
  await GetStorage.init();

  // Theme Manager Init
  final themeManager = ThemeManager();
  await themeManager.loadTheme();

  //  Firebase Messaging Init (Optional)
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    ChangeNotifierProvider.value(
      value: themeManager,
      child: const HomeonixApp(),
    ),
  );
}

// Optional Notification Handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // Handle background message
}

// HomeonixApp Class
class HomeonixApp extends StatelessWidget {
  const HomeonixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Homeonix',
      theme: Provider.of<ThemeManager>(context).themeData,

      // Localization Support
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('bn', ''),
      ],

      // Initial Page Control Based on Login State
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else if (snapshot.hasData) {
            return const RemedySearchScreen(); //  Logged In
          } else {
            return const WelcomeScreen(); //  Not Logged In
          }
        },
      ),

      //  App Routes
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/search': (context) => const RemedySearchScreen(),
      },
    );
  }
}