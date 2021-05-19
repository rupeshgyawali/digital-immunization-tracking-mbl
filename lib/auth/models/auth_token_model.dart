import 'dart:convert';

import 'package:flutter/foundation.dart';

class AuthToken {
  final String token;
  AuthToken({
    @required this.token,
  });

  AuthToken copyWith({
    String token,
  }) {
    return AuthToken(
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
    };
  }

  factory AuthToken.fromMap(Map<String, dynamic> map) {
    return AuthToken(
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthToken.fromJson(String source) =>
      AuthToken.fromMap(json.decode(source));

  @override
  String toString() => 'AuthToken(token: $token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthToken && other.token == token;
  }

  @override
  int get hashCode => token.hashCode;
}
