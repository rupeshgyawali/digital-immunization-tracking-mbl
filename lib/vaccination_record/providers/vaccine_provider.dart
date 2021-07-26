import 'package:flutter/foundation.dart';

import '../../core/exceptions/api_exceptions.dart';
import '../models/vaccine_model.dart';
import '../repositories/vaccine_repository.dart';

class VaccineProvider extends ChangeNotifier {
  List<Vaccine> _vaccines;

  final VaccineRepository _vaccineRepo;

  VaccineProvider({
    @required VaccineRepository vaccineRepo,
  }) : this._vaccineRepo = vaccineRepo;

  List<Vaccine> get vaccines => _vaccines;

  Future<void> getAllVaccines() async {
    try {
      _vaccines = await _vaccineRepo.getAllVaccines();
    } on ApiException catch (e) {
      print(e.toString());
    } catch (e) {
      print("VaccineProvider -> " + e.toString());
    }
    notifyListeners();
  }
}
