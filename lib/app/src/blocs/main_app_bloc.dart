import 'package:bluestack_test_app/index.dart';

class MainAppBloc {
  var _locale = BehaviorSubject<Locale>();
  var _localizationValues = BehaviorSubject<Map<String, String>>();

  //locale
  Locale get getLocaleVal => _locale.value;
  Stream<Locale> get getLocale => _locale.stream;
  Function(Locale) get setLocale => _locale.sink.add;

  //language map
  Map<String, String> get getLanguageMap => _localizationValues.value;
  Stream<Map<String, String>> get getLanguageMapStream =>
      _localizationValues.stream;
  Function(Map<String, String>) get setLanguageMap =>
      _localizationValues.sink.add;

  Future<void> init() async {
    var locale = preferenceUtils.getString(PreferenceKeys.locale) ?? Strings.en;
    setLocale(Locale(locale));
    await load();
  }

  Future<void> load() async {
    //loading languages from json files
    String jsonStrings =
        await rootBundle.loadString('lang/${_locale.value.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStrings);

    //mapping language map from json files
    _localizationValues.sink.add(mappedJson
        .map((langKey, languageVal) => MapEntry(langKey, languageVal)));
  }

  Future<void> dispose() async {
    await _locale.close();
    await _localizationValues.close();
  }
}

var mainAppBloc = MainAppBloc();
