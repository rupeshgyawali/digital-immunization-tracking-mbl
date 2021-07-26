import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class LocalAddress {
  final String province;
  final String district;
  final String municipality;
  final int wardNumber;

  LocalAddress({
    @required this.province,
    @required this.district,
    @required this.municipality,
    @required this.wardNumber,
  });

  LocalAddress copyWith({
    String province,
    String district,
    String municipality,
    int wardNumber,
  }) {
    return LocalAddress(
      province: province ?? this.province,
      district: district ?? this.district,
      municipality: municipality ?? this.municipality,
      wardNumber: wardNumber ?? this.wardNumber,
    );
  }

  @override
  String toString() {
    return '$municipality-$wardNumber, $district, $province';
  }
}

class LocalAddressField extends StatefulWidget {
  final void Function(LocalAddress) onSaved;
  final String label;

  const LocalAddressField({Key key, this.onSaved, this.label})
      : super(key: key);

  @override
  _LocalAddressFieldState createState() => _LocalAddressFieldState();
}

class _LocalAddressFieldState extends State<LocalAddressField> {
  String _selectedProvince;
  List _provinceList;
  String _selectedDistrict;
  List _districtList;
  String _selectedMunicipality;
  List _municipalityList;

  @override
  void initState() {
    _getProvinceList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            widget.label,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.lightBlueAccent),
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  hint: Text('Choose province'),
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  value: _selectedProvince,
                  items: _provinceList
                      ?.map((province) => DropdownMenuItem<String>(
                            child: Text(province['provinceName']),
                            value:
                                "${province['id']}-${province['provinceName']}",
                          ))
                      ?.toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedProvince = value;
                      int _provinceId = int.parse(value.split('-')[0]);
                      _selectedDistrict = null;
                      _selectedMunicipality = null;
                      _getDistrictList(_provinceId);
                    });
                  },
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  hint: Text('Choose district'),
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  value: _selectedDistrict,
                  items: _districtList
                      ?.map(
                        (district) => DropdownMenuItem<String>(
                          child: Text(district['districtName']),
                          value:
                              "${district['id']}-${district['districtName']}",
                        ),
                      )
                      ?.toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedDistrict = value;
                      int _districtId = int.parse(value.split('-')[0]);
                      _selectedMunicipality = null;
                      _getMunicipalityList(_districtId);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  hint: Text('Choose municipality'),
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  value: _selectedMunicipality,
                  items: _municipalityList
                      ?.map((municipality) => DropdownMenuItem<String>(
                            child: Text(municipality['municipalityName']),
                            value:
                                "${municipality['id']}-${municipality['municipalityName']}",
                          ))
                      ?.toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedMunicipality = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field is required';
                  } else if (!RegExp(r"^[0-9]+$").hasMatch(value)) {
                    return 'Invalid Ward Number';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Ward Number',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  LocalAddress _localAddress = LocalAddress(
                    province: _selectedProvince.split('-')[1],
                    district: _selectedDistrict.split('-')[1],
                    municipality: _selectedMunicipality.split('-')[1],
                    wardNumber: int.parse(value),
                  );
                  widget.onSaved(_localAddress);
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Future<void> _getProvinceList() async {
    String provinceListJson = await rootBundle.loadString('assets/province');
    setState(() {
      _provinceList = json.decode(provinceListJson);
    });
  }

  Future<void> _getDistrictList(int provinceId) async {
    String districtListJson =
        await rootBundle.loadString('district-by-province/$provinceId');
    setState(() {
      _districtList = json.decode(districtListJson);
    });
  }

  Future<void> _getMunicipalityList(int districtId) async {
    String municipalityListJson =
        await rootBundle.loadString('municipality-by-district/$districtId');
    setState(() {
      _municipalityList = json.decode(municipalityListJson);
    });
  }
}
