import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'SignEmail.dart'; // Import the SignEmail widget
// import 'AccountSetupForm.dart'; // Uncomment if needed

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  String mobileNumber = '';

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
                    "What's your mobile number?",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),

                // 📄 Subtitle
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Enter the mobile number where you can be contacted. No one will see this on your phone',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                ),

                // 📱 Input Field
                buildTextFormField(
                  label: 'Mobile Number',
                  onSaved: (value) => mobileNumber = value?.trim() ?? '',
                  validatorMsg: 'Please enter your mobile number',
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 12),

                // 🛡️ Note text
                const Padding(
                  padding: EdgeInsets.only(top: 7.0),
                  child: Text(
                    'You may receive SMS notifications about your account. We will never share your number with anyone.',
                    style: TextStyle(fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ),

                // 👇 Reduce this to make the button closer
                const SizedBox(height: 16),

                // ✅ Buttons
                ElevatedButton(
                  onPressed: handleSubmit,
                  child: const Text('Next'),
                ),

                const SizedBox(height: 17),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SignEmail()),
                    );
                  },
                  child: const Text('Sign up with email'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ✅ Handle form validation & move to next step
  Future<void> handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final user = User(mobileNumber: mobileNumber);

      // TODO: Navigate to next step
      // Navigator.push(context, MaterialPageRoute(builder: (_) => AccountSetupForm(user: user)));
    }
  }

  /// ✅ Reusable text form field
  Widget buildTextFormField({
    required String label,
    required FormFieldSetter<String> onSaved,
    required String validatorMsg,
    TextInputType keyboardType = TextInputType.text,
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
      ),
    );
  }
}
