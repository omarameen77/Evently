import 'package:evently/core/theme/app_text_style/app_text_style.dart';
import 'package:evently/features/auth/reset_password/reset_password.dart';
import 'package:evently/features/home/home_screen.dart';
import 'package:evently/provider/auth_provider.dart';
import 'package:evently/shared/custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    
    return null;
  }

  Future<void> _handleLogin() async {
    FocusScope.of(context).unfocus();
    
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final success = await authProvider.loginWithEmailAndPassword(
      email,
      password,
      context,
    );

    if (context.mounted && success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            enabled: !authProvider.isLoading,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              hintText: 'Email',
              errorMaxLines: 2,
            ),
            validator: _validateEmail,
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            obscureText: _isObscureText,
            textInputAction: TextInputAction.done,
            enabled: !authProvider.isLoading,
            onFieldSubmitted: (_) => _handleLogin(),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              hintText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              errorMaxLines: 2,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _isObscureText = !_isObscureText;
                  });
                },
                child: Icon(
                  _isObscureText ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            validator: _validatePassword,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: authProvider.isLoading
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetPassword()),
                      );
                    },
              child: Text(
                'Forgot Password?',
                style: TextStylesHelper.font16PurpleBold,
              ),
            ),
          ),
          SizedBox(height: 24),
          authProvider.isLoading
              ? CircularProgressIndicator()
              : CustomBottom(
                  text: 'Login',
                  onPressed: _handleLogin,
                ),
          if (authProvider.errorMessage != null && !authProvider.isLoading)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        authProvider.errorMessage!,
                        style: TextStyle(
                          color: Colors.red.shade700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}