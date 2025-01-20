import 'package:get_storage/get_storage.dart';

class TLocalStorage {
  static final TLocalStorage _instance = TLocalStorage._internal();

  factory TLocalStorage() {
    return _instance;
  }

  TLocalStorage._internal();

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
}
