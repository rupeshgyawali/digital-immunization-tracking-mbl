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
}
