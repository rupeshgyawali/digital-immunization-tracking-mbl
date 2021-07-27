import 'package:flutter/foundation.dart';

import '../../core/exceptions/api_exceptions.dart';
import '../models/child_model.dart';
import '../models/vaccine_model.dart';
import '../repositories/child_vaccine_record_repository.dart';

class ChildVaccineRecordProvider extends ChangeNotifier {
  Child _child;
  List<Vaccine> _vaccines;

  final ChildVaccineRecordRepository _childVaccineRecordRepo;

  ChildVaccineRecordProvider({
    @required ChildVaccineRecordRepository childVaccineRecordRepo,
    @required Child child,
  })  : this._childVaccineRecordRepo = childVaccineRecordRepo,
        this._child = child;

  Child get child => _child;
  List<Vaccine> get vaccines => _vaccines;

  void _addVaccine(Vaccine vaccine) {
    _vaccines.add(vaccine);
    notifyListeners();
  }

  void _removeVaccine(Vaccine vaccine) {
    _vaccines.remove(vaccine);
    notifyListeners();
  }

  Future<void> getChildVaccineRecord() async {
    try {
      _vaccines = await _childVaccineRecordRepo.getChildVaccineRecord(_child);
    } on ApiException catch (e) {
      print(e.toString());
    } catch (e) {
      print("ChildVaccineRecordProvider -> " + e.toString());
    }
    notifyListeners();
  }

  Future<bool> addVaccineToChildRecord(Vaccine vaccine) async {
    bool _success = false;
    _addVaccine(vaccine);
    try {
      _success = await _childVaccineRecordRepo.addVaccineToChildRecord(
          _child, vaccine);
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
