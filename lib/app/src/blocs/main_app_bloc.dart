import 'package:bluestack_test_app/index.dart';

class MainAppBloc {
  var _locale = BehaviorSubject<Locale>();

  Locale get getLocaleVal => _locale.value;
  Stream<Locale> get getLocale => _locale.stream;
  Function(Locale) get setLocale => _locale.sink.add;

  void init() {
    var locale = preferenceUtils.getString(PreferenceKeys.locale) ?? Strings.en;
    setLocale(Locale(locale));
  }

  Future<void> dispose() async {
    await _locale.close();
  }
}

var mainAppBloc = MainAppBloc();
