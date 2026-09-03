class FamilyCodeGenerator {
  FamilyCodeGenerator._();

  static String generate(String familyName) {
    final words = familyName
        .trim()
        .split(' ')
        .where((word) => word.isNotEmpty)
        .toList();

    if (words.isEmpty) return "--";

    if (words.length == 1) {
      final word = words.first;
      return word.length >= 2
          ? word.substring(0, 2).toUpperCase()
          : word.toUpperCase();
    }

    return (
        words[0][0] + words[1][0]
    ).toUpperCase();
  }
}