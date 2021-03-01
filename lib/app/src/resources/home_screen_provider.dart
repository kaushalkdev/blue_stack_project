import 'package:bluestack_test_app/index.dart';

class HomeSreeenProvider {
  Future<void> getGameData(
      {void Function(GameModel) success,
      void Function(String) failure,
      String cursor = ''}) async {
    try {
      var response = await get(ApiUrls.tournamentList + '$cursor');
      success(GameModel.fromJson(jsonDecode(response.body)));
    } on PlatformException catch (e) {
      failure(e.message);
    } on HttpException catch (e) {
      failure(e.message);
    } on TimeoutException catch (e) {
      failure(e.message);
    } on SocketException catch (e) {
      failure(e.message);
    } catch (e) {
      failure(e.toString());
    }
  }

  Future<void> getUserDetail(
      {void Function(String) failure, void Function(UserModel) success}) async {
    try {
      var response = await get(ApiUrls.userDetail);
      success(UserModel.fromJson(jsonDecode(response.body)));
    } on PlatformException catch (e) {
      failure(e.message);
      print(e.message);
    } on HttpException catch (e) {
      failure(e.message);
      print(e.message);
    } on TimeoutException catch (e) {
      failure(e.message);
      print(e.message);
    } on SocketException catch (e) {
      failure(e.message);
      print(e.message);
    } catch (e) {
      failure(e.toString());
      print(e.toString());
    }
  }
}
