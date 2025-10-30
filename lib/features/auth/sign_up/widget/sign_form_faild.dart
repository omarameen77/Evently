import 'package:evently/provider/auth_provider.dart';
import 'package:evently/shared/custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignFormField extends StatefulWidget {
  const SignFormField({super.key});

  @override
  State<SignFormField> createState() => _SignFormFieldState();
}

class _SignFormFieldState extends State<SignFormField> {
  bool _isObscurePassword = true;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        return Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: _isObscurePassword,
              decoration: InputDecoration(
                hintText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isObscurePassword = !_isObscurePassword;
                    });
                  },
                  child: Icon(
                    _isObscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            CustomBottom(
              text: authProvider.isLoading
                  ? 'Loading...'
                  : 'Create Account',
              onPressed: authProvider.isLoading
                  ? null
                  : () async {
                      final name = _nameController.text.trim();
                      final email = _emailController.text.trim();
                      final password = _passwordController.text.trim();

                      if (name.isEmpty ||
                          email.isEmpty ||
                          password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text("Please fill all fields"),
                          ),
                        );
                        return;
                      }
                      await authProvider.signUpWithEmailAndPassword(
                        name,
                        email,
                        password,
                        context,
                      );
                    },
            ),
          ],
        );
      },
    );
  }
}
