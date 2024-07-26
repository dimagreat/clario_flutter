import 'package:flutter/material.dart';
import 'input_state.dart';
import 'styles.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final ValueNotifier<InputState> inputStateNotifier;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  FocusNode node = FocusNode();

  InputField({
    required this.controller,
    required this.labelText,
    required this.inputStateNotifier,
    required this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<InputState>(
      valueListenable: inputStateNotifier,
      builder: (context, inputState, child) {
        return TextFormField(
          focusNode: node,
          controller: controller,
          obscureText: obscureText,
          validator: node.hasFocus ? null : validator,
          onChanged: (value) {
            if (onChanged != null) {
              onChanged!(value);
            }
            inputStateNotifier.value = InputState.defaultState;
          },
          decoration: InputDecoration(
            labelText: null,
            hintText: labelText,
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: _getInputColor(),
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: _getInputColor(),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: _getInputColor(),
                width: 1.0,
              ),
            ),
            errorStyle: TextStyle(
              color: AppStyles.red,
              fontSize: 12.0,
            ),
            suffixIcon: suffixIcon,
          ),
          style: TextStyle(
            color: _getInputColor(),
          ),
        );
      },
    );
  }

  Color _getInputColor() {
    switch (inputStateNotifier.value) {
      case InputState.success:
        return AppStyles.green;
      case InputState.error:
        return AppStyles.red;
      default:
        return AppStyles.blue;
    }
  }
}
