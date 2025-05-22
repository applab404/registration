import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:registration/firebase_options.dart';
import 'package:registration/screens/registration/registration_page.dart';
import 'package:registration/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(RegistrationApp());
}

class RegistrationApp extends StatelessWidget {
  const RegistrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: RegistrationPage(),
    );
  }
}
