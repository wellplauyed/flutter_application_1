class User {
  final String mobileNumber;
  final String companyEmail;
  User({required this.mobileNumber, this.companyEmail = ''});

  Map<String, dynamic> toJson() {
    return {'mobile_number': mobileNumber, 'company_email': companyEmail};
  }
}
