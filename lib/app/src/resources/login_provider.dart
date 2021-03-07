import 'package:bluestack_test_app/index.dart';

class LoginProvider {
  Future<void> userLogin({
    String userName,
    String password,
    void Function(String) success,
    void Function(String) failure,
  }) async {
    //checking if user present in the list
    var res = Strings.userCredmap
        .indexWhere((element) => element['username'] == userName);

    // success if user found with creds
    if (res >= 0) {
      if (Strings.userCredmap[res]['password'] == password) {
        success(mainAppBloc.getLanguageMap[Strings.successLogin]);
        //setting login status
        _setLoginFlag(true);
      } else {
        failure(mainAppBloc.getLanguageMap[Strings.errorPassword]);
      }
    } else {
      failure(mainAppBloc.getLanguageMap[Strings.errorUsername]);
    }
  }

  Future<bool> logOut() async {
    return await _setLoginFlag(false);
  }

  Future<bool> _setLoginFlag(bool flag) async {
    return await preferenceUtils.setBool(PreferenceKeys.loginFlag, flag);
  }

  bool getLoginFlag() {
    return preferenceUtils.getBool(PreferenceKeys.loginFlag);
  }
}
