library gtext;

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

class GText extends StatefulWidget {
  static bool _enabled = true;
  static String? _from;
  static String _to = 'en';
  static bool _enableCaching = true;

  static void init(
      {String? from, required String to, required bool enableCaching}) {
    _from = from;
    _to = to;
    _enableCaching = enableCaching;
  }

  static void setEnabled(bool isEnabled) {
    _enabled = isEnabled;
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

  @override
  State<GText> createState() => _GTextState();
}

class _GTextState extends State<GText> {
  Future<String> translate() async {
    if (!GText._enabled) {
      return widget.data;
    }

    if (GText._enableCaching) {
      final cachedTranslation = await loadTranslation(widget.data, GText._to);
      if (cachedTranslation != null) {
        return cachedTranslation;
      }
    }

    final translator = GoogleTranslator();
    try {
      final translation = await translator.translate(widget.data,
          to: widget.toLang ?? GText._to, from: GText._from ?? 'auto');
      if (GText._enableCaching && translation.text != translation.source) {
        await saveTranslation(widget.data, GText._to, translation.text);
      }
      return translation.text;
    } catch (ex) {
      return widget.data;
    }
  }

  Future<void> saveTranslation(
      String key, String to, String translation) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("translations/$to/$key", translation);
  }

  Future<String?> loadTranslation(String key, String to) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("translations/$to/$key");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: translate(),
        builder: ((context, snapshot) {
          return Text(snapshot.hasData ? snapshot.data as String : "",
              style: widget.style,
              strutStyle: widget.strutStyle,
              textAlign: widget.textAlign,
              textDirection: widget.textDirection,
              locale: widget.locale,
              softWrap: widget.softWrap,
              overflow: widget.overflow,
              textScaleFactor: widget.textScaleFactor,
              maxLines: widget.maxLines,
              semanticsLabel: widget.semanticsLabel,
              textWidthBasis: widget.textWidthBasis,
              textHeightBehavior: widget.textHeightBehavior);
        }));
  }
}
