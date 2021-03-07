import 'package:bluestack_test_app/index.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    homeScreenBloc.getUserDetails(
        failure: (message) {
          _scaffoldKey.currentState.showSnackBar(
              SnackBar(content: Text(message ?? Strings.errorUserFetched)));
        },
        success: (message) {});
    homeScreenBloc.getGameData(
        failure: (message) {
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text(message)));
        },
        success: (success) {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: appBar(),
        body: Column(
          children: [
            UserDetail(),
            RecommendedForYou(),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      toolbarHeight: 50,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        Strings.flyingWolf,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      leading: Icon(Icons.menu, color: Colors.black),
      actions: [logoutButton()],
      centerTitle: true,
    );
  }

  PopupMenuButton<String> logoutButton() {
    return PopupMenuButton(
        child: Icon(
          Icons.more_vert,
          color: Colors.black,
        ),
        itemBuilder: (_) => <PopupMenuItem<String>>[
              new PopupMenuItem<String>(
                  child: Text(
                    mainAppBloc.getLanguageMap[Strings.logout],
                  ),
                  value: Strings.logout),
              new PopupMenuItem<String>(
                  child: Text(Strings.japnese), value: Strings.ja),
              new PopupMenuItem<String>(
                  child: Text(Strings.english), value: Strings.en),
            ],
        onSelected: (value) async {
          if (value == Strings.logout) {
            await preferenceUtils.clear();
            Widgets.navigateByReplacement(context, LoginScreen());
          } else {
            mainAppBloc.setLocale(Locale(value));
            await mainAppBloc.load();
            await preferenceUtils.setString(PreferenceKeys.locale, value);
          }
        });
  }
}
