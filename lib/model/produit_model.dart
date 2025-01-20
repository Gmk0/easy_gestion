import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProduitModel {
  final String id;
  final String label;
  String category;
  double quantity;
  String background;

  ProduitModel({
    required this.id,
    required this.label,
    required this.category,
    required this.quantity,
    required this.background,
  });

  // Méthode pour convertir un ProduitModel en map (par exemple, pour Firestore)
  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'category': category,
      'background': background,
      'quantity': quantity,
    };
  }

  // Méthode pour créer un ProduitModel à partir d'un map (par exemple, pour Firestore)
  factory ProduitModel.fromMap(Map<String, dynamic> map) {
    return ProduitModel(
      id: map['id'],
      label: map['label'],
      quantity: map['quantity'],
      category: map['category'],
      background: map['background'],
    );
  }

  // Méthode pour créer un ProduitModel à partir d'un JSON
  factory ProduitModel.fromJson(Map<String, dynamic> json) {
    return ProduitModel(
      id: json['id'],
      label: json['label'],
      quantity: json['quantity'],
      category: json['category'],
      background: json['background'],
    );
  }

// static function pour creer un model vide
  static ProduitModel empty() => ProduitModel(
        id: '',
        label: '',
        quantity: 0,
        category: '',
        background: '',
      );

  ///factort methode to create a ProduitModel from a Firebase document snapshot
  ///

  factory ProduitModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ProduitModel(
        id: document.id,
        label: data['label'] ?? '',
        quantity: data['quantity'] ?? 0,
        background: data['background'] ?? "",
        category: data['category'] ?? '',
      );
    }
    return empty();
  }
}
