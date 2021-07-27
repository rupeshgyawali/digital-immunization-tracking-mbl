import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/child_model.dart';
import '../providers/child_vaccine_record_provider.dart';
import '../providers/vaccine_provider.dart';
import '../repositories/child_vaccine_record_repository.dart';
import '../repositories/vaccine_repository.dart';

class ChildDetailsScreen extends StatelessWidget {
  final Child child;

  const ChildDetailsScreen({
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
        body: Consumer<ChildVaccineRecordProvider>(
          builder: (context, _, __) => ListView(
            children: [
              Container(
                color: Colors.white70,
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: double.infinity),
                    CircleAvatar(
                      radius: 75,
                      backgroundImage: NetworkImage(
                          "https://media.istockphoto.com/photos/doctor-giving-an-injection-vaccine-to-a-girl-little-girl-crying-with-picture-id1025414242?k=6&m=1025414242&s=612x612&w=0&h=NZVqNKu15qSleWuFERrzfvhK-JFvOdHef2bqJCrXKqY="),
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
  const ChildVaccineDetails({
    Key key,
  }) : super(key: key);

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
                  context.read<ChildVaccineRecordProvider>().vaccines == null)
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: <Widget>[
                    Text(
                      'Vaccines',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    ...context
                        .watch<VaccineProvider>()
                        .vaccines
                        .map((vaccine) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.infinity,
                                height: 100.0,
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.white70,
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
                                        ],
                                      ),
                                    ),
                                    Switch(
                                      value: context
                                          .watch<ChildVaccineRecordProvider>()
                                          .vaccines
                                          .contains(vaccine),
                                      onChanged: (value) {
                                        if (value) {
                                          context
                                              .read<
                                                  ChildVaccineRecordProvider>()
                                              .addVaccineToChildRecord(vaccine);
                                        } else {
                                          context
                                              .read<
                                                  ChildVaccineRecordProvider>()
                                              .removeVaccineFromChildRecord(
                                                  vaccine);
                                        }
                                      },
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
}
