import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../core/exceptions/api_exceptions.dart';
import '../../core/helpers/api_base_helper.dart';
import '../models/child_model.dart';
import '../models/vaccine_model.dart';

class ChildVaccineRecordRepository {
  final ApiBaseHelper _apiBaseHelper;

  ChildVaccineRecordRepository({
    @required ApiBaseHelper apiBaseHelper,
  }) : this._apiBaseHelper = apiBaseHelper;

  Future<List<Vaccine>> getChildVaccineRecord(Child child) async {
    List<Vaccine> vaccines;
    try {
      String jsonResponse =
          await _apiBaseHelper.get('/children/${child.id}/vaccines');
      print(jsonResponse);
      vaccines = (json.decode(jsonResponse) as List)
          .map((vaccine) => Vaccine.fromMap(vaccine))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      print("ChildVaccineRecordRepository -> " + e.toString());
    }
    return vaccines;
  }

  Future<bool> addVaccineToChildRecord(Child child, Vaccine vaccine) async {
    try {
      String jsonResponse = await _apiBaseHelper
          .post('/children/${child.id}/vaccines/${vaccine.id}');
      print(jsonResponse);
    } on ApiException {
      rethrow;
    } catch (e) {
      print("ChildVaccineRecordRepository -> " + e.toString());
      return false;
    }

    return true;
  }

  Future<bool> removeVaccineFromChildRecord(
      Child child, Vaccine vaccine) async {
    try {
      String jsonResponse = await _apiBaseHelper
          .delete('/children/${child.id}/vaccines/${vaccine.id}');
      print(jsonResponse);
    } on ApiException {
      rethrow;
    } catch (e) {
      print("ChildVaccineRecordRepository -> " + e.toString());
      return false;
    }

    return true;
  }
}
