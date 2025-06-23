class User {
  final String firstName;
  final String lastName;
  final String email;
  final String employeeType;
  final String paymentPeriod;
  final String officeLocation;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.employeeType,
    required this.paymentPeriod,
    required this.officeLocation,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'employee_type': employeeType,
      'payment_period': paymentPeriod,
      'office_location': officeLocation,
    };
  }
}
