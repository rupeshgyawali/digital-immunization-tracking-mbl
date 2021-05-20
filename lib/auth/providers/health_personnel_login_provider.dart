import 'package:flutter/foundation.dart';

import '../repositories/auth_repository.dart';

class HealthPersonnelLoginProvider extends ChangeNotifier {
  String _email;
  String _password;
  bool _isLoading;
  bool _loginSuccess;

  final AuthRepository _authRepo;

  HealthPersonnelLoginProvider({
    @required AuthRepository authRepository,
  })  : this._authRepo = authRepository,
        this._isLoading = false,
        this._loginSuccess = false;

  String get email => _email;
  String get password => _password;
  bool get isLoading => _isLoading;
  bool get loginSuccess => _loginSuccess;

  void _setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  Future<void> login() async {
    _setIsLoading(true);
    try {
      _loginSuccess = false;
      _loginSuccess = await _authRepo.loginHealthPersonnel(_email, _password);
    } catch (e) {
      print("HealthPersonnelLoginProvider -> " + e.toString());
    } finally {
      _setIsLoading(false);
    }
  }
}
