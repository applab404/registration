import 'package:flutter/material.dart';
import 'package:registration/services/auth_service.dart';
import 'package:registration/widgets/custom_snackbar.dart';
import 'login_view.dart';
import 'package:registration/screens/home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  final AuthService _authService = AuthService();

  void login() async {
    if (!formKey.currentState!.validate()) return;
    try {
      await _authService.loginUser(emailCtrl.text.trim(), passwordCtrl.text);
      CustomSnackbar.show(context, 'Login successful');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } catch (e) {
      CustomSnackbar.show(context, 'Login failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginView(this);
  }
}
