class UserModel {
  String userName;
  String userImage;
  int eloRating;
  int tournamentPlayed;
  int tournamentWon;
  int winningPercentage;

  UserModel(
      {this.userName = 'userName',
      this.userImage = 'userImage',
      this.eloRating = 0,
      this.tournamentPlayed = 0,
      this.tournamentWon = 0,
      this.winningPercentage = 0});

  UserModel.fromJson(Map<String, dynamic> userMap) {
    userName = userMap['userName'];
    userImage = userMap['userImage'];
    eloRating = userMap['eloRating'];
    tournamentPlayed = userMap['tournamentPlayed'];
    tournamentWon = userMap['tournamentWon'];
    winningPercentage = userMap['winningPercentage'];
  }

  Map<String, dynamic> toJson(UserModel userModel) {
    final Map<String, dynamic> userMap = new Map<String, dynamic>();
    userMap['userName'] = this.userName;
    userMap['userImage'] = this.userImage;
    userMap['eloRating'] = this.eloRating;
    userMap['tournamentPlayed'] = this.tournamentPlayed;
    userMap['winningPercentage'] = this.winningPercentage;
    userMap['tournamentWon'] = this.tournamentWon;
    return userMap;
  }
}
