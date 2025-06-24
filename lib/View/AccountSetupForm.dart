import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AccountSetupForm extends StatefulWidget {
  final User user;

  AccountSetupForm({required this.user});

  @override
  State<AccountSetupForm> createState() => _AccountSetupFormState();
}

class _AccountSetupFormState extends State<AccountSetupForm> {
  final _formKey = GlobalKey<FormState>();

  bool _showPassword = false;

  String username = '';
  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CMCGI CREATE ACCOUNT')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildTextFormField(
                label: 'Username',
                onSaved: (value) => username = value ?? '',
                validatorMsg: 'Please enter a username',
              ),
              buildTextFormField(
                label: 'Password',
                onSaved: (value) => password = value ?? '',
                validatorMsg: 'Please enter a password',
                obscureText: !_showPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                ),
              ),
              buildTextFormField(
                label: 'Confirm Password',
                onSaved: (value) => confirmPassword = value ?? '',
                validatorMsg: 'Please confirm your password',
                obscureText: !_showPassword,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Handle form submission logic here
                    print('Username: $username');
                    print('Password: $password');
                    print('Confirm Password: $confirmPassword');
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField({
    required String label,
    required Function(String?) onSaved,
    required String validatorMsg,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      decoration: InputDecoration(labelText: label, suffixIcon: suffixIcon),
      obscureText: obscureText,
      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorMsg;
        }
        return null;
      },
    );
  }
}
