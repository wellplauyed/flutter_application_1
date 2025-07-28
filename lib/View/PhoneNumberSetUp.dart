import 'package:flutter/material.dart';
import '../view/RegistrationForm.dart';

class PhoneNumberSetUp extends StatefulWidget {
  const PhoneNumberSetUp({super.key});

  @override
  State<PhoneNumberSetUp> createState() => _PhoneNumberSetUpState();
}

class _PhoneNumberSetUpState extends State<PhoneNumberSetUp> {
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        Navigator.of(context).pop(); // No dialog
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: ListView(
              children: [
                SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pop(); // No confirmation dialog, just go back
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.05),
                Text(
                  'Enter your phone number',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.03),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      // Update state if needed
                    });
                  },
                ),
                SizedBox(height: screenHeight * 0.04),
                ElevatedButton(
                  onPressed: () {
                    // Handle phone number submission
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
