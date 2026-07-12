import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerOverlay extends StatelessWidget  {
  const QrScannerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan Table QR Code"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: MobileScanner(
        fit: BoxFit.cover,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
            final String rawValue = barcodes.first.rawValue!;

            Navigator.pop(context, rawValue);
          }
        },
      ),
    );
  }
}