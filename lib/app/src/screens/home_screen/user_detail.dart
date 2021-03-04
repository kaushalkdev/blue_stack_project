import 'package:bluestack_test_app/index.dart';

class UserDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Widgets.getheight(context) * 0.05),
      width: Widgets.getWidth(context),
      child: StreamBuilder<UserModel>(
          stream: homeScreenBloc.getUserModel,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return loader(context, snapshot);
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return loader(context, snapshot);
            } else
              return buildColumn(context, snapshot);
          }),
    );
  }

  Shimmer loader(BuildContext context, AsyncSnapshot<UserModel> snapshot) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: CircleAvatar(
                  maxRadius: Widgets.getheight(context) * 0.035,
                ),
              ),
              userName(context, snapshot.data)
            ],
          ),
          SizedBox(height: 20),
          userCardDetials(context, snapshot.data),
        ],
      ),
    );
  }

  Column buildColumn(BuildContext context, AsyncSnapshot<UserModel> snapshot) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: CircleAvatar(
                maxRadius: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  child: Image.network(
                    snapshot.data.userImage,
                    fit: BoxFit.fill,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            userName(context, snapshot.data)
          ],
        ),
        SizedBox(height: 20),
        userCardDetials(context, snapshot.data),
      ],
    );
  }

  Column userName(BuildContext context, UserModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data?.userName ?? English.username,
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        rating(context, data)
      ],
    );
  }

  Row userCardDetials(BuildContext context, UserModel data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: boxDecorationOne(),
          height: Widgets.getheight(context) * 0.1,
          width: Widgets.getWidth(context) * 0.3,
          child: textFields(
            text: English.tournamentPlayed,
            value: data?.tournamentPlayed?.toString() ?? '',
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 2, right: 2),
          height: Widgets.getheight(context) * 0.1,
          width: Widgets.getWidth(context) * 0.3,
          decoration: boxDecorationTwo(),
          child: textFields(
            text: English.tournamentWon,
            value: data?.tournamentWon?.toString() ?? '',
          ),
        ),
        Container(
          decoration: boxDecorationThree(),
          height: Widgets.getheight(context) * 0.1,
          width: Widgets.getWidth(context) * 0.3,
          child: textFields(
            text: English.winingPercentage,
            value: data?.winningPercentage?.toString() ?? '',
          ),
        ),
      ],
    );
  }

  BoxDecoration boxDecorationThree() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.topRight,
        colors: [
          Colors.red[600],
          Colors.red[400],
          Colors.red[200],
        ],
      ),
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    );
  }

  BoxDecoration boxDecorationTwo() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.topRight,
        colors: [
          Colors.purple[600],
          Colors.purple[400],
          Colors.purple[300],
        ],
      ),
    );
  }

  BoxDecoration boxDecorationOne() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.topRight,
        colors: [
          Colors.orange[600],
          Colors.orange[400],
          Colors.orange[300],
        ],
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomLeft: Radius.circular(20),
      ),
    );
  }

  Container rating(BuildContext context, UserModel data) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      margin: EdgeInsets.only(top: Widgets.getheight(context) * 0.015),
      child: Row(
        children: [
          Text(
            data?.eloRating?.toString() ?? '',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(width: 7),
          Text(
            English.eloRating,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
          )
        ],
      ),
    );
  }

  Center textFields({String value, String text}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
