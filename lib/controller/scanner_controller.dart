import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart' as file_picker;
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../model/profile.dart';
import '../utils/allergen_dictionary.dart';
import '../model/allergen_match.dart';
import '../utils/text_normalizer.dart';
import '../utils/keyword_matcher.dart';
import '../utils/confidence_calculator.dart';
class ScannerController extends ChangeNotifier {
  final Profile activeProfile;
  bool _isProcessing = false;

  final ImagePicker _picker = ImagePicker();

  // TO INITIALIZE THE LATIN SCRIPT TEXT ORGANIZER ENGINE FOR ENGLISH, SPANISH, FRENCH
  final TextRecognizer _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  // LIST TO HOLD ALL MATCHING RISK ITEMS DISCOVERED DURING A SCAN
  final List<AllergenMatch> _detectedRisks = [];

  ScannerController({required this.activeProfile});

  bool get isProcessing => _isProcessing;

  List<AllergenMatch> get detectedRisks => _detectedRisks;

  /// Sets loading state and notifies the UI view boundary
  void _setProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  /// Evaluates an allergy category and a specific matched method to determine severity 
  RiskSeverity _determineSeverity(String keyword, String allergyName) {

    final highRiskKeywords = [
      "milk","butter","cheese","peanut","wheat","egg",
    ];


    if(highRiskKeywords.contains(keyword)){
      return RiskSeverity.high;
    }

    return RiskSeverity.medium;

  }

  /// Generates human-friendly system dialogue scripts for talking to restaurant staff
  String _generateRecommendation(String detectedItem, String keyword, String allergyCategory) {
    final item = detectedItem.trim();

    switch (allergyCategory.toLowerCase()) {
      case 'cowmilk':
        return "Ask the server if the $item contains milk, butter, cheese, "
               "or any dairy ingredients. Also ask if a dairy-free option is available.";
      case 'eggs':
        return "Ask whether the $item contains eggs, mayonnaise, egg wash, "
               "or egg-based ingredients.";
      case 'peanuts':
      case 'treenuts':
        return "Confirm whether the $item contains nuts or was prepared "
               "using shared equipment or cooking oils.";
      case 'wheat':
        return "Ask whether the $item contains wheat ingredients, "
               "such as breading, flour, or shared fryer exposure.";
      case 'garlic':
      case 'onion':
        return "Confirm whether the $item contains garlic, onion, "
               "powders, sauces, or marinades.";
      default:
        return "Please confirm with the server whether the $item contains "
               "$keyword or may have come into contact with it during preparation.";
    }
  }

  /// Builds a detailed machine logic explanation step for the Thinking Pop-up UI
  String _generateExplanation(String lineText, String matchedWord, String allergyCategory) {
    return 
    "The menu description contains \"$matchedWord\". "
    "This ingredient may be associated with your $allergyCategory sensitivity. "
    "We recommend confirming the ingredients and preparation method with the restaurant.";
  }

  Future<void> processImageFile(File file) async {
    _setProcessing(true);
    _detectedRisks.clear();

    try {
      // TO CONVERT THE STANDARD DART FILE INTO AN InputImage THAT ML KIT UNDERSTANDS
      final inputImage = InputImage.fromFile(file);

      // TO PASS THE IMEGE TO THE PHONE'S LOCAL NPU/NEURAL ENGINE TO EXTRACT TEXT BLOCKS 
      final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);

      // MAP OF ALL LOWERCASE WORDS THAT NEED TO BE WATCHED OUT FOR
      final Map<String, List<String>> activeTriggers = {};

      for (var category in activeProfile.allergyCategory) {
        final keywords = AllergenDictionary.getKeywordsFor(category);
        for (var word in keywords) {
          activeTriggers.putIfAbsent(word.toLowerCase(), () => []).add(category.name);
        }
      }

      // THE CORE LOOP TO SEARCH THROUGH BLOCKS, LINES AND STRUCTURAL COORDINATES
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          final String normalizedLine = TextNormalizer.normalize(line.text);

          // TO CHECK IF ANY KEYWORD DICTIONARY ITEM IS PRESENT IN THE SCANNED TEXT LINE
          activeTriggers.forEach((keyword, allergyCategoryNames) {
            for (final allergyCategoryName in allergyCategoryNames) {
              if (KeywordMatcher.containsKeyword(normalizedLine, keyword)) {
                final severity = _determineSeverity(line.text, keyword);
                final confidence = ConfidenceCalculator.calculate(severity);
                final recommendation = _generateRecommendation(line.text, keyword, allergyCategoryName);
                final explanation = _generateExplanation(line.text, keyword, allergyCategoryName);

                final isAlreadyFlagged = _detectedRisks.any((risk) => risk.detectedText == line.text && risk.triggeredByAllergen == allergyCategoryName);

                if (!isAlreadyFlagged) {
                  _detectedRisks.add(
                    AllergenMatch(
                      detectedText: line.text,
                      boundingBox: line.boundingBox,
                      triggeredByAllergen: allergyCategoryName,
                      confidence: confidence,
                      severity: severity,
                      serverRecommendation: recommendation,
                      explanation: explanation,
                    ),
                  );
                }
              }
            }
          });
        }
      }
    } catch (e) {
      debugPrint("OCR Processing Exception: $e");
    } finally {
      _setProcessing(false);
      // TO TELL THE UI TO REBUILD AND DISPLAY THE MATCHED FLAGS
      notifyListeners(); 
    }
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

  /// Processes raw text or content fetched from a URL string
  Future<void> processTextOrUrl(String input) async {
    _setProcessing(true);
    _detectedRisks.clear();

    try {
      // IF QR CODE CONTAINS DIRECT TEXT MENUS INSTEAD OF LINKS
      final String normalizedInput = TextNormalizer.normalize(input);

      final Map<String, List<String>> activeTriggers = {};
      for (var category in activeProfile.allergyCategory) {
        final keywords = AllergenDictionary.getKeywordsFor(category);
        for (var word in keywords) {
          activeTriggers.putIfAbsent(word.toLowerCase(), () => []).add(category.name);
        }
      }

      activeTriggers.forEach((keyword, allergyCategoryNames) {
        for (final allergyCategoryName in allergyCategoryNames) {
          if (KeywordMatcher.containsKeyword(normalizedInput, keyword)) {
            final severity = _determineSeverity(input, keyword);
            final confidence = ConfidenceCalculator.calculate(severity);
            final recommendation = _generateRecommendation(input, keyword, allergyCategoryName);
            final explanation = _generateExplanation(input, keyword, allergyCategoryName);

            _detectedRisks.add(
              AllergenMatch(
                detectedText: input,
                boundingBox: Rect.zero, // NO BOUNDING BOX
                triggeredByAllergen: allergyCategoryName,
                confidence: confidence,
                severity: severity,
                serverRecommendation: recommendation,
                explanation: explanation,
              ),
            );
          }
        }
      });
    } catch (e) {
      debugPrint("Text Processing Exception: $e");
    } finally {
      _setProcessing(false);
      notifyListeners();
    }
  }

  @override
  void dispose(){

    _textRecognizer.close();

    super.dispose();

  }

}

