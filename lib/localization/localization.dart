import 'package:bluestack_test_app/index.dart';

class AppLocalization {
  final Locale _locale;

  AppLocalization(this._locale);

  static AppLocalization of(BuildContext context) =>
      Localizations.of<AppLocalization>(context, AppLocalization);

  Map<String, String> _localizationValues;

  //loading languages
  Future load() async {
    //loading languages from json files
    String jsonStrings =
        await rootBundle.loadString('lang/${_locale.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStrings);

    //mapping language map from json files
    _localizationValues = mappedJson
        .map((langKey, languageVal) => MapEntry(langKey, languageVal));
  }

  //get transalated String
  String getTransaledValue(String key) => _localizationValues[key];

  static const LocalizationsDelegate<AppLocalization> delegate =
      _LocalizationDelegate();
}

class _LocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const _LocalizationDelegate();
  @override
  bool isSupported(Locale locale) =>
      Strings.supportedLocaleList.contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization _localization = AppLocalization(locale);
    await _localization.load();
    return _localization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) =>
      false;
}
