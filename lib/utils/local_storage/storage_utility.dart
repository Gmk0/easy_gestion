import 'dart:convert';

import 'package:easy_gestion/model/user_model.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/constant_value.dart';

class CustomLocalStorage {
  static final CustomLocalStorage _instance = CustomLocalStorage._internal();

  factory CustomLocalStorage() {
    return _instance;
  }

  CustomLocalStorage._internal();

  final _storage = GetStorage();

  // Méthode générique pour sauvegarder des données
  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  // Méthode générique pour lire des données
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  // Méthode générique pour supprimer des données
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  // Effacer toutes les données du stockage
  Future<void> clearAll() async {
    await _storage.erase();
  }

  bool getDeviceFirstOpen() {
    return readData(STORAGE_USER_TOKEN_KEY) == null ? false : true;
  }

  bool getIsLogin() {
    return readData(STORAGE_USER_TOKEN_KEY) == null ? false : true;
  }

  UserModel getUserProfile() {
    var profileOffline = readData(STORAGE_USER_PROFILE_KEY) ?? "";

    if (profileOffline.isNotEmpty) {
      return UserModel.fromJson(jsonDecode(profileOffline));
    }
    return UserModel.empty();
  }
}
