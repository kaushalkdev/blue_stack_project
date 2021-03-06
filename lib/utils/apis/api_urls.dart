class ApiUrls {
  static const baseUrl = 'http://tournaments-dot-game-tv-prod.uc.r.appspot.com';
  //self hosted node js server on heroku
  static const userbaseUrl = 'https://obscure-wave-11241.herokuapp.com';

  static const tournamentList = baseUrl +
      '/tournament/api/tournaments_list_v2?limit=10&status=all&cursor=';
  static const userDetail = userbaseUrl + '/user';
}
