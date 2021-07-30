import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../child/models/child_model.dart';
import '../../core/exceptions/api_exceptions.dart';
import '../../core/helpers/api_base_helper.dart';
import '../models/vaccination_record_model.dart';
import '../models/vaccine_model.dart';

class ChildVaccineRecordRepository {
  final ApiBaseHelper _apiBaseHelper;

  ChildVaccineRecordRepository({
    @required ApiBaseHelper apiBaseHelper,
  }) : this._apiBaseHelper = apiBaseHelper;

  Future<List<VaccinationRecord>> getChildVaccineRecord(Child child) async {
    List<VaccinationRecord> vaccinationRecords;
    try {
      String jsonResponse =
          await _apiBaseHelper.get('/children/${child.id}/vaccines');
      print(jsonResponse);
      vaccinationRecords = (json.decode(jsonResponse) as List)
          .map((vaccinationRecord) =>
              VaccinationRecord.fromMap(vaccinationRecord))
          .toList();
      print(vaccinationRecords);
    } on ApiException {
      rethrow;
    } catch (e) {
      print("ChildVaccineRecordRepository -> " + e.toString());
    }
    return vaccinationRecords;
  }

  Future<bool> addVaccineToChildRecord(Child child, Vaccine vaccine,
      {String photoPath}) async {
    try {
      String jsonResponse = await _apiBaseHelper.uploadFileMultipart(
        '/children/${child.id}/vaccines/${vaccine.id}',
        fieldName: 'photo',
        filePath: photoPath,
      );
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
