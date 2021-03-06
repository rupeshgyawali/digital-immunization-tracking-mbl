import 'package:flutter/foundation.dart';

import '../../core/exceptions/api_exceptions.dart';
import '../../core/widgets/local_address_field.dart';
import '../models/child_model.dart';
import '../repositories/child_repository.dart';

class ChildRegistrationProvider extends ChangeNotifier {
  String _name;
  String _dob;
  String _birthPlace;
  String _fatherName;
  String _motherName;
  String _fatherPhn;
  String _motherPhn;
  LocalAddress _temporaryAddr;
  LocalAddress _permanentAddr;
  Child _newChild;

  bool _isLoading;
  bool _registrationSuccess;

  final ChildRepository _childRepo;
  bool _hasError = false;
  Map _errors = {};
  String _errorMessage = '';

  ChildRegistrationProvider({
    @required ChildRepository childRepository,
  })  : this._childRepo = childRepository,
        this._isLoading = false;

  String get name => _name;
  String get dob => _dob;
  String get birthPlace => _birthPlace;
  String get fatherName => _fatherName;
  String get motherName => _motherName;
  String get fatherPhn => _fatherPhn;
  String get motherPhn => _motherPhn;
  LocalAddress get temporaryAddr => _temporaryAddr;
  LocalAddress get permanentAddr => _permanentAddr;
  Child get newChild => _newChild;
  bool get isLoading => _isLoading;
  bool get registrationSuccess => _registrationSuccess;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;
  Map get errors => _errors;

  void _setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
  }

  void setDob(String dob) {
    _dob = dob;
  }

  void setBirthPlace(String birthPlace) {
    _birthPlace = birthPlace;
  }

  void setFatherName(String fatherName) {
    _fatherName = fatherName;
  }

  void setMotherName(String motherName) {
    _motherName = motherName;
  }

  void setFatherPhn(String fatherPhn) {
    _fatherPhn = fatherPhn;
  }

  void setMotherPhn(String motherPhn) {
    _motherPhn = motherPhn;
  }

  void setTemporaryAddr(LocalAddress temporaryAddr) {
    _temporaryAddr = temporaryAddr;
  }

  void setPermanentAddr(LocalAddress permanentAddr) {
    _permanentAddr = permanentAddr;
  }

  Future<void> registerChild() async {
    _setIsLoading(true);
    try {
      _registrationSuccess = false;
      _hasError = false;
      _errorMessage = '';
      _errors = {};
      Child child = await _childRepo.createChild(Child(
        name: _name,
        dob: _dob,
        birthPlace: _birthPlace,
        fatherName: _fatherName,
        motherName: _motherName,
        fatherPhn: _fatherPhn,
        motherPhn: _motherPhn,
        temporaryAddr: _temporaryAddr.toString(),
        permanentAddr: _permanentAddr?.toString() ?? _temporaryAddr.toString(),
      ));
      _registrationSuccess = child == null ? false : true;
      _newChild = child;
    } on ApiException catch (e) {
      _hasError = true;
      _errorMessage = e.message;
      if (e is InvalidInputException) {
        _errors = e.errors;
      }
    } catch (e) {
      print("ChildRegisterProvider -> " + e.toString());
    } finally {
      _setIsLoading(false);
    }
  }
}
