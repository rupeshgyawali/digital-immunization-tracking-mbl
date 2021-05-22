import 'package:flutter/foundation.dart';

import '../models/child_model.dart';
import '../repositories/child_repository.dart';

class ChildSearchProvider extends ChangeNotifier {
  String _phoneNo;
  String _dob;
  bool _isLoading;
  bool _searchSuccess;

  final ChildRepository _childRepo;

  ChildSearchProvider({
    @required ChildRepository childRepository,
  })  : this._childRepo = childRepository,
        this._isLoading = false;

  String get phoneNo => _phoneNo;
  String get dob => _dob;
  bool get isLoading => _isLoading;
  bool get searchSuccess => _searchSuccess;

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
      Child child = await _childRepo.findChild(_phoneNo, _dob);
      _searchSuccess = child == null ? false : true;
    } catch (e) {
      print("ChildSearchProvider -> " + e.toString());
    } finally {
      _setIsLoading(false);
    }
  }
}
