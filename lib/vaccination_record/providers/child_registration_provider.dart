import 'package:flutter/foundation.dart';

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
  String _temporaryAddr;
  String _permanentAddr;
  bool _isLoading;
  bool _registrationSuccess;

  final ChildRepository _childRepo;

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
  String get temporaryAddr => _temporaryAddr;
  String get permanentAddr => _permanentAddr;
  bool get isLoading => _isLoading;
  bool get registrationSuccess => _registrationSuccess;

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

  void setTemporaryAddr(String temporaryAddr) {
    _temporaryAddr = temporaryAddr;
  }

  void setPermanentAddr(String permanentAddr) {
    _permanentAddr = permanentAddr;
  }

  Future<void> registerChild() async {
    _setIsLoading(true);
    try {
      _registrationSuccess = false;
      Child child = await _childRepo.createChild(Child(
        name: _name,
        dob: _dob,
        birthPlace: _birthPlace,
        fatherName: _fatherName,
        motherName: _motherName,
        fatherPhn: _fatherPhn,
        motherPhn: _motherPhn,
        temporaryAddr: _temporaryAddr,
        permanentAddr: _permanentAddr,
      ));
      _registrationSuccess = child == null ? false : true;
    } catch (e) {
      print("ChildRegisterProvider -> " + e.toString());
    } finally {
      _setIsLoading(false);
    }
  }
}
