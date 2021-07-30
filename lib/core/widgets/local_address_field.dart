import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Province {
  final int id;
  final String provinceName;

  Province(this.id, this.provinceName);
}

class District {
  final int id;
  final String districtName;

  District(this.id, this.districtName);
}

class Municipality {
  final int id;
  final String municipalityName;

  Municipality(this.id, this.municipalityName);
}

class LocalAddress {
  final Province province;
  final District district;
  final Municipality municipality;
  final int wardNumber;

  LocalAddress({
    @required this.province,
    @required this.district,
    @required this.municipality,
    @required this.wardNumber,
  });

  LocalAddress copyWith({
    Province province,
    District district,
    Municipality municipality,
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
    return '${municipality.municipalityName}-$wardNumber, ${district.districtName}, ${province.provinceName}';
  }
}

class LocalAddressField extends StatefulWidget {
  final void Function(LocalAddress) onSaved;
  final void Function(LocalAddress) onChanged;
  final String label;
  final LocalAddress initialValue;
  final bool isRequired;

  const LocalAddressField(
      {Key key,
      this.onSaved,
      @required this.label,
      this.initialValue,
      this.onChanged,
      this.isRequired = false})
      : super(key: key);

  @override
  _LocalAddressFieldState createState() => _LocalAddressFieldState();
}

class _LocalAddressFieldState extends State<LocalAddressField> {
  Province _selectedProvince;
  List<Province> _provinceList;
  District _selectedDistrict;
  List<District> _districtList;
  Municipality _selectedMunicipality;
  List<Municipality> _municipalityList;
  int _wardNumber;

  LocalAddress _localAddress;

  final AutovalidateMode _autovalidateMode = AutovalidateMode.onUserInteraction;

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
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.label,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.lightBlueAccent),
                ),
                widget.isRequired
                    ? TextSpan(text: ' *', style: TextStyle(color: Colors.red))
                    : TextSpan(text: ''),
              ],
            ),
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
                child: DropdownButtonFormField<Province>(
                  hint: Text('Province'),
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  autovalidateMode: _autovalidateMode,
                  validator: widget.isRequired ? requiredValidator : null,
                  value: _selectedProvince,
                  items: _provinceList
                      ?.map((province) => DropdownMenuItem<Province>(
                            child: Text(province.provinceName),
                            value: province,
                          ))
                      ?.toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedProvince = value;
                      _selectedDistrict = null;
                      _selectedMunicipality = null;
                      _getDistrictList(_selectedProvince.id);
                    });
                  },
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<District>(
                  hint: Text('District'),
                  isExpanded: true,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  autovalidateMode: _autovalidateMode,
                  validator: widget.isRequired ? requiredValidator : null,
                  value: _selectedDistrict,
                  items: _districtList
                      ?.map(
                        (district) => DropdownMenuItem<District>(
                          child: Text(district.districtName),
                          value: district,
                        ),
                      )
                      ?.toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedDistrict = value;
                      _selectedMunicipality = null;
                      _getMunicipalityList(_selectedDistrict.id);
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
                child: DropdownButtonFormField<Municipality>(
                  hint: Text('Municipality'),
                  isExpanded: true,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  autovalidateMode: _autovalidateMode,
                  validator: widget.isRequired ? requiredValidator : null,
                  value: _selectedMunicipality,
                  items: _municipalityList
                      ?.map((municipality) => DropdownMenuItem<Municipality>(
                            child: Text(municipality.municipalityName),
                            value: municipality,
                          ))
                      ?.toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedMunicipality = value;
                    });
                    setLocalAddress();
                    if (widget.onChanged != null)
                      widget.onChanged(_localAddress);
                  },
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: TextFormField(
                autovalidateMode: _autovalidateMode,
                initialValue: _wardNumber?.toString(),
                validator: (value) {
                  if (value.isEmpty) {
                    if (widget.isRequired) return 'This field is required';
                  } else if (!RegExp(r"^[0-9]$|^[0-3][0-9]?$")
                      .hasMatch(value)) {
                    return 'Invalid Ward Number';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Ward Number',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _wardNumber = int.tryParse(value);
                  setLocalAddress();
                  if (widget.onChanged != null) widget.onChanged(_localAddress);
                },
                onSaved: (value) {
                  _wardNumber = int.tryParse(value);
                  setLocalAddress();
                  if (widget.onSaved != null) widget.onSaved(_localAddress);
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

  void setLocalAddress() {
    if (_selectedProvince == null ||
        _selectedDistrict == null ||
        _selectedMunicipality == null ||
        _wardNumber == null ||
        _wardNumber >= 40) {
      return;
    }
    _localAddress = LocalAddress(
      province: _selectedProvince,
      district: _selectedDistrict,
      municipality: _selectedMunicipality,
      wardNumber: _wardNumber,
    );
  }

  Future<void> _getProvinceList() async {
    String provinceListJson = await rootBundle.loadString('assets/province');
    setState(() {
      _provinceList = (json.decode(provinceListJson) as List)
          .map((province) => Province(province['id'], province['provinceName']))
          .toList();
    });
  }

  Future<void> _getDistrictList(int provinceId) async {
    String districtListJson =
        await rootBundle.loadString('district-by-province/$provinceId');
    setState(() {
      _districtList = (json.decode(districtListJson) as List)
          .map((district) => District(district['id'], district['districtName']))
          .toList();
    });
  }

  Future<void> _getMunicipalityList(int districtId) async {
    String municipalityListJson =
        await rootBundle.loadString('municipality-by-district/$districtId');
    setState(() {
      _municipalityList = (json.decode(municipalityListJson) as List)
          .map((municipality) => Municipality(
              municipality['id'], municipality['municipalityName']))
          .toList();
    });
  }
}

String requiredValidator(value) {
  if (value == null) {
    return 'This field is required';
  }

  return null;
}
