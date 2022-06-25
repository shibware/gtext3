<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

GText is wrapper for Text widget that can translate its content to another language using Google Translator.
[![pub package](https://firebasestorage.googleapis.com/v0/b/strainer-bb96f.appspot.com/o/tOHz2p5IYEt-CgM8Fd1d2CGNvDMDFu7MW42QT_OzYpDuOJ8J.png?alt=media&token=6d35977e-d069-4d12-91dd-2fe2c6737814)](https://pub.dartlang.org/packages/gtext)

## Features

* Translate text to many languages
* Cache translated text to keep app fast
* Set global and local (for one widget) language for translating to 

## Getting started

In your pubspec.yaml file within your Flutter Project:

```yaml
dependencies:
  gtext: ^0.0.2
```

## Usage

Examples:

Local translation.
```dart
import 'package:gtext/gtext.dart';

GText("Hello, World!", toLang: 'de')
```


Initialize global language (no need to set ``toLang`` argument)
```dart
import 'package:gtext/gtext.dart';

void main() {
    GText.init(to: 'en', enableCaching: false);
    runApp(App());
    // You can write GText("Привет, мир!")  
}
```

Demo app can be found in the [`example/`](https://github.com/senpaiburado/gtext/tree/main/example) folder.

## Additional information

List of available languages:

'af': 'Afrikaans',
'sq': 'Albanian',
'am': 'Amharic',
'ar': 'Arabic',
'hy': 'Armenian',
'az': 'Azerbaijani',
'eu': 'Basque',
'be': 'Belarusian',
'bn': 'Bengali',
'bs': 'Bosnian',
'bg': 'Bulgarian',
'ca': 'Catalan',
'ceb': 'Cebuano',
'ny': 'Chichewa',
'zh-cn': 'Chinese Simplified',
'zh-tw': 'Chinese Traditional',
'co': 'Corsican',
'hr': 'Croatian',
'cs': 'Czech',
'da': 'Danish',
'nl': 'Dutch',
'en': 'English',
'eo': 'Esperanto',
'et': 'Estonian',
'tl': 'Filipino',
'fi': 'Finnish',
'fr': 'French',
'fy': 'Frisian',
'gl': 'Galician',
'ka': 'Georgian',
'de': 'German',
'el': 'Greek',
'gu': 'Gujarati',
'ht': 'Haitian Creole',
'ha': 'Hausa',
'haw': 'Hawaiian',
'iw': 'Hebrew',
'hi': 'Hindi',
'hmn': 'Hmong',
'hu': 'Hungarian',
'is': 'Icelandic',
'ig': 'Igbo',
'id': 'Indonesian',
'ga': 'Irish',
'it': 'Italian',
'ja': 'Japanese',
'jw': 'Javanese',
'kn': 'Kannada',
'kk': 'Kazakh',
'km': 'Khmer',
'ko': 'Korean',
'ku': 'Kurdish (Kurmanji)',
'ky': 'Kyrgyz',
'lo': 'Lao',
'la': 'Latin',
'lv': 'Latvian',
'lt': 'Lithuanian',
'lb': 'Luxembourgish',
'mk': 'Macedonian',
'mg': 'Malagasy',
'ms': 'Malay',
'ml': 'Malayalam',
'mt': 'Maltese',
'mi': 'Maori',
'mr': 'Marathi',
'mn': 'Mongolian',
'my': 'Myanmar (Burmese)',
'ne': 'Nepali',
'no': 'Norwegian',
'ps': 'Pashto',
'fa': 'Persian',
'pl': 'Polish',
'pt': 'Portuguese',
'pa': 'Punjabi',
'ro': 'Romanian',
'ru': 'Russian',
'sm': 'Samoan',
'gd': 'Scots Gaelic',
'sr': 'Serbian',
'st': 'Sesotho',
'sn': 'Shona',
'sd': 'Sindhi',
'si': 'Sinhala',
'sk': 'Slovak',
'sl': 'Slovenian',
'so': 'Somali',
'es': 'Spanish',
'su': 'Sundanese',
'sw': 'Swahili',
'sv': 'Swedish',
'tg': 'Tajik',
'ta': 'Tamil',
'te': 'Telugu',
'th': 'Thai',
'tr': 'Turkish',
'uk': 'Ukrainian',
'ur': 'Urdu',
'uz': 'Uzbek',
'ug': 'Uyghur',
'vi': 'Vietnamese',
'cy': 'Welsh',
'xh': 'Xhosa',
'yi': 'Yiddish',
'yo': 'Yoruba',
'zu': 'Zulu'
