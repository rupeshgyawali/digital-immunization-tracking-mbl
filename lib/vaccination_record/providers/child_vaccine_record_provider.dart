import 'package:flutter/foundation.dart';

import '../../child/models/child_model.dart';
import '../../core/exceptions/api_exceptions.dart';
import '../models/vaccination_record_model.dart';
import '../models/vaccine_model.dart';
import '../repositories/child_vaccine_record_repository.dart';

class ChildVaccineRecordProvider extends ChangeNotifier {
  Child _child;
  List<VaccinationRecord> _vaccinationRecords;
  List<Vaccine> _vaccines;

  final ChildVaccineRecordRepository _childVaccineRecordRepo;

  ChildVaccineRecordProvider({
    @required ChildVaccineRecordRepository childVaccineRecordRepo,
    @required Child child,
  })  : this._childVaccineRecordRepo = childVaccineRecordRepo,
        this._child = child;

  Child get child => _child;
  List<VaccinationRecord> get vaccinationRecords => _vaccinationRecords;
  List<Vaccine> get vaccines => _vaccines;

  void _addVaccine(Vaccine vaccine) {
    _vaccines.add(vaccine);
    notifyListeners();
  }

  void _removeVaccine(Vaccine vaccine) {
    _vaccines.remove(vaccine);
    notifyListeners();
  }

  String getVaccinationDateFromVaccine(Vaccine vaccine) {
    for (VaccinationRecord vaccinationRecord in _vaccinationRecords) {
      if (vaccinationRecord.vaccine.id == vaccine.id) {
        return vaccinationRecord.vaccinationDate
                ?.toString()
                ?.substring(0, 10)
                ?.replaceAll(RegExp(r'-'), '/') ??
            '';
      }
    }
    return '';
  }

  String getPhotoUrlFromVaccine(Vaccine vaccine) {
    for (VaccinationRecord vaccinationRecord in _vaccinationRecords) {
      if (vaccinationRecord.vaccine.id == vaccine.id) {
        return vaccinationRecord.photoUrl;
      }
    }
    return null;
  }

  String getPhotoUrlForChild() {
    if (_vaccinationRecords?.isEmpty ?? true) {
      return '';
    }
    return _vaccinationRecords.last?.photoUrl ?? '';
  }

  Future<void> getChildVaccineRecord() async {
    try {
      _vaccinationRecords =
          await _childVaccineRecordRepo.getChildVaccineRecord(_child);
      _vaccines = _vaccinationRecords
          .map((vaccinationRecord) => vaccinationRecord.vaccine)
          .toList();
    } on ApiException catch (e) {
      print(e.toString());
    } catch (e) {
      print("ChildVaccineRecordProvider -> " + e.toString());
    }
    notifyListeners();
  }

  Future<bool> addVaccineToChildRecord(Vaccine vaccine,
      {String photoPath}) async {
    bool _success = false;
    _addVaccine(vaccine);
    try {
      _success = await _childVaccineRecordRepo
          .addVaccineToChildRecord(_child, vaccine, photoPath: photoPath);
    } on ApiException catch (e) {
      print(e.toString());
    } catch (e) {
      print("ChildVaccineRecordProvider -> " + e.toString());
    }

    getChildVaccineRecord();

    return _success;
  }

  Future<bool> removeVaccineFromChildRecord(Vaccine vaccine) async {
    bool _success = false;
    _removeVaccine(vaccine);
    try {
      _success = await _childVaccineRecordRepo.removeVaccineFromChildRecord(
          _child, vaccine);
    } on ApiException catch (e) {
      print(e.toString());
    } catch (e) {
      print("ChildVaccineRecordProvider -> " + e.toString());
    }

    getChildVaccineRecord();

    return _success;
  }
}
