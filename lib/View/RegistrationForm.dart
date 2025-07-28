import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../View/SignEmail.dart';
import '../controllers/account_controller.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  String mobileNumber = '';
  bool _isDirty = false; // Track if user started entering info

  @override
  void initState() {
    super.initState();
    AccountController.startAccountCreation(); // Start progress
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        if (didPop) return;
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
                        onPressed: () async {
                          final shouldExit = await _handleBack(context);
                          if (shouldExit) {
                            Navigator.of(context).pop();
                          }
                          // If shouldExit is false, stay on the page
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      "What's your mobile number?",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'Enter the mobile number where you can be contacted. No one will see this on your phone.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  buildTextFormField(
                    label: 'Mobile Number',
                    onSaved: (value) => mobileNumber = value?.trim() ?? '',
                    validatorMsg: 'Please enter your mobile number',
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      setState(() {
                        _isDirty = value.isNotEmpty;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  const Padding(
                    padding: EdgeInsets.only(top: 7.0),
                    child: Text(
                      'You may receive SMS notifications about your account. We will never share your number with anyone.',
                      style: TextStyle(fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: handleSubmit,
                    child: const Text('Next'),
                  ),
                  const SizedBox(height: 17),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignEmail()),
                      );
                    },
                    child: const Text('Sign up with email'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final user = User(mobileNumber: mobileNumber);

      // TODO: Proceed to next registration screen
    }
  }

  Widget buildTextFormField({
    required String label,
    required FormFieldSetter<String> onSaved,
    required String validatorMsg,
    TextInputType keyboardType = TextInputType.text,
    ValueChanged<String>? onChanged, // <-- Add this
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        onSaved: onSaved,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validatorMsg;
          }
          return null;
        },
        onChanged: onChanged, // <-- Add this
      ),
    );
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
