import 'package:flutter/material.dart';
import 'package:registration/theme/colors.dart';
import 'package:registration/utils/form_validators.dart';
import 'package:registration/widgets/custom_checkbox.dart';
import 'package:registration/widgets/custom_date_picker.dart';
import 'package:registration/widgets/custom_text_field.dart';
import 'package:registration/widgets/option_selector.dart';
import 'package:registration/widgets/profile_avatar.dart';
import 'registration_page.dart';

class RegistrationView extends StatelessWidget {
  final RegistrationPageState state;
  const RegistrationView(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(title: const Text('Register')),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: state.formKey,
              child: Column(
                children: [
                  ProfileAvatar(
                    imageFile: state.profileImage,
                    onTap: state.pickProfileImage,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: state.nameCtrl,
                    label: 'Full Name',
                    validator: FormValidators.validateName,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: state.emailCtrl,
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: FormValidators.validateEmail,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: state.passwordCtrl,
                    label: 'Password',
                    obscureText: true,
                    validator: FormValidators.validatePassword,
                  ),
                  const SizedBox(height: 16),
                  DatePickerField(
                    label: 'Date of Birth',
                    selectedDate: state.dob,
                    onDateSelected: state.setDOB,
                    validator: (value) => FormValidators.validateDOB(state.dob),
                  ),
                  const SizedBox(height: 16),
                  OptionSelector(
                    label: 'Gender',
                    options: state.genderOptions,
                    selected: state.gender,
                    onChanged: state.setGender,
                  ),
                  const SizedBox(height: 16),
                  CustomCheckbox(
                    label: 'I agree to the terms & conditions',
                    value: state.agreedToTerms,
                    onChanged: state.setAgreement,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: state.submitForm,
              child: const Text('Register'),
            ),
          ),
        ),
      ),
    );
  }
}
