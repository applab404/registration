import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:registration/widgets/custom_snackbar.dart';
import 'package:registration/screens/registration/registration_view.dart';
import 'package:registration/services/auth_service.dart';
import 'package:registration/screens/home/home_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  String? gender;
  bool agreedToTerms = false;
  DateTime? dob;
  File? profileImage;

  List<String> genderOptions = ['Male', 'Female', 'Other'];
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return RegistrationView(this);
  }

  Future<void> submitForm() async {
    if (!_isFormComplete()) {
      CustomSnackbar.show(
        context,
        'Please complete all fields',
        success: false,
      );
      return;
    }

    try {
      await _authService.registerUser(
        name: nameCtrl.text.trim(),
        email: emailCtrl.text.trim(),
        password: passwordCtrl.text,
        gender: gender!,
        dob: dob!,
      );
      CustomSnackbar.show(context, 'Registration Successful!');
      _navigateToHome();
    } catch (e) {
      CustomSnackbar.show(context, 'Registration failed: $e', success: false);
    }
  }

  bool _isFormComplete() {
    return formKey.currentState?.validate() == true &&
        agreedToTerms &&
        dob != null &&
        gender != null;
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  bool get isEnabled {
    return nameCtrl.text.isNotEmpty &&
        emailCtrl.text.isNotEmpty &&
        passwordCtrl.text.isNotEmpty &&
        dob != null &&
        gender != null &&
        agreedToTerms;
  }

  void resetForm() {
    formKey.currentState!.reset();
    nameCtrl.clear();
    emailCtrl.clear();
    passwordCtrl.clear();
    setAgreement(false);
    setGender(null);
    setDOB(null);
    nameCtrl.clear();
    emailCtrl.clear();
    passwordCtrl.clear();
    toggleProfileUpload();
  }

  void toggleProfileUpload() => setState(() => profileImage = null);

  void setGender(String? value) => setState(() => gender = value);

  void setAgreement(bool? value) =>
      setState(() => agreedToTerms = value ?? false);

  void setDOB(DateTime? date) => setState(() => dob = date);

  Future<void> pickProfileImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => profileImage = File(picked.path));
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }
}
