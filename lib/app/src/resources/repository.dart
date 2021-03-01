import 'package:bluestack_test_app/index.dart';

class Repository {
  var _loginProvider = LoginProvider();
  var _homeScreenProvider = HomeSreeenProvider();

  //login apis
  Future<void> userLogin(
      {String userName,
      String password,
      void Function(String) success,
      void Function(String) failure}) async {
    await _loginProvider.userLogin(
        userName: userName,
        password: password,
        success: success,
        failure: failure);
  }

  Future<bool> logOut() async {
    return await _loginProvider.logOut();
  }

  bool getLoginFlag() {
    return _loginProvider.getLoginFlag();
  }

  //home page apis
  Future<void> getGameData(
      {String cursor,
      void Function(GameModel) success,
      void Function(String) failure}) async {
    await _homeScreenProvider.getGameData(
      cursor: cursor,
      failure: failure,
      success: success,
    );
  }

  Future<void> getUserDetails(
      {void Function(UserModel) success, void Function(String) failure}) async {
    await _homeScreenProvider.getUserDetail(failure: failure, success: success);
  }
}

var repository = Repository();
