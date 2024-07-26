import 'package:flutter/material.dart';
import 'input_field.dart';
import 'form_logic.dart';
import 'styles.dart';
import 'input_state.dart';
import 'button.dart';
import 'password_validation.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ValueNotifier<InputState> _emailStateNotifier =
      ValueNotifier<InputState>(InputState.defaultState);
  final ValueNotifier<InputState> _passwordStateNotifier =
      ValueNotifier<InputState>(InputState.defaultState);
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF4F9FF), Color(0xFFE0EDFB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: AppStyles.formMaxWidth),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    InputField(
                      controller: _emailController,
                      labelText: 'Email',
                      inputStateNotifier: _emailStateNotifier,
                      validator: (value) =>
                          FormLogic.validateEmail(value, _emailStateNotifier),
                      onChanged: (value) {
                        FormLogic.validateEmail(value, _emailStateNotifier);
                      },
                    ),
                    SizedBox(height: 16.0),
                    InputField(
                      controller: _passwordController,
                      labelText: 'Password',
                      inputStateNotifier: _passwordStateNotifier,
                      validator: (value) => FormLogic.validatePassword(
                          value, _passwordStateNotifier),
                      obscureText: _obscureText,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      onChanged: (value) {
                        _passwordStateNotifier.value = InputState.defaultState;
                        FormLogic.validatePassword(
                            value, _passwordStateNotifier);
                      },
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: PasswordValidationTexts(
                        passwordController: _passwordController,
                        passwordStateNotifier: _passwordStateNotifier,
                      ),
                    ),
                    SizedBox(height: 20),
                    Button(
                      text: 'Sign up',
                      onPressed: () => FormLogic.handleSubmit(
                        context,
                        _formKey,
                        _emailController,
                        _passwordController,
                        _emailStateNotifier,
                        _passwordStateNotifier,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getPasswordConditionColor(int len, bool condition) {
    return len == 0
        ? AppStyles.blue
        : condition
            ? AppStyles.green
            : AppStyles.red;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailStateNotifier.dispose();
    _passwordStateNotifier.dispose();
    super.dispose();
  }
}
