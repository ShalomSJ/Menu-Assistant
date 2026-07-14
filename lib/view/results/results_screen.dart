import 'package:flutter/material.dart';
import 'package:menu_assistant/model/allergen_match.dart';

class ResultsScreen extends StatelessWidget {
  final List<AllergenMatch> risks;

  const ResultsScreen({super.key, required this.risks});

  Color _getSeverityColor(RiskSeverity severity) {
    switch (severity) {
      case RiskSeverity.high:
        return Colors.red.shade700;
      case RiskSeverity.medium:
        return Colors.orange.shade700;
      case RiskSeverity.low:
        return Colors.amber.shade400;
    }
  }

  Color _getSeverityBackground(RiskSeverity severity) {
    switch (severity) {
      case RiskSeverity.high:
        return Colors.red.shade50;
      case RiskSeverity.medium:
        return Colors.orange.shade50;
      case RiskSeverity.low:
        return Colors.amber.shade50;
    }
  }

  void _showMLThinkingPopup(BuildContext context, AllergenMatch match) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.psychology_rounded,
              color: colorScheme.primary.withOpacity(0.9),
            ),
            const SizedBox(width: 10),
            Text(
              'Assessment',
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Menu Item:',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            Text(
              '"${match.detectedText}"',
              style: textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Neural Network Confidence:',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            Text(
              '${(match.confidence * 100).toStringAsFixed(1)}% match certainty',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Reasoning Log:',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            Text(
              match.explanation,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.9),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Understood',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menu Analysis',
          style: textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onSurface,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: colorScheme.surface,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: colorScheme.onSurface.withOpacity(0.12),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Crucial Notice: Even if items check out as safe, cross-contamination risks exist. Always verify your allergen filters directly with your server before ordering.',
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: risks.isEmpty
                  ? Center(
                      child: Text(
                        'No immediate allergen group triggers identified.',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: risks.length,
                      itemBuilder: (context, index) {
                        final match = risks[index];
                        final badgeColor = _getSeverityColor(match.severity);

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          color: _getSeverityBackground(match.severity),
                          child: InkWell(
                            onTap: () => _showMLThinkingPopup(context, match),
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    match.detectedText,
                                    style: textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: badgeColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      match.severity.name.toUpperCase(),
                                      style: textTheme.bodyMedium?.copyWith(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Detected Category: ${match.triggeredByAllergen.toUpperCase()}',
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                  const Divider(),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.chat_bubble_outline,
                                        size: 16,
                                        color: badgeColor,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Recommendation:',
                                        style: textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: colorScheme.onSurface,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 22,
                                      top: 4,
                                    ),
                                    child: Text(
                                      '"${match.serverRecommendation}"',
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: colorScheme.onSurface.withOpacity(0.7),
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

