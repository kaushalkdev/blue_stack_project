import 'package:bluestack_test_app/index.dart';

class LoginBloc {
  var _repository = Repository();
  var _userName = BehaviorSubject<String>();
  var _password = BehaviorSubject<String>();
  var _valuserName = BehaviorSubject<bool>();
  var _valPassord = BehaviorSubject<bool>();

  //obervable
  Stream<String> get userName => _userName.stream.transform(_validateUserName);
  Stream<String> get password => _password.stream.transform(_validatePassword);

  // setters
  Function(String) get changeuserName => _userName.sink.add;
  Function(String) get changePassword => _password.sink.add;

//valigating username
  final _validateUserName = StreamTransformer<String, String>.fromHandlers(
      handleData: (userName, sink) {
    if (userName.length > 3) {
      sink.add(userName);
    } else {
      sink.addError(mainAppBloc.getLanguageMap[Strings.limitEmail]);
    }
  });

//vaidating passowrd
  final _validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 3) {
      sink.add(password);
    } else {
      sink.addError(mainAppBloc.getLanguageMap[Strings.limitPassword]);
    }
  });
  Future<void> userLogin(
      {void Function(String) success, void Function(String) failure}) async {
    await _repository.userLogin(
        failure: failure,
        success: success,
        userName: _userName.value,
        password: _password.value);
  }

  Future<bool> logOut() async {
    return await _repository.logOut();
  }

  bool getLoginFlag() {
    return _repository.getLoginFlag();
  }

  Future<void> dispose() async {
    await _userName.close();
    await _password.close();
    await _valPassord.close();
    await _valuserName.close();
  }
}

var loginBloc = LoginBloc();
