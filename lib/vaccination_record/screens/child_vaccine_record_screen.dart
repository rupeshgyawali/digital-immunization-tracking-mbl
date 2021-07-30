import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../child/models/child_model.dart';
import '../../core/models/app_state.dart';
import '../models/vaccine_model.dart';
import '../providers/child_vaccine_record_provider.dart';
import '../providers/vaccine_provider.dart';
import '../repositories/child_vaccine_record_repository.dart';
import '../repositories/vaccine_repository.dart';

class ChildVaccineRecordScreen extends StatelessWidget {
  final Child child;

  const ChildVaccineRecordScreen({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChildVaccineRecordProvider>(
      create: (_) {
        ChildVaccineRecordProvider childVaccineRecordProvider =
            ChildVaccineRecordProvider(
          childVaccineRecordRepo: context.read<ChildVaccineRecordRepository>(),
          child: child,
        );
        childVaccineRecordProvider.getChildVaccineRecord();
        return childVaccineRecordProvider;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFDCDCDC),
        appBar: AppBar(),
        body: Consumer<ChildVaccineRecordProvider>(
          builder: (context, provider, __) => ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(vertical: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: double.infinity),
                    CircleAvatar(
                      radius: 75,
                      child: Text(
                        child.name?.substring(0, 1) ?? '',
                        textScaleFactor: 2,
                      ),
                      // foregroundImage: NetworkImage(
                      //     "http://localhost:8000/storage/${context.watch<ChildVaccineRecordProvider>()?.vaccinationRecords?.last?.photoUrl ?? ' '}"),
                    ),
                    SizedBox(height: 6.0),
                    Column(
                      children: [
                        Text(child.name),
                        Text(child.temporaryAddr),
                        Text(child.dob),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(child.fatherName),
                              Text(child.fatherPhn),
                              Text(
                                "Father",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(child.motherName),
                              Text(child.motherPhn),
                              Text(
                                'Mother',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              ChildVaccineDetails(),
            ],
          ),
        ),
      ),
    );
  }
}

class ChildVaccineDetails extends StatelessWidget {
  ChildVaccineDetails({
    Key key,
  }) : super(key: key);

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VaccineProvider>(
      create: (_) {
        VaccineProvider vaccineProvider =
            VaccineProvider(vaccineRepo: context.read<VaccineRepository>());
        vaccineProvider.getAllVaccines();
        return vaccineProvider;
      },
      child: Consumer<VaccineProvider>(
        builder: (context, provider, child) => Container(
          child: (provider.vaccines == null ||
                  context
                          .read<ChildVaccineRecordProvider>()
                          .vaccinationRecords ==
                      null)
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 20.0),
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          'Vaccines',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    ...context
                        .watch<VaccineProvider>()
                        .vaccines
                        .map((vaccine) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 8.0),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(25.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: context
                                          .watch<ChildVaccineRecordProvider>()
                                          .vaccines
                                          .contains(vaccine)
                                      ? Colors.green
                                      : Colors.white70,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            vaccine.name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22.0,
                                            ),
                                          ),
                                          Text(
                                            vaccine.description,
                                            style: TextStyle(
                                              fontSize: 12.0,
                                            ),
                                          ),
                                          context
                                                  .watch<
                                                      ChildVaccineRecordProvider>()
                                                  .vaccines
                                                  .contains(vaccine)
                                              ? Text(
                                                  "On ${context.watch<ChildVaccineRecordProvider>().getVaccinationDateFromVaccine(vaccine)}",
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                  ),
                                                )
                                              : Text(''),
                                        ],
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 1.5,
                                      child: Switch(
                                        activeTrackColor: Colors.green,
                                        activeColor: Colors.green,
                                        value: context
                                            .watch<ChildVaccineRecordProvider>()
                                            .vaccines
                                            .contains(vaccine),
                                        onChanged: context
                                                .watch<AppState>()
                                                .isLoggedIn
                                            ? (value) {
                                                _onSwitchChanged(
                                                    context, value, vaccine);
                                              }
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> _onSwitchChanged(
      BuildContext context, bool value, Vaccine vaccine) async {
    if (value) {
      final XFile pickedFile =
          await this._picker.pickImage(source: ImageSource.camera);
      print(pickedFile.path);
      context
          .read<ChildVaccineRecordProvider>()
          .addVaccineToChildRecord(vaccine, photoPath: pickedFile.path);
    } else {
      context
          .read<ChildVaccineRecordProvider>()
          .removeVaccineFromChildRecord(vaccine);
    }
  }
}
