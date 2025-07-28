import 'package:flutter/material.dart';
import '../View/RegistrationForm.dart';
import '../controllers/account_controller.dart';

class SignEmail extends StatefulWidget {
  const SignEmail({super.key});

  @override
  State<SignEmail> createState() => _SignEmailState();
}

class _SignEmailState extends State<SignEmail> {
  final _formKey = GlobalKey<FormState>();
  String companyEmail = '';

  @override
  void initState() {
    super.initState();
    AccountController.startAccountCreation(); // Begin tracking
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        // Show confirmation dialog ONLY when using system back button
        final shouldExit = await _handleBack(context);
        if (shouldExit) Navigator.of(context).pop();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop(); // No confirmation dialog
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      "What's your company email?",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'Enter the email where you can be contacted. No one will see this on your profile.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your company email';
                        }
                        final emailPattern = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        );
                        if (!emailPattern.hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        companyEmail = value ?? '';
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => handleSubmit(context),
                    child: const Text('Next'),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegistrationForm(),
                        ),
                      );
                    },
                    child: const Text('Sign up with Phone Number'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleSubmit(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const RegistrationForm()),
      );
    }
  }

  Future<bool> _handleBack(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Stop Creating Account'),
        content: const Text(
          "Do you want to stop creating your account? If you stop now, you'll lose any progress you've made.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Continue Creating Account'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Stop Creating Account'),
          ),
        ],
      ),
    );

    if (result == true) {
      AccountController.resetProgress();
      return true;
    }
    return false;
  }
}
