import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_gestion/model/produit_model.dart';

class CommanndeTransactionModel {
  final String id;
  final String productId;
  final DateTime date;
  final double quantity;
  final double totalAmount;
  ProduitModel? product; // Association du produit à la transaction

  CommanndeTransactionModel({
    required this.id,
    required this.date,
    required this.totalAmount,
    required this.productId,
    required this.quantity,
    this.product,
  });

  // Méthode pour convertir un CommanndeTransactionModel en map (par exemple, pour Firestore)
  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'quantity': quantity,
      'totalAmount': totalAmount,
      'productId': productId,
    };
  }

  // Méthode pour créer un CommanndeTransactionModel à partir d'un map (par exemple, pour Firestore)
  factory CommanndeTransactionModel.fromMap(Map<String, dynamic> map) {
    return CommanndeTransactionModel(
      id: map['id'] ?? '',
      date: DateTime.parse(map['date']),
      totalAmount: map['totalAmount'] ?? 0.0,
      productId: map['productId'] ?? '',
      quantity: map['quantity'] ?? 0.0,
    );
  }

  // Méthode pour créer un CommanndeTransactionModel à partir d'un JSON
  factory CommanndeTransactionModel.fromJson(Map<String, dynamic> json) {
    return CommanndeTransactionModel(
      id: json['id'] ?? '',
      date: DateTime.parse(json['date']),
      totalAmount: json['totalAmount'] ?? 0.0,
      productId: json['productId'] ?? '',
      quantity: json['quantity'] ?? 0.0,
    );
  }

  // Méthode statique pour créer un modèle vide
  static CommanndeTransactionModel empty() => CommanndeTransactionModel(
        id: '',
        date: DateTime.now(),
        totalAmount: 0.0,
        productId: '',
        quantity: 0.0,
      );

  // Méthode pour créer un CommanndeTransactionModel à partir d'un snapshot Firebase
  factory CommanndeTransactionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return CommanndeTransactionModel(
        id: document.id,
        date: DateTime.parse(data['date']),
        totalAmount: data['totalAmount'] ?? 0.0,
        productId: data['productId'] ?? '',
        quantity: data['quantity'] ?? 0.0,
      );
    }
    return empty();
  }
}
