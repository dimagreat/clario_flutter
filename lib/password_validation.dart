import 'package:flutter/material.dart';
import 'styles.dart';
import 'input_state.dart';

class PasswordValidationTexts extends StatelessWidget {
  final TextEditingController passwordController;
  final ValueNotifier<InputState> passwordStateNotifier;

  PasswordValidationTexts({
    required this.passwordController,
    required this.passwordStateNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<InputState>(
      valueListenable: passwordStateNotifier,
      builder: (context, inputState, child) {
        return Container(
          width: AppStyles.formMaxWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '8 characters or more (no spaces)',
                style: TextStyle(
                  color: passwordController.text.length == 0
                      ? AppStyles.blue
                      : _getPasswordConditionColor(
                          passwordController.text.length,
                          passwordController.text.length >= 8 &&
                              !passwordController.text.contains(' ')),
                ),
              ),
              Text(
                'Uppercase and lowercase letters',
                style: TextStyle(
                  color: _getPasswordConditionColor(
                      passwordController.text.length,
                      passwordController.text.contains(RegExp(r'[A-Z]')) &&
                          passwordController.text.contains(RegExp(r'[a-z]'))),
                ),
              ),
              Text(
                'At least one digit',
                style: TextStyle(
                  color: _getPasswordConditionColor(
                      passwordController.text.length,
                      passwordController.text.contains(RegExp(r'\d'))),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getPasswordConditionColor(int len, bool condition) {
    return len == 0
        ? AppStyles.blue
        : condition
            ? AppStyles.green
            : AppStyles.red;
  }
}
