import 'package:flutter/material.dart';
import 'package:menu_assistant/view/scanner/qr_scanner_overlay.dart';
import '../../controller/scanner_controller.dart';
import '../../model/profile.dart';

class ScannerScreen extends StatefulWidget {
  final Profile selectedProfile;

  const ScannerScreen({super.key, required this.selectedProfile});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen>{
  late ScannerController _controller;

  @override
  void initState(){
    super.initState();

    _controller = ScannerController(activeProfile: widget.selectedProfile);
  }

  void _handleFileResult(dynamic result, String inputType) {
    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Successfully captured $inputType context data. Ready for OCR."),
          backgroundColor: Colors.green[700],
        ),
      );

      // NEXT MILESTONE ROADMAP TARGET: Pass this file/URL directly to our ML Kit processing screen!

    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan Menu"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListenableBuilder(
        listenable: _controller, 
        builder: (context, _) {
          if (_controller.isProcessing) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Preparing viewport file..."),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // AN ACTIVE PROFILE INDICATOR PANEL
                Card(
                  color: Colors.blueGrey.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blueGrey.shade700,
                          foregroundColor: Colors.white,
                          child: Text(widget.selectedProfile.name.isNotEmpty 
                              ? widget.selectedProfile.name[0].toUpperCase() 
                              : '?'),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Scanning for ${widget.selectedProfile.name}",
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Active Filters: ${widget.selectedProfile.allergyCategory.length} categories",
                                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                // THE MAIN CORE VISUAL ICON
                const Icon(
                  Icons.document_scanner_outlined,
                  size: 100,
                  color: Colors.blueGrey,
                ),

                const SizedBox(height: 24),

                const Text(
                  "Upload the Restaurant's Menu",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                Text(
                  "Take a photo or import a digital document",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade600, height: 1.4),
                ),

                const Spacer(),

                // THE ACTION OPERATIONS LAYER
                ElevatedButton.icon(
                  onPressed: () async {
                    final file = await _controller.takePhoto();
                    _handleFileResult(file, "Camera Photo");
                  },
                  icon: const Icon(Icons.camera_alt_rounded),
                  label: const Text("Take Photo"),
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                ),

                const SizedBox(height: 12),

                ElevatedButton.icon(
                  onPressed: () async {
                    final file = await _controller.uploadImage();
                    _handleFileResult(file, "Upload Image");
                  },
                  icon: const Icon(Icons.image_rounded),
                  label: const Text("Upload Image"),
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                ),

                const SizedBox(height: 12),

                ElevatedButton.icon(
                  onPressed: () async {
                    final file = await _controller.uploadPDF();
                    _handleFileResult(file, "Upload PDF");
                  },
                  icon: const Icon(Icons.picture_as_pdf_rounded),
                  label: const Text("Upload PDF Document"),
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                ),

                const SizedBox(height: 12),

                ElevatedButton.icon(
                  onPressed: () async {
                    final String? scannedLink = await Navigator.push<String>(
                      context,
                      MaterialPageRoute(builder: (context) => const QrScannerOverlay()),
                    );

                    if (scannedLink != null) {
                      final confirmedCode = await _controller.handleQrResult(scannedLink);
                      _handleFileResult(confirmedCode, "QR Menu URL");
                    }
                  },
                  icon: const Icon(Icons.qr_code_scanner_rounded),
                  label: const Text("Scan QR Code"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 16),  
              ],
            )
          );
        },
      ),
    );
  }
}