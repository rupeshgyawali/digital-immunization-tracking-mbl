import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'auth/repositories/auth_repository.dart';
import 'core/helpers/api_base_helper.dart';
import 'vaccination_record/repositories/child_repository.dart';
import 'vaccination_record/repositories/child_vaccine_record_repository.dart';
import 'vaccination_record/repositories/vaccine_repository.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

List<SingleChildWidget> independentServices = [
  Provider(
    create: (_) => ApiBaseHelper(
      baseUrl: 'http://localhost:8000/api',
      client: http.Client(),
    ),
    dispose: (_, ApiBaseHelper apiBaseHelper) {
      apiBaseHelper.client.close();
    },
  ),
];
List<SingleChildWidget> dependentServices = [
  ProxyProvider<ApiBaseHelper, AuthRepository>(
    update: (_, apiBaseHelper, __) =>
        AuthRepository(apiBaseHelper: apiBaseHelper),
  ),
  ProxyProvider<ApiBaseHelper, ChildRepository>(
    update: (_, apiBaseHelper, __) =>
        ChildRepository(apiBaseHelper: apiBaseHelper),
  ),
  ProxyProvider<ApiBaseHelper, VaccineRepository>(
    update: (_, apiBaseHelper, __) =>
        VaccineRepository(apiBaseHelper: apiBaseHelper),
  ),
  ProxyProvider<ApiBaseHelper, ChildVaccineRecordRepository>(
    update: (_, apiBaseHelper, __) =>
        ChildVaccineRecordRepository(apiBaseHelper: apiBaseHelper),
  ),
];
