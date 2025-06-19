import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  String firstName = '';
  String lastName = '';
  String email = '';
  String employee = '';
  String paymentPeriod = '';
  String location = '';

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
                label: 'First Name',
                onSaved: (value) => firstName = value ?? '',
                validatorMsg: 'Please enter first name',
              ),
              buildTextFormField(
                label: 'Last Name',
                onSaved: (value) => lastName = value ?? '',
                validatorMsg: 'Please enter last name',
              ),
              buildTextFormField(
                label: 'Email',
                onSaved: (value) => email = value ?? '',
                validatorMsg: 'Please enter email',
                keyboardType: TextInputType.emailAddress,
              ),
              buildTextFormField(
                label: 'Employee',
                onSaved: (value) => employee = value ?? '',
                validatorMsg: 'Please enter employee',
              ),
              buildTextFormField(
                label: 'Payment Period',
                onSaved: (value) => paymentPeriod = value ?? '',
                validatorMsg: 'Please enter payment period',
              ),
              buildTextFormField(
                label: 'Location',
                onSaved: (value) => location = value ?? '',
                validatorMsg: 'Please enter location',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Now you have all values, do something with them
                    print('First Name: $firstName');
                    print('Last Name: $lastName');
                    print('Email: $email');
                    print('Employee: $employee');
                    print('Payment Period: $paymentPeriod');
                    print('Location: $location');
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
    required FormFieldSetter<String> onSaved,
    required String validatorMsg,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
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
