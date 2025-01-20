import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_gestion/model/produit_model.dart';

class ProductTransactionModel {
  final String id;
  final String productId;
  final DateTime date;
  final double quantity;
  final double totalAmount;
  ProduitModel? product; // Association du produit à la transaction

  ProductTransactionModel({
    required this.id,
    required this.date,
    required this.totalAmount,
    required this.productId,
    required this.quantity,
    this.product,
  });

  // Méthode pour convertir un ProductTransactionModel en map (par exemple, pour Firestore)
  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'quantity': quantity,
      'totalAmount': totalAmount,
      'productId': productId,
    };
  }

  // Méthode pour créer un ProductTransactionModel à partir d'un map (par exemple, pour Firestore)
  factory ProductTransactionModel.fromMap(Map<String, dynamic> map) {
    return ProductTransactionModel(
      id: map['id'] ?? '',
      date: DateTime.parse(map['date']),
      totalAmount: map['totalAmount'] ?? 0.0,
      productId: map['productId'] ?? '',
      quantity: map['quantity'] ?? 0.0,
    );
  }

  // Méthode pour créer un ProductTransactionModel à partir d'un JSON
  factory ProductTransactionModel.fromJson(Map<String, dynamic> json) {
    return ProductTransactionModel(
      id: json['id'] ?? '',
      date: DateTime.parse(json['date']),
      totalAmount: json['totalAmount'] ?? 0.0,
      productId: json['productId'] ?? '',
      quantity: json['quantity'] ?? 0.0,
    );
  }

  // Méthode statique pour créer un modèle vide
  static ProductTransactionModel empty() => ProductTransactionModel(
        id: '',
        date: DateTime.now(),
        totalAmount: 0.0,
        productId: '',
        quantity: 0.0,
      );

  // Méthode pour créer un ProductTransactionModel à partir d'un snapshot Firebase
  factory ProductTransactionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ProductTransactionModel(
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
