import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../core/exceptions/api_exceptions.dart';
import '../../core/helpers/api_base_helper.dart';
import '../models/vaccine_model.dart';

class VaccineRepository {
  final ApiBaseHelper _apiBaseHelper;

  VaccineRepository({
    @required ApiBaseHelper apiBaseHelper,
  }) : this._apiBaseHelper = apiBaseHelper;

  Future<List<Vaccine>> getAllVaccines() async {
    List<Vaccine> vaccines;
    try {
      String jsonResponse = await _apiBaseHelper.get('/vaccines');
      print(jsonResponse);
      vaccines = (json.decode(jsonResponse) as List)
          .map((vaccine) => Vaccine.fromMap(vaccine))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      print("VaccineRepository -> " + e.toString());
    }
    return vaccines;
  }
}
