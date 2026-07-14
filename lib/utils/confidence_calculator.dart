import 'package:menu_assistant/model/allergen_match.dart';

class ConfidenceCalculator {

  static double calculate(RiskSeverity severity) {
    switch(severity) {
      case RiskSeverity.high:
        return 0.95;

      case RiskSeverity.medium:
        return 0.75;

      case RiskSeverity.low:
        return 0.50;
    }
  }
}