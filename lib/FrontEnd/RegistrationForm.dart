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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: DropdownButtonFormField<String>(
                  value: selectedEmployee,
                  items: employeeList.map((String employee) {
                    return DropdownMenuItem<String>(
                      value: employee,
                      child: Text(employee),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedEmployee = newValue!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Select Employee',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              // Payment Period Dropdown
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: DropdownButtonFormField<String>(
                  value: selectedPaymentPeriod,
                  items: paymentList.map((String period) {
                    return DropdownMenuItem<String>(
                      value: period,
                      child: Text(period),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPaymentPeriod = newValue!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Select Payment Period',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == 'Select Payment Period') {
                      return 'Please select a payment period';
                    }
                    return null;
                  },
                ),
              ),

              // Location Dropdown
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: DropdownButtonFormField<String>(
                  value: selectedLocation,
                  items: locationList.map((String location) {
                    return DropdownMenuItem<String>(
                      value: location,
                      child: Text(location),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedLocation = newValue!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Select Office Location',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == 'Select Office Location') {
                      return 'Please select a location';
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print('First Name: $firstName');
                    print('Last Name: $lastName');
                    print('Email: $email');
                    print('Employee: $selectedEmployee');
                    print('Payment Period: $selectedPaymentPeriod');
                    print('Location: $selectedLocation');
                  }
                },
                child: Text('Continue'),
              ),
              SizedBox(height: 10),
              Center(child: Text('Already have an account? Sign in')),
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
