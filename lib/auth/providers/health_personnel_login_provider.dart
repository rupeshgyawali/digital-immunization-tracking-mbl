import 'package:flutter/foundation.dart';

import '../../core/exceptions/api_exceptions.dart';
import '../repositories/auth_repository.dart';

class HealthPersonnelLoginProvider extends ChangeNotifier {
  String _email;
  String _password;
  bool _isLoading;
  bool _loginSuccess;

  final AuthRepository _authRepo;
  bool _hasError = false;
  Map _errors = {};
  String _errorMessage = '';

  HealthPersonnelLoginProvider({
    @required AuthRepository authRepository,
  })  : this._authRepo = authRepository,
        this._isLoading = false,
        this._loginSuccess = false;

  String get email => _email;
  String get password => _password;
  bool get isLoading => _isLoading;
  bool get loginSuccess => _loginSuccess;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;
  Map get errors => _errors;

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
      _hasError = false;
      _errorMessage = '';
      _errors = {};
      _loginSuccess = await _authRepo.loginHealthPersonnel(_email, _password);
    } on ApiException catch (e) {
      _hasError = true;
      _errorMessage = e.message;
      if (e is InvalidInputException) {
        _errors = e.errors;
      }
    } catch (e) {
      print("HealthPersonnelLoginProvider -> " + e.toString());
    } finally {
      _setIsLoading(false);
    }
  }
}
