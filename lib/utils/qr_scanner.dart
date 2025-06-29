// File: lib/utils/qr_scanner.dart
// Description: QR scanner widget for scanning disease/remedy codes

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class QRScannerWidget extends StatefulWidget {
  final Function(String data) onScanned;

  const QRScannerWidget({Key? key, required this.onScanned}) : super(key: key);

  @override
  State<QRScannerWidget> createState() => _QRScannerWidgetState();
}

class _QRScannerWidgetState extends State<QRScannerWidget> {
  bool _hasScanned = false;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  /// Request camera permission before scanning
  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }

  /// Process the QR code once
  void _processQRCode(String code) {
    if (!_hasScanned) {
      _hasScanned = true;
      widget.onScanned(code);
      _saveQRDataLocally(code);
    }
  }

  /// Save scanned data into device's internal file (for debug only)
  Future<void> _saveQRDataLocally(String data) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/scanned_qr_logs.txt';
      final file = File(filePath);
      await file.writeAsString('$data\n', mode: FileMode.append);
    } catch (e) {
      // Optional: log error or ignore
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan QR Code")),
      body: MobileScanner(
        allowDuplicates: false,
        onDetect: (capture) {
          for (final barcode in capture.barcodes) {
            final String? code = barcode.rawValue;
            if (code != null) {
              _processQRCode(code);
              break;
            }
          }
        },
      ),
    );
  }
}