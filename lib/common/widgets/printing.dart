import 'package:easy_gestion/data/repositories/user_repository.dart';
import 'package:easy_gestion/model/depense_model.dart';
import 'package:easy_gestion/model/reaprovisionement_model.dart';
import 'package:easy_gestion/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

Future<Uint8List> generatePdf(List<ProductTransactionModel> ventes) async {
  final pdf = pw.Document();

  final totalGeneral = ventes.fold<double>(
    0,
    (sum, vente) => sum + vente.totalAmount,
  );

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Center(
              child: pw.Text(
                'Liste des Ventes',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Text(
              'Client ${UserRepository.Instance.user.value.username}',
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(
              height: 20,
            ),
            pw.Text(
              'Date ${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 20),
            pw.TableHelper.fromTextArray(
              headers: ['Produit', 'Date', 'Montant Total'],
              data: ventes.map((vente) {
                return [
                  vente.product!.label,
                  DateFormat('dd-MM-yyyy').format(vente.date),
                  '\ CDF ${vente.totalAmount.toStringAsFixed(2)}',
                ];
              }).toList(),
            ),
            pw.SizedBox(height: 20),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Text(
                  'Total Général : \ CDF ${totalGeneral.toStringAsFixed(2)}',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ),
  );

  return pdf.save();
}

Future<Uint8List> generatePdfCommandes(
    List<CommanndeTransactionModel> commandes) async {
  final pdf = pw.Document();

  final totalGeneral = commandes.fold<double>(
    0,
    (sum, commande) => sum + commande.totalAmount,
  );

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Center(
              child: pw.Text(
                'Liste des commandes',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Text(
              'Client ${UserRepository.Instance.user.value.username}',
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(
              height: 20,
            ),
            pw.Text(
              'Date ${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 20),
            pw.TableHelper.fromTextArray(
              headers: ['Produit', 'Quantite', 'Date' 'Montant Total'],
              data: commandes.map((commande) {
                return [
                  commande.product!.label,
                  commande.quantity,
                  DateFormat('dd-MM-yyyy').format(commande.date),
                  '\ CDF ${commande.totalAmount.toStringAsFixed(2)}',
                ];
              }).toList(),
            ),
            pw.SizedBox(height: 20),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Text(
                  'Total Général : \ CDF ${totalGeneral.toStringAsFixed(2)}',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ),
  );

  return pdf.save();
}

Future<Uint8List> generateDepensePdf(List<DepenseModel> depenses) async {
  final pdf = pw.Document();

  final totalGeneral = depenses.fold<double>(
    0,
    (sum, commande) => sum + commande.totalAmount,
  );

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Center(
              child: pw.Text(
                'Liste des commandes',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Text(
              'Client ${UserRepository.Instance.user.value.username}',
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(
              height: 20,
            ),
            pw.Text(
              'Date ${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 20),
            pw.TableHelper.fromTextArray(
              headers: ['Produit', 'Description', 'Date' 'Montant Total'],
              data: depenses.map((depense) {
                return [
                  depense.title,
                  depense.description,
                  DateFormat('dd-MM-yyyy').format(depense.date),
                  '\ CDF ${depense.totalAmount.toStringAsFixed(2)}',
                ];
              }).toList(),
            ),
            pw.SizedBox(height: 20),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Text(
                  'Total Général : \ CDF ${totalGeneral.toStringAsFixed(2)}',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ),
  );

  return pdf.save();
}
