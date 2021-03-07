import 'package:bluestack_test_app/index.dart';

class HomeScreenBloc {
  var _repository = Repository();
  var _tournaments = BehaviorSubject<List<Tournaments>>();
  var _isLoadingGameLoading = PublishSubject<bool>();
  var _isPersonalDataLoading = PublishSubject<bool>();
  var _tournamentList = List<Tournaments>();
  var _userModel = PublishSubject<UserModel>();
  var _cursor = '';

  //getters
  Stream<List<Tournaments>> get tournamentsList => _tournaments.stream;
  Stream<bool> get isLoadingGame => _isLoadingGameLoading.stream;
  Stream<bool> get isPersonalLoading => _isPersonalDataLoading.stream;
  Stream<UserModel> get getUserModel => _userModel.stream;

  //values
  List<Tournaments> get tournamentsListValue => _tournaments.value;
  //setters
  Function(List<Tournaments>) get setTournamentList => _tournaments.sink.add;
  Function(bool) get setIsLoadingGame => _isLoadingGameLoading.sink.add;
  Function(bool) get setIsPersonalLoading => _isPersonalDataLoading.sink.add;
  Function(UserModel) get setuserModel => _userModel.sink.add;

  Future<void> getGameData({
    void Function(String) failure,
    void Function(String) success,
    cursorVal,
  }) async {
    _isLoadingGameLoading.sink.add(true);
    await _repository.getGameData(
        cursor: _cursor,
        failure: failure,
        success: (gameModel) {
          if (_cursor != gameModel.data.cursor) {
            _cursor = gameModel.data.cursor;

            success(mainAppBloc.getLanguageMap[Strings.successGameDataFetched]);
            _tournamentList.addAll(gameModel.data.tournaments);
            setTournamentList(_tournamentList);
            _isLoadingGameLoading.sink.add(false);
          } else {
            failure(mainAppBloc.getLanguageMap[Strings.gameFetchedEnded]);
            _isLoadingGameLoading.sink.add(false);
          }
        });
  }

  Future<void> getUserDetails(
      {void Function(String) success, void Function(String) failure}) async {
    await _repository.getUserDetails(
        success: (userModel) {
          _userModel.sink.add(userModel);
          success(mainAppBloc.getLanguageMap[Strings.successUserDetail]);
        },
        failure: failure);
  }

  Future<void> dispose() async {
    await _tournaments.close();
    await _isLoadingGameLoading.close();
    await _isPersonalDataLoading.close();
    await _userModel.close();
  }
}

var homeScreenBloc = HomeScreenBloc();
