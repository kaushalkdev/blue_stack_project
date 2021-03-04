import 'package:bluestack_test_app/app/src/blocs/main_app_bloc.dart';
import 'package:bluestack_test_app/index.dart';

class BlueStackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Locale>(
      stream: mainAppBloc.getLocale,
      builder: (context, snapshot) => MaterialApp(
        //fetch locale from preferences
        locale: snapshot.data,
        // add localization deligate to supported different lanugage
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocalization.delegate
        ],

        //added supported locale
        supportedLocales: [
          Locale(Strings.en),
          Locale(Strings.ja),
        ],

        localeResolutionCallback: (deviceLocale, supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale.languageCode) {
              return deviceLocale;
            }
          }
          return supportedLocales.first;
        },

        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: loadScreen(),
      ),
    );
  }

  Widget loadScreen() {
    return (loginBloc.getLoginFlag() ?? false) ? HomeScreen() : LoginScreen();
  }
}
