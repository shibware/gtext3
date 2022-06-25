library gtext;

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

/// `GText` is a stateless widget that displays translated text
class GText extends StatelessWidget {
  static bool _enabled = true;
  static String? _from;
  static String _to = 'en';
  static bool _enableCaching = true;

  /// `init` is a function that takes an optional `from` parameter, a required `to` parameter, and a
  /// required `enableCaching` parameter
  ///
  /// Args:
  ///
  ///   from (String): The language code of the text to be translated. If not specified, the language is
  /// auto-detected.
  ///
  ///   to (String): The language to translate to.
  ///
  ///   enableCaching (bool): If true, the translation will be cached.
  static void init(
      {String? from, required String to, required bool enableCaching}) {
    _from = from;
    _to = to;
    _enableCaching = enableCaching;
  }

  /// Enable / disable translate functions. In case it's disabled, GText will render non-translated text.
  /// Default state is enabled.
  static void setEnabled(bool isEnabled) {
    _enabled = isEnabled;
  }

  /// `translate` is a function that takes a string and a language code as parameters and returns a translated
  /// string
  ///
  /// If `toLang` is not set, it will translate to global language (default: 'en')
  ///
  /// Args:
  ///
  ///   text (String): The text to be translated.
  ///
  ///   toLang (String?): The language you want to translate to.
  ///
  /// Returns:
  ///   The translated text.
  static Future<String> translate(String text, String? toLang) async {
    if (!GText._enabled) {
      return text;
    }

    if (GText._enableCaching) {
      final cachedTranslation = await _loadTranslation(text, GText._to);
      if (cachedTranslation != null) {
        return cachedTranslation;
      }
    }

    final translator = GoogleTranslator();
    try {
      final translation = await translator.translate(text,
          to: toLang ?? GText._to, from: GText._from ?? 'auto');
      if (GText._enableCaching && translation.text != translation.source) {
        await _saveTranslation(text, GText._to, translation.text);
      }
      return translation.text;
    } catch (ex) {
      return text;
    }
  }

  final String data;
  final String? toLang;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  /// It's a constructor.
  const GText(this.data,
      {Key? key,
      this.toLang,
      this.style,
      this.strutStyle,
      this.textAlign,
      this.textDirection,
      this.locale,
      this.softWrap,
      this.overflow,
      this.textScaleFactor,
      this.maxLines,
      this.semanticsLabel,
      this.textWidthBasis,
      this.textHeightBehavior})
      : super(key: key);

  /// It returns a FutureBuilder widget that will return a Text widget when the future is complete.
  ///
  /// Args:
  ///   context (BuildContext): BuildContext
  ///
  /// Returns:
  ///   A FutureBuilder widget.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: GText.translate(data, toLang),
        builder: ((context, snapshot) {
          return Text(snapshot.data ?? "",
              style: style,
              strutStyle: strutStyle,
              textAlign: textAlign,
              textDirection: textDirection,
              locale: locale,
              softWrap: softWrap,
              overflow: overflow,
              textScaleFactor: textScaleFactor,
              maxLines: maxLines,
              semanticsLabel: semanticsLabel,
              textWidthBasis: textWidthBasis,
              textHeightBehavior: textHeightBehavior);
        }));
  }

  /// _saveTranslation() is an asynchronous function that takes three parameters: key, to, and
  /// translation. It returns a Future that resolves to void
  ///
  /// Args:
  ///   key (String): The key of the translation.
  ///   to (String): The language to translate to.
  ///   translation (String): The translation to save.
  static Future<void> _saveTranslation(
      String key, String to, String translation) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("translations/$to/$key", translation);
  }

  /// It loads a translation from the device's storage
  ///
  /// Args:
  ///   key (String): The key of the translation you want to load.
  ///   to (String): The language you want to translate to.
  ///
  /// Returns:
  ///   A Future<String?>
  static Future<String?> _loadTranslation(String key, String to) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("translations/$to/$key");
  }
}
