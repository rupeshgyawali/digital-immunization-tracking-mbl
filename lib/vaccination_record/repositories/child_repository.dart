import 'package:flutter/foundation.dart';

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
          await _apiBaseHelper.get('/children?phoneNo=$phoneNo&dob=$dob');
      print(jsonResponse);
      child = Child.fromJson(jsonResponse);
    } catch (e) {
      print("ChildRepository -> " + e.toString());
    }
    return child;
  }
}
