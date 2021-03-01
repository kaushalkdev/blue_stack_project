import 'package:bluestack_test_app/index.dart';
import 'package:bluestack_test_app/utils/japanese.dart';

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
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text(message)));
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
                      preferenceUtils.getString(PreferenceKeys.language) ==
                              Strings.english
                          ? Strings.logout
                          : Japanese.logout),
                  value: Strings.logout),
              new PopupMenuItem<String>(
                  child: const Text(Strings.japnese), value: Strings.japnese),
              new PopupMenuItem<String>(
                  child: const Text(Strings.english), value: Strings.english),
            ],
        onSelected: (value) async {
          if (value == Strings.logout) {
            await preferenceUtils.clear();
            Widgets.navigateByReplacement(context, LoginScreen());
          } else {
            await preferenceUtils.setString(PreferenceKeys.language, value);
            setState(() {});
          }
        });
  }
}
