import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_gestion/model/produit_model.dart';

class DepenseModel {
  final String id;

  DateTime date;
  String title;
  String? description;

  double totalAmount;
  // Association du produit à la transaction

  DepenseModel({
    required this.id,
    required this.date,
    required this.title,
    this.description,
    required this.totalAmount,
  });

  // Méthode pour convertir un DepenseModel  en map (par exemple, pour Firestore)
  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'totalAmount': totalAmount,
      'title': title,
      'description': description,
    };
  }

  // Méthode pour créer un DepenseModel  à partir d'un map (par exemple, pour Firestore)
  factory DepenseModel.fromMap(Map<String, dynamic> map) {
    return DepenseModel(
        id: map['id'] ?? '',
        date: DateTime.parse(map['date']),
        totalAmount: map['totalAmount'] ?? 0.0,
        title: map['title'] ?? '',
        description: map['description'] ?? "");
  }

  // Méthode pour créer un DepenseModel  à partir d'un JSON
  factory DepenseModel.fromJson(Map<String, dynamic> json) {
    return DepenseModel(
      id: json['id'] ?? '',
      date: DateTime.parse(json['date']),
      totalAmount: json['totalAmount'] ?? 0.0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }

  // Méthode statique pour créer un modèle vide
  static DepenseModel empty() => DepenseModel(
        id: '',
        date: DateTime.now(),
        totalAmount: 0.0,
        title: '',
        description: '',
      );

  // Méthode pour créer un DepenseModel  à partir d'un snapshot Firebase
  factory DepenseModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return DepenseModel(
        id: document.id,
        date: DateTime.parse(data['date']),
        totalAmount: data['totalAmount'] ?? 0.0,
        title: data['title'] ?? "",
        description: data['description'] ?? "",
      );
    }
    return empty();
  }
}
