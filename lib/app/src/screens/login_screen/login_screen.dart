import 'package:bluestack_test_app/app/src/blocs/main_app_bloc.dart';
import 'package:bluestack_test_app/index.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: appBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image(context),
              userName(context),
              passWord(context),
              forgotPassword(),
              submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      toolbarHeight: 50,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        AppLocalization.of(context).getTransaledValue(Strings.headderLogin),
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [language()],
    );
  }

  PopupMenuButton<String> language() {
    return PopupMenuButton(
        child: Icon(
          Icons.more_vert,
          color: Colors.black,
        ),
        itemBuilder: (_) => <PopupMenuItem<String>>[
              new PopupMenuItem<String>(
                  child: const Text(Strings.japnese), value: Strings.ja),
              new PopupMenuItem<String>(
                  child: const Text(Strings.english), value: Strings.en),
            ],
        onSelected: (value) async {
          mainAppBloc.setLocale(Locale(value));
          await preferenceUtils.setString(PreferenceKeys.locale, value);
        });
  }

  Container image(BuildContext context) {
    return Container(
      height: Widgets.getheight(context) * 0.15,
      width: Widgets.getWidth(context) * 0.3,
      child: Image.asset(
        Widgets.getImage(
          Images.gameTvIconWhite,
        ),
        fit: BoxFit.fill,
      ),
    );
  }

  Container forgotPassword() {
    return Container(
      padding: EdgeInsets.only(right: 30, top: 20),
      alignment: Alignment.centerRight,
      child: Text(
        AppLocalization.of(context).getTransaledValue(Strings.forgotPassword),
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }

  Widget submitButton() {
    return StreamBuilder(
      stream: loginBloc.userName,
      builder: (context, nameSnap) => StreamBuilder(
        stream: loginBloc.password,
        builder: (context, passSnap) => GestureDetector(
          onTap: (nameSnap.hasError || passSnap.hasError)
              ? null
              : () async {
                  await loginBloc.userLogin(success: (message) {
                    Widgets.navigateByReplacement(context, HomeScreen());
                  }, failure: (message) {
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Text(message),
                    ));
                  });
                },
          child: Container(
            height: 40,
            width: 100,
            margin: EdgeInsets.only(top: 20),
            decoration:
                boxDecorationThree(nameSnap.hasError || passSnap.hasError),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, right: 10, left: 10, bottom: 10),
                child: Text(
                  AppLocalization.of(context)
                      .getTransaledValue(Strings.loginButton),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration boxDecorationThree(bool status) {
    return BoxDecoration(
        color: Colors.grey,
        gradient: status
            ? null
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                    Colors.orange[600],
                    Colors.orange[400],
                    Colors.orange[300],
                  ]),
        borderRadius: BorderRadius.all(Radius.circular(30)));
  }

  Container passWord(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: buildBoxDecorationTwo(),
      child: Center(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Icon(Icons.lock),
            ),
            textFormFieldTwo(context),
            Spacer(),
            passwordStatus(),
            SizedBox(width: 20)
          ],
        ),
      ),
    );
  }

  StreamBuilder<String> passwordStatus() {
    return StreamBuilder<String>(
      stream: loginBloc.password,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return GestureDetector(
            onTap: () {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text(snapshot.error),
              ));
            },
            child: Icon(
              Icons.error,
              color: Colors.red,
            ),
          );
        } else {
          return Icon(
            Icons.check,
            color: Colors.green,
          );
        }
      },
    );
  }

  Container textFormFieldTwo(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, left: 10),
      width: Widgets.getWidth(context) * 0.5,
      child: StreamBuilder(
        builder: (context, snapshot) => TextFormField(
          maxLength: 10,
          maxLines: 1,
          obscureText: true,
          onChanged: loginBloc.changePassword,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
              border: InputBorder.none,
              counter: Container(),
              hintText: AppLocalization.of(context)
                  .getTransaledValue(Strings.passWordHint)),
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecorationTwo() {
    return BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0.0, 5.0),
            blurRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ));
  }

  Widget userName(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      decoration: buildBoxDecorationOne(),
      child: Center(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Icon(Icons.person),
            ),
            textFormFieldOne(context),
            Spacer(),
            userNameStatus(),
            SizedBox(width: 20)
          ],
        ),
      ),
    );
  }

  StreamBuilder<String> userNameStatus() {
    return StreamBuilder<String>(
      stream: loginBloc.userName,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return GestureDetector(
            onTap: () {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text(snapshot.error),
              ));
            },
            child: Icon(
              Icons.error,
              color: Colors.red,
            ),
          );
        } else {
          return Icon(
            Icons.check,
            color: Colors.green,
          );
        }
      },
    );
  }

  Container textFormFieldOne(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, left: 10),
      width: Widgets.getWidth(context) * 0.6,
      child: StreamBuilder<String>(
        stream: loginBloc.userName,
        builder: (context, snapshot) => TextFormField(
          maxLength: 10,
          maxLines: 1,
          onChanged: loginBloc.changeuserName,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            counter: Container(),
            border: InputBorder.none,
            hintText: AppLocalization.of(context)
                .getTransaledValue(Strings.userNameHint),
          ),
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecorationOne() {
    return BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0.0, 5.0),
            blurRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    loginBloc.dispose();
  }
}
