import 'package:flutter/foundation.dart';

import '../../core/exceptions/api_exceptions.dart';
import '../models/child_model.dart';
import '../repositories/child_repository.dart';

class ChildSearchProvider extends ChangeNotifier {
  String _phoneNo;
  String _dob;
  Child _foundChild;
  bool _isLoading;
  bool _searchSuccess;

  final ChildRepository _childRepo;
  bool _hasError = false;
  Map _errors = {};
  String _errorMessage = '';

  ChildSearchProvider({
    @required ChildRepository childRepository,
  })  : this._childRepo = childRepository,
        this._isLoading = false;

  String get phoneNo => _phoneNo;
  String get dob => _dob;
  Child get foundChild => _foundChild;
  bool get isLoading => _isLoading;
  bool get searchSuccess => _searchSuccess;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;
  Map get errors => _errors;

  void _setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setPhoneNo(String phoneNo) {
    _phoneNo = phoneNo;
  }

  void setDob(String dob) {
    _dob = dob;
  }

  Future<void> searchChild() async {
    _setIsLoading(true);
    try {
      _searchSuccess = false;
      _hasError = false;
      _errorMessage = '';
      _errors = {};
      Child child = await _childRepo.findChild(_phoneNo, _dob);
      _searchSuccess = child == null ? false : true;
      _foundChild = child;
    } on ApiException catch (e) {
      _hasError = true;
      _errorMessage = e.message;
      if (e is InvalidInputException) {
        _errors = e.errors;
      }
    } catch (e) {
      print("ChildSearchProvider -> " + e.toString());
    } finally {
      _setIsLoading(false);
    }
  }
}
