import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔼 LOGO at the top center
          // You can adjust the logo's vertical position by changing `top: 80`
          // Example: top: 50 moves it up, top: 120 moves it down
          Positioned(
            top: 180, // 🔧 ADJUST THIS to move logo up or down
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset('assets/group_logo_round1.png', height: 120),
            ),
          ),

          // 🟪 CENTER TEXT ("Welcome to Eportal")
          // To move the text up/down, adjust `top` padding inside `Padding(...)`
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                ],
              ),
            ),
          ),
          // 🔽 BUTTONS at the bottom center
          // To move the buttons up or down, adjust `bottom: 100`
          Positioned(
            bottom: 100, // 🔧 ADJUST THIS to move buttons higher or lower
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // navigate to create account screen
                    },
                    child: const Text('Create Account'),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF6F4DC6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Color(0xFF70548F), width: 2),
                      ),
                    ),
                    onPressed: () {
                      // navigate to login screen
                    },
                    child: const Text('Sign In'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
