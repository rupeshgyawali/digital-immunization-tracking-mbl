import 'dart:convert';

import 'package:flutter/foundation.dart';

class Vaccine {
  final int id;
  final String name;
  final String description;

  Vaccine({
    @required this.id,
    @required this.name,
    @required this.description,
  });

  Vaccine copyWith({
    int id,
    String name,
    String description,
  }) {
    return Vaccine(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory Vaccine.fromMap(Map<String, dynamic> map) {
    return Vaccine(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Vaccine.fromJson(String source) =>
      Vaccine.fromMap(json.decode(source));

  @override
  String toString() =>
      'Vaccine(id: $id, name: $name, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Vaccine &&
        other.id == id &&
        other.name == name &&
        other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode;
}
