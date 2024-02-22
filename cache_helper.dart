import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

CacheHelper cacheHelper = CacheHelper();

class CacheHelper {
  late SharedPreferences _instance;
  Future initInstance() async {
    _instance = await SharedPreferences.getInstance();
  }

  Future<bool> setUser(User user) async {
    //user => map => string
    return await _instance.setString("user", jsonEncode(user.toMap()));
  }

  User? getUser() {
    // string => map => user
    if (_instance.getString("user") == null) return null;
    Map<String, dynamic> decoded = jsonDecode(_instance.getString("user")!);
    return User.fromMap(decoded);
  }

  Future<bool> clearUser() async {
    return await _instance.remove("user");
  }
}

class User {
  final String name;
  final String email;

//<editor-fold desc="Data Methods">
  const User({
    required this.name,
    required this.email,
  });

  User copyWith({
    String? name,
    String? email,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }
}
