import 'replacements.dart';

final _whitespaceRegExp = RegExp(r'\s+');
final _punctuationRegExp = RegExp(r'[^\w\s-]');

/// Converts [text] to a slugified [String] separated by the [delimiter].
String slugify(String text, {String delimiter = '-', bool lowercase = true}) =>
    text.slugify(
      delimiter: delimiter,
      lowercase: lowercase,
    );

/// Provides slugify as an extension method for strings.
extension SlugX on String {
  /// Converts [text] to a slugified [String] separated by the [delimiter].
  String slugify({String delimiter = '-', bool lowercase = true}) {
    // Trim leading and trailing whitespace.
    var slug = trim();

    // Make the text lowercase (optional).
    if (lowercase) {
      slug = slug.toLowerCase();
    }

    // Substitute characters for their latin equivalent.
    replacements.forEach((k, v) => slug = slug.replaceAll(k, v));

    slug = slug
        // Remove punctuation.
        .replaceAll(_punctuationRegExp, '')
        // Replace contiguous whitespace with a single delimiter.
        .replaceAll(_whitespaceRegExp, delimiter);

    return slug;
  }
}
