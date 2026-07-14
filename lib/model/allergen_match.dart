import 'package:flutter/material.dart';

enum RiskSeverity { low, medium, high }

class AllergenMatch {
  final String detectedText;
  final Rect boundingBox;
  final String triggeredByAllergen;
  final double confidence;
  final RiskSeverity severity;
  final String serverRecommendation;
  final String explanation;

  AllergenMatch({
    required this.detectedText,
    required this.boundingBox,
    required this.triggeredByAllergen,
    required this.confidence,
    required this.severity,
    required this.serverRecommendation,
    required this.explanation,
  });
}