import 'package:flutter/material.dart';
import '../View/RegistrationForm.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final fieldWidth = screenWidth * 0.9;
    final buttonWidth = screenWidth * 0.8;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 🔼 App Logo (Responsive height & top padding)
          Positioned(
            top: screenHeight * 0.12,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/group_logo_round1.png',
                height: screenHeight * 0.15,
              ),
            ),
          ),

          // 🟪 Main UI
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Welcome to Eportal',
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your one-stop solution for managing employee accounts',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Username Field
                  SizedBox(
                    width: fieldWidth,
                    child: TextField(
                      controller: usernameController,
                      decoration: _buildInputDecoration('Username'),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  SizedBox(
                    width: fieldWidth,
                    child: TextField(
                      controller: passwordController,
                      obscureText: _obscureText,
                      decoration: _buildInputDecoration(
                        'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),
                  SizedBox(
                    width: buttonWidth,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        final username = usernameController.text;
                        final password = passwordController.text;
                        // TODO: Handle login
                      },
                      child: const Text('Login'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Forgot password
                    },
                    child: const Text('Forgot Password?'),
                  ),
                ],
              ),
            ),
          ),

          // 🔻 Bottom Create Account Button (Responsive)
          Positioned(
            bottom: screenHeight * 0.07,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: buttonWidth,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationForm(),
                      ),
                    );
                  },
                  child: const Text('Create Account'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔧 Reusable input decoration
  InputDecoration _buildInputDecoration(String label, {Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey[700]),
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Color(0xFF6F4DC6), width: 2),
      ),
      suffixIcon: suffixIcon,
    );
  }
}
