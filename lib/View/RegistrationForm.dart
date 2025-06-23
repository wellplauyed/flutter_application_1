import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../controllers/registration_controller.dart';

class RegistrationForm extends StatefulWidget {
  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final RegistrationController _controller = RegistrationController();

  String firstName = '';
  String lastName = '';
  String email = '';
  String selectedEmployee = 'Employee';
  List<String> employeeList = <String>['Employee'];

  String selectedPaymentPeriod = 'Select Payment Period';
  List<String> paymentList = <String>[
    'Select Payment Period',
    'Weekly',
    'Semi-Monthly',
  ];

  String selectedLocation = 'Select Office Location';
  List<String> locationList = <String>[
    'Select Office Location',
    'Cebu, PH',
    'Chicago, US',
    'LoS Angeles, US',
    'Manila, PH',
  ];

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

              // Employee Dropdown
              buildDropdown(
                label: 'Select Employee',
                value: selectedEmployee,
                list: employeeList,
                onChanged: (value) => setState(() => selectedEmployee = value),
              ),

              // Payment Period Dropdown
              buildDropdown(
                label: 'Select Payment Period',
                value: selectedPaymentPeriod,
                list: paymentList,
                onChanged: (value) =>
                    setState(() => selectedPaymentPeriod = value),
                validator: (value) {
                  if (value == 'Select Payment Period') {
                    return 'Please select a payment period';
                  }
                  return null;
                },
              ),

              // Location Dropdown
              buildDropdown(
                label: 'Select Office Location',
                value: selectedLocation,
                list: locationList,
                onChanged: (value) => setState(() => selectedLocation = value),
                validator: (value) {
                  if (value == 'Select Office Location') {
                    return 'Please select a location';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),
              ElevatedButton(onPressed: handleSubmit, child: Text('Continue')),
              SizedBox(height: 10),
              Center(child: Text('Already have an account? Sign in')),
            ],
          ),
        ),
      ),
    );
  }

  // 👇 Handle form submit and send data to controller
  Future<void> handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final user = User(
        firstName: firstName,
        lastName: lastName,
        email: email,
        employeeType: selectedEmployee,
        paymentPeriod: selectedPaymentPeriod,
        officeLocation: selectedLocation,
      );

      final response = await _controller.submitRegistration(user);

      // ✅ Show SnackBar based on result
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message']),
          backgroundColor: response['status'] ? Colors.green : Colors.red,
        ),
      );
    }
  }

  // 👇 Reusable dropdown widget
  Widget buildDropdown({
    required String label,
    required String value,
    required List<String> list,
    required Function(String) onChanged,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: value,
        items: list.map((item) {
          return DropdownMenuItem(value: item, child: Text(item));
        }).toList(),
        onChanged: (value) => onChanged(value!),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }

  // 👇 Reusable text field widget
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
