import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../child/models/child_model.dart';
import '../../config.dart';
import '../../core/models/app_state.dart';
import '../models/vaccine_model.dart';
import '../providers/child_vaccine_record_provider.dart';
import '../providers/vaccine_provider.dart';
import '../repositories/child_vaccine_record_repository.dart';
import '../repositories/vaccine_repository.dart';

final TextStyle textStyle = TextStyle(color: Colors.white, height: 1.25);
final TextStyle textStyleBold = textStyle.copyWith(
    fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2);
final TextStyle textStyleDark = TextStyle(color: Colors.black, height: 1.25);
final TextStyle textStyleBoldDark = textStyle.copyWith(
    fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2);

const BorderRadius bottomRoundedBorderRadius = BorderRadius.only(
    bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0));

class ChildVaccineRecordScreen extends StatelessWidget {
  final Child child;
  final bool isEditable;

  const ChildVaccineRecordScreen({
    Key key,
    @required this.child,
    this.isEditable = true,
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
        body: Consumer<ChildVaccineRecordProvider>(
          builder: (context, provider, __) => ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: bottomRoundedBorderRadius,
                  color: Theme.of(context).primaryColor,
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: MediaQuery.of(context).padding,
                        height: 135,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.4),
                                BlendMode.dstATop),
                            image: AssetImage('assets/cover.jpg'),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              InkWell(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 20.0),
                                    Text(
                                      'LOGO',
                                      style: TextStyle(
                                        fontSize: 27,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 7,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.only(top: 70),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                SizedBox(width: double.infinity),
                                CircleAvatar(
                                  radius: 70,
                                  child: Text(
                                    child.name?.substring(0, 1) ?? '',
                                    style: TextStyle(fontSize: 58),
                                  ),
                                  foregroundImage: NetworkImage(
                                    "${Config.storageUrl}/${context.watch<ChildVaccineRecordProvider>()?.vaccinationRecords?.last?.photoUrl ?? ' '}",
                                  ),
                                  onForegroundImageError: (obj, __) {
                                    print(obj);
                                  },
                                ),
                                SizedBox(height: 6.0),
                                Column(
                                  children: [
                                    Text(
                                      child.name,
                                      style: textStyleBold,
                                    ),
                                    Text(
                                      child.birthPlace,
                                      style: textStyle,
                                    ),
                                    Text(
                                      child.temporaryAddr,
                                      style: textStyle,
                                    ),
                                    Text(
                                      child.dob,
                                      style: textStyle,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30.0),
                              ],
                            ),
                            Divider(color: Colors.white),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              decoration: BoxDecoration(
                                borderRadius: bottomRoundedBorderRadius,
                                // color: Theme.of(context)
                                //     .primaryColor
                                //     .withOpacity(0.6),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                                color: Colors.white,
                                                width: 1.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Father",
                                                style: textStyleBold,
                                              ),
                                              Text(
                                                '${child.fatherName}',
                                                style: textStyle,
                                              ),
                                              Text(
                                                '${child.fatherPhn}',
                                                style: textStyle,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Text(
                                            'Mother',
                                            style: textStyleBold,
                                          ),
                                          Text(
                                            '${child.motherName}',
                                            style: textStyle,
                                          ),
                                          Text(
                                            '${child.motherPhn}',
                                            style: textStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ChildVaccineDetails(isEditable: this.isEditable),
            ],
          ),
        ),
      ),
    );
  }
}

class ChildVaccineDetails extends StatelessWidget {
  ChildVaccineDetails({Key key, this.isEditable = true}) : super(key: key);

  final ImagePicker _picker = ImagePicker();
  final bool isEditable;

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
                                      ? Theme.of(context).primaryColor
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
                                              color: context
                                                      .watch<
                                                          ChildVaccineRecordProvider>()
                                                      .vaccines
                                                      .contains(vaccine)
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                          Text(
                                            vaccine.description,
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              height: 1.25,
                                              color: context
                                                      .watch<
                                                          ChildVaccineRecordProvider>()
                                                      .vaccines
                                                      .contains(vaccine)
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                          context
                                                  .watch<
                                                      ChildVaccineRecordProvider>()
                                                  .vaccines
                                                  .contains(vaccine)
                                              ? Text(
                                                  "On ${context.watch<ChildVaccineRecordProvider>().getVaccinationDateFromVaccine(vaccine)}",
                                                  style: textStyle,
                                                )
                                              : Text(''),
                                        ],
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 1.5,
                                      child: Switch(
                                        activeTrackColor:
                                            Theme.of(context).primaryColor,
                                        activeColor:
                                            Theme.of(context).primaryColor,
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
    if (!isEditable) return;
    if (value) {
      if (!await _showUploadPhotoDialog(context)) return;
      final XFile pickedFile =
          await this._picker.pickImage(source: ImageSource.camera);
      print(pickedFile.path);
      bool _accept = true;
      if (kIsWeb) {
        _accept = await _showUploadNotSupportedDialog(context);
      }
      if (!_accept) return;
      context
          .read<ChildVaccineRecordProvider>()
          .addVaccineToChildRecord(vaccine, photoPath: pickedFile.path);
    } else {
      context
          .read<ChildVaccineRecordProvider>()
          .removeVaccineFromChildRecord(vaccine);
    }
  }

  Future<bool> _showUploadNotSupportedDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Add record without photo?'),
        content: Text('Image upload is not supported on web.'),
        actions: [
          TextButton(
            child: Text('No'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          TextButton(
            child: Text('Yes'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
    );
  }

  Future<bool> _showUploadPhotoDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Take Vaccination Photo'),
            actionsPadding: EdgeInsets.symmetric(horizontal: 20.0),
            actions: [
              Center(
                child: TextButton(
                  child: Text('Open Camera'),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}
