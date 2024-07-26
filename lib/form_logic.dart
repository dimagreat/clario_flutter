import 'package:flutter/material.dart';
import 'input_state.dart';

class FormLogic {
  static String? validateEmail(
      String? value, ValueNotifier<InputState> stateNotifier) {
    if (value == null || value.isEmpty) {
      stateNotifier.value = InputState.error;
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      stateNotifier.value = InputState.error;
      return 'Enter a valid email';
    }
    stateNotifier.value = InputState.success;
    return null;
  }

  static String? validatePassword(
      String? value, ValueNotifier<InputState> stateNotifier) {
    if (value == null || value.isEmpty) {
      stateNotifier.value = InputState.error;
      return 'Password is required';
    }
    if (value.length < 8 || value.contains(' ')) {
      stateNotifier.value = InputState.error;
      return 'Password must be at least 8 characters long and contain no spaces';
    }
    if (!value.contains(RegExp(r'[A-Z]')) ||
        !value.contains(RegExp(r'[a-z]'))) {
      stateNotifier.value = InputState.error;
      return 'Password must contain both uppercase and lowercase letters';
    }
    if (!value.contains(RegExp(r'\d'))) {
      stateNotifier.value = InputState.error;
      return 'Password must contain at least one digit';
    }
    stateNotifier.value = InputState.success;
    return null;
  }

  static void handleSubmit(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController emailController,
    TextEditingController passwordController,
    ValueNotifier<InputState> emailStateNotifier,
    ValueNotifier<InputState> passwordStateNotifier,
  ) {
    final emailValidationResult =
        validateEmail(emailController.text, emailStateNotifier);
    final passwordValidationResult =
        validatePassword(passwordController.text, passwordStateNotifier);

    formKey.currentState?.validate();

    if (formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form is valid')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form is invalid')),
      );
    }

    print("Email state: ${emailStateNotifier.value}");
    print("Password state: ${passwordStateNotifier.value}");
  }
}
