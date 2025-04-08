import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:registration/widgets/custom_snackbar.dart';
import 'registration_view.dart';

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

  @override
  Widget build(BuildContext context) {
    return RegistrationView(this);
  }

  void submitForm() {
    if (formKey.currentState!.validate() && agreedToTerms) {
      CustomSnackbar.show(context, 'Registration Successful!');
    } else if (!agreedToTerms) {
      CustomSnackbar.show(context, 'Please agree to terms', success: false);
    }
  }

  bool get isEnabled {
    return nameCtrl.text.isNotEmpty &&
        emailCtrl.text.isNotEmpty &&
        passwordCtrl.text.isNotEmpty &&
        dob != null &&
        agreedToTerms;
  }

  void resetForm() {
    formKey.currentState!.reset();
    agreedToTerms = false;
    gender = null;
    profileImage = null;
    setState(() {});
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
