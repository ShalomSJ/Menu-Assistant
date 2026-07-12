import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart' as file_picker;
import '../../model/profile.dart';

class ScannerController extends ChangeNotifier {
  final Profile activeProfile;
  bool _isProcessing = false;

  final ImagePicker _picker = ImagePicker();

  ScannerController({required this.activeProfile});

  bool get isProcessing => _isProcessing;

  /// Sets loading state and notifies the UI view boundary
  void _setProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  /// Opens the device camera to snap a picture of a physical menu
  Future<File?> takePhoto() async {
    _setProcessing(true);

    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 90,
      );

      if (photo != null) {
        return File(photo.path);
      }
    } catch (e) {
      debugPrint("Camera Exception: $e");
    } finally {
      _setProcessing(false);
    }
    return null;
  }

  /// Opens the local photo gallery to select a pre-saved menu screenshot
  Future<File?> uploadImage() async {
    _setProcessing(true);

    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        return File(image.path);
      }
    } catch (e) {
      debugPrint("Gallery Exception: $e");
    } finally {
      _setProcessing(false);
    }
    return null;
  }

  /// Opens the device storage explorer to select a downloaded digital menu PDF
  Future<File?> uploadPDF() async {
    _setProcessing(true);

    try {
      file_picker.FilePickerResult? result = await file_picker.FilePicker.pickFiles(
        type: file_picker.FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        // TO EXTRACT TO A LOCAL VARIABLE SO DART CAN GUARNATEE IT WON'T CHANGE TO NULL
        final String? filePath = result.files.single.path;

        if (filePath != null) {
          return File(filePath);
        }
      }
    } catch (e) {
      debugPrint("PDF FilePicker Exception: $e");
    } finally {
      _setProcessing(false);
    }
    return null;
  }

  /// Processing QR Scanner data strings
  Future<String?> handleQrResult(String code) async {
    if (code.isNotEmpty) {
      debugPrint("QR Code Found: $code");
      return code;
    }
    return null;
  }

}

