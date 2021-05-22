import 'dart:convert';

import 'package:flutter/foundation.dart';

class Child {
  final String name;
  final String dob;
  final String birthPlace;
  final String fatherName;
  final String motherName;
  final String fatherPhn;
  final String motherPhn;
  final String temporaryAddr;
  final String permanentAddr;

  Child({
    this.name,
    @required this.dob,
    @required this.birthPlace,
    @required this.fatherName,
    @required this.motherName,
    this.fatherPhn,
    this.motherPhn,
    this.temporaryAddr,
    this.permanentAddr,
  })  : assert(fatherPhn != null || motherPhn != null,
            'Either father or mother phone number is requied'),
        assert(temporaryAddr != null || permanentAddr != null,
            'Both temporary and permanent address can not be null');

  Child copyWith({
    String name,
    String dob,
    String birthPlace,
    String fatherName,
    String motherName,
    String fatherPhn,
    String motherPhn,
    String temporaryAddr,
    String permanentAddr,
  }) {
    return Child(
      name: name ?? this.name,
      dob: dob ?? this.dob,
      birthPlace: birthPlace ?? this.birthPlace,
      fatherName: fatherName ?? this.fatherName,
      motherName: motherName ?? this.motherName,
      fatherPhn: fatherPhn ?? this.fatherPhn,
      motherPhn: motherPhn ?? this.motherPhn,
      temporaryAddr: temporaryAddr ?? this.temporaryAddr,
      permanentAddr: permanentAddr ?? this.permanentAddr,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dob': dob,
      'birthPlace': birthPlace,
      'fatherName': fatherName,
      'motherName': motherName,
      'fatherPhn': fatherPhn,
      'motherPhn': motherPhn,
      'temporaryAddr': temporaryAddr,
      'permanentAddr': permanentAddr,
    };
  }

  factory Child.fromMap(Map<String, dynamic> map) {
    return Child(
      name: map['name'],
      dob: map['dob'],
      birthPlace: map['birthPlace'],
      fatherName: map['fatherName'],
      motherName: map['motherName'],
      fatherPhn: map['fatherPhn'],
      motherPhn: map['motherPhn'],
      temporaryAddr: map['temporaryAddr'],
      permanentAddr: map['permanentAddr'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Child.fromJson(String source) => Child.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Child(name: $name, dob: $dob, birthPlace: $birthPlace, fatherName: $fatherName, motherName: $motherName, fatherPhn: $fatherPhn, motherPhn: $motherPhn, temporaryAddr: $temporaryAddr, permanentAddr: $permanentAddr)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Child &&
        other.name == name &&
        other.dob == dob &&
        other.birthPlace == birthPlace &&
        other.fatherName == fatherName &&
        other.motherName == motherName &&
        other.fatherPhn == fatherPhn &&
        other.motherPhn == motherPhn &&
        other.temporaryAddr == temporaryAddr &&
        other.permanentAddr == permanentAddr;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        dob.hashCode ^
        birthPlace.hashCode ^
        fatherName.hashCode ^
        motherName.hashCode ^
        fatherPhn.hashCode ^
        motherPhn.hashCode ^
        temporaryAddr.hashCode ^
        permanentAddr.hashCode;
  }
}
