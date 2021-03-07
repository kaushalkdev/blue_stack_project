import 'package:bluestack_test_app/app/src/blocs/main_app_bloc.dart';
import 'package:bluestack_test_app/index.dart';

class BlueStackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Locale>(
      stream: mainAppBloc.getLocale,
      builder: (context, snapshot) => materialApp(snapshot),
    );
  }

  MaterialApp materialApp(AsyncSnapshot<Locale> snapshot) {
    return MaterialApp(
      //fetch locale from preferences
      locale: snapshot.data,
      // add localization deligate to supported different lanugage
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      //added supported locale
      supportedLocales: [
        Locale(Strings.en),
        Locale(Strings.ja),
      ],

      localeResolutionCallback: localeResoltionCallback,

      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: loadScreen(),
    );
  }

  ThemeData appTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  Widget loadScreen() {
    return (loginBloc.getLoginFlag() ?? false) ? HomeScreen() : LoginScreen();
  }

  Locale localeResoltionCallback(
    Locale deviceLocale,
    Iterable<Locale> supportedLocales,
  ) {
    for (var locale in supportedLocales) {
      if (locale.languageCode == deviceLocale.languageCode) {
        return deviceLocale;
      }
    }
    return supportedLocales.first;
  }
}
