import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'vaccine_model.dart';

class VaccinationRecord {
  final int childId;
  final Vaccine vaccine;
  final String photoUrl;
  final DateTime vaccinationDate;
  VaccinationRecord({
    @required this.childId,
    @required this.vaccine,
    this.photoUrl,
    this.vaccinationDate,
  });

  VaccinationRecord copyWith({
    int childId,
    Vaccine vaccine,
    String photoUrl,
    DateTime vaccinationDate,
  }) {
    return VaccinationRecord(
      childId: childId ?? this.childId,
      vaccine: vaccine ?? this.vaccine,
      photoUrl: photoUrl ?? this.photoUrl,
      vaccinationDate: vaccinationDate ?? this.vaccinationDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'childId': childId,
      'vaccine': vaccine.toMap(),
      'photoUrl': photoUrl,
      'vaccinationDate': vaccinationDate.millisecondsSinceEpoch,
    };
  }

  factory VaccinationRecord.fromMap(Map<String, dynamic> map) {
    return VaccinationRecord(
      childId: int.parse(map['vaccinationRecord']['childId']),
      vaccine: Vaccine.fromMap(map),
      photoUrl: map['vaccinationRecord']['photo'],
      vaccinationDate:
          DateTime.tryParse(map['vaccinationRecord']['createdAt'] ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory VaccinationRecord.fromJson(String source) =>
      VaccinationRecord.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VaccinationRecord(childId: $childId, vaccineId: ${vaccine.id}, photoUrl: $photoUrl, vaccinationDate: $vaccinationDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VaccinationRecord &&
        other.childId == childId &&
        other.vaccine == vaccine &&
        other.photoUrl == photoUrl &&
        other.vaccinationDate == vaccinationDate;
  }

  @override
  int get hashCode {
    return childId.hashCode ^
        vaccine.hashCode ^
        photoUrl.hashCode ^
        vaccinationDate.hashCode;
  }
}
