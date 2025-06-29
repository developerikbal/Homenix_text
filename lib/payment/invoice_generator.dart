// lib/payment/invoice_generator.dart

import 'dart:io';
import 'dart:typed_data'; // Required for Uint8List
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart'; // For platform-safe file saving

/// InvoiceGenerator class - responsible for creating invoice PDFs
class InvoiceGenerator {
  /// Generates the invoice and returns the PDF file as bytes
  static Future<Uint8List> generateInvoice({
    required String customerName,
    required String email,
    required String planType, // monthly / yearly / lifetime
    required double amount,
    required String transactionId,
  }) async {
    final pdf = pw.Document();
    final date = DateFormat('yyyy-MM-dd').format(DateTime.now());

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(32),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Homeonix', style: pw.TextStyle(fontSize: 32, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 8),
                pw.Text('Official Invoice', style: pw.TextStyle(fontSize: 18)),
                pw.Divider(),
                pw.SizedBox(height: 8),

                pw.Text('Invoice Date: $date'),
                pw.Text('Transaction ID: $transactionId'),
                pw.SizedBox(height: 16),

                pw.Text('Billed To:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text(customerName),
                pw.Text(email),
                pw.SizedBox(height: 16),

                pw.Text('Subscription Plan:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text(planType.toUpperCase()),
                pw.SizedBox(height: 8),

                pw.Text('Amount Paid:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text('৳ ${amount.toStringAsFixed(2)}'),
                pw.SizedBox(height: 32),

                pw.Text('Thank you for choosing Homeonix!', style: pw.TextStyle(fontSize: 14)),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save(); // returns the PDF in memory (bytes)
  }

  /// Saves the PDF to a local file - Compatible with Android/iOS/Desktop
  static Future<void> savePdfFile(Uint8List pdfData, String filename) async {
    try {
      final directory = await getExternalStorageDirectory(); // For Android
      final path = directory!.path;
      final file = File('$path/$filename');
      await file.writeAsBytes(pdfData);
      print('Invoice saved at: $path/$filename');
    } catch (e) {
      print('Error saving PDF: $e');
    }
  }

  /// Print or share the invoice PDF
  static Future<void> printInvoice({
    required String customerName,
    required String email,
    required String planType,
    required double amount,
    required String transactionId,
  }) async {
    final pdfData = await generateInvoice(
      customerName: customerName,
      email: email,
      planType: planType,
      amount: amount,
      transactionId: transactionId,
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfData,
    );
  }
}