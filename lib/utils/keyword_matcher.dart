class KeywordMatcher {

  static bool containsKeyword(String text, String keyword) {
    final pattern = RegExp(
      r'\b' + RegExp.escape(keyword) + r'\b',
      caseSensitive: false
    );

    return pattern.hasMatch(text);
  }
}