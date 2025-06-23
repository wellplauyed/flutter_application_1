import '../models/user_model.dart';
import '../services/api_service.dart';

class RegistrationController {
  Future<Map<String, dynamic>> submitRegistration(User user) async {
    return await ApiService.registerUser(user);
  }
}
