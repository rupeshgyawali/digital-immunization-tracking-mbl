import 'package:flutter/foundation.dart';

import '../../child/models/child_model.dart';
import '../../core/exceptions/api_exceptions.dart';
import '../repositories/auth_repository.dart';

class ChildLoginProvider extends ChangeNotifier {
  String _phoneNo;
  String _otp;
  bool _isLoading;
  bool _otpSent;
  bool _loginSuccess;

  List<Child> _children;

  final AuthRepository _authRepo;
  bool _hasError = false;
  Map _errors = {};
  String _errorMessage = '';

  ChildLoginProvider({
    @required AuthRepository authRepository,
  })  : this._authRepo = authRepository,
        this._isLoading = false,
        this._otpSent = false;

  String get phoneNo => _phoneNo;
  String get otp => _otp;
  List<Child> get children => _children;
  bool get isLoading => _isLoading;
  bool get otpSent => _otpSent;
  bool get loginSuccess => _loginSuccess;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;
  Map get errors => _errors;

  void _setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setOtpSent(bool otpSent) {
    _otpSent = otpSent;
  }

  void setPhoneNo(String phoneNo) {
    _phoneNo = phoneNo;
  }

  void setOtp(String otp) {
    _otp = otp;
  }

  Future<void> loginChild() async {
    _setIsLoading(true);
    try {
      _hasError = false;
      _errorMessage = '';
      _errors = {};
      if (_otpSent) {
        List<Child> children = await _authRepo.loginChild(_phoneNo, _otp);
        _loginSuccess = children != null;
        _children = children;
      } else {
        _otpSent = await _authRepo.generateOtp(_phoneNo);
      }
    } on ApiException catch (e) {
      _hasError = true;
      _errorMessage = e.message;
      if (e is InvalidInputException) {
        _errors = e.errors;
      }
    } catch (e) {
      print("ChildLoginProvider -> " + e.toString());
    } finally {
      _setIsLoading(false);
    }
  }
}
