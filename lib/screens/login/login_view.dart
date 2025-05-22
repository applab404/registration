import 'package:flutter/material.dart';
import 'package:registration/theme/colors.dart';
import 'package:registration/utils/form_validators.dart';
import 'package:registration/widgets/custom_text_field.dart';
import 'login_page.dart';

class LoginView extends StatelessWidget {
  final LoginPageState state;
  const LoginView(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(title: const Text('Login')),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: state.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextField(
                    controller: state.emailCtrl,
                    label: 'Email',
                    validator: FormValidators.validateEmail,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: state.passwordCtrl,
                    label: 'Password',
                    validator: FormValidators.validatePassword,
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: state.login,
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
