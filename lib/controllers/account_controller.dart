//create a class for account creation progress tracking
//true or false function to check if account creation has started
class AccountController {
  static bool _hasStarted = false;

  static void startAccountCreation() {
    _hasStarted = true;
  }

  static void resetProgress() {
    _hasStarted = false;
  }

  static bool get hasStarted => _hasStarted;
}
