import 'package:flutter/foundation.dart';

import '../../core/exceptions/api_exceptions.dart';
import '../../core/helpers/api_base_helper.dart';
import '../models/child_model.dart';

class ChildRepository {
  final ApiBaseHelper _apiBaseHelper;

  ChildRepository({
    @required ApiBaseHelper apiBaseHelper,
  }) : this._apiBaseHelper = apiBaseHelper;

  Future<Child> findChild(String phoneNo, String dob) async {
    Child child;
    try {
      String jsonResponse =
          await _apiBaseHelper.get('/children?phone_no=$phoneNo&dob=$dob');
      print(jsonResponse);
      child = Child.fromJson(jsonResponse);
    } on ApiException {
      rethrow;
    } catch (e) {
      print("ChildRepository -> " + e.toString());
    }
    return child;
  }

  Future<Child> createChild(Child child) async {
    Child _newChild;
    try {
      String jsonResponse =
          await _apiBaseHelper.post('/children', data: child.toJson());
      print(jsonResponse);
      _newChild = Child.fromJson(jsonResponse);
    } on ApiException {
      rethrow;
    } catch (e) {
      print("ChildRepository -> " + e.toString());
    }
    return _newChild;
  }
}
