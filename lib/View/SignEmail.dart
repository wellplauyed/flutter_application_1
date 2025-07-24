import 'package:flutter/material.dart';
import '../View/RegistrationForm.dart';

class SignEmail extends StatefulWidget {
  const SignEmail({super.key});

  @override
  State<SignEmail> createState() => _SignEmailState();
}

class _SignEmailState extends State<SignEmail> {
  final _formKey = GlobalKey<FormState>();
  String companyEmail = '';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(height: screenHeight * 0.02),

                // ⬅️ Back Arrow flush to left
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),

                // 🔠 Title
                const Padding(
                  padding: EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    "What's your company email?",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),

                // 📄 Subtitle
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Enter the email where you can be contacted. No one will see this on your profile',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                ),

                // 📧 Email Input Field
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

                const SizedBox(height: 20), // 👈 Moved buttons closer
                // 🟩 Next Button
                ElevatedButton(
                  onPressed: () => handleSubmit(context),
                  child: const Text('Next'),
                ),

                const SizedBox(height: 12),

                // 🟦 Switch to Phone Button
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
    );
  }

  /// ✅ Submit Handler
  Future<void> handleSubmit(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // Use the saved email (companyEmail)
      print('Company Email: $companyEmail');

      // Proceed to next screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const RegistrationForm()),
      );
    }
  }
}
