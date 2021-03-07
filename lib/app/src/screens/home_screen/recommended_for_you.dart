import 'package:bluestack_test_app/index.dart';

class RecommendedForYou extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 18, bottom: 18),
          child: StreamBuilder(
            stream: mainAppBloc.getLanguageMapStream,
            builder: (context, snapshot) => Text(
              snapshot.data[Strings.recomendedForYou],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        StreamBuilder<List<Tournaments>>(
            stream: homeScreenBloc.tournamentsList,
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return loader(context);
              } else if (snap.hasError) {
                return Center(child: Text(snap.error.toString()));
              } else
                return StreamBuilder<bool>(
                    stream: homeScreenBloc.isLoadingGame,
                    builder: (context, snapshot) {
                      return listOfGames(context, snap, snapshot);
                    });
            })
      ],
    );
  }

  Stack listOfGames(
    BuildContext context,
    AsyncSnapshot<List<Tournaments>> snap,
    AsyncSnapshot<bool> snapshot,
  ) {
    return Stack(
      children: [
        Container(
          height: Widgets.getheight(context) * 0.52,
          child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: snap.data.length,
              itemBuilder: (context, index) {
                if (index == snap.data.length - 1) {
                  homeScreenBloc.getGameData(
                    failure: (message) {},
                    success: (message) {},
                  );
                }

                return gameCard(context, index, snap.data);
              }),
        ),
        if (snapshot?.data ?? false) Widgets.loader(context)
      ],
    );
  }

  Shimmer loader(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey,
      child: Column(
        children: [
          for (int i = 0; i < 3; i++)
            Container(
              margin: EdgeInsets.only(bottom: 10, right: 20, left: 20),
              decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  )),
              height: Widgets.getheight(context) * 0.1,
            )
        ],
      ),
    );
  }

  Widget gameCard(context, index, List<Tournaments> data) {
    return Container(
      margin: EdgeInsets.only(left: 20, bottom: 20, right: 20),
      child: Column(
        children: [
          cardImage(context, data[index]?.coverUrl ?? null),
          cardTextContainer(data[index] ?? null, context),
        ],
      ),
    );
  }

  Container cardImage(context, String coverUrl) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          )),
      height: Widgets.getheight(context) * 0.1,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        child: coverUrl == null
            ? null
            : Image.network(coverUrl,
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity),
      ),
    );
  }

  Container cardTextContainer(Tournaments data, context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 10.0,
            )
          ],
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )),
      child: cardText(data, context),
    );
  }

  Row cardText(Tournaments data, context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: textColumns(data, context),
        ),
        Spacer(),
        IconButton(
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Colors.black54,
            size: 14,
          ),
          onPressed: () {},
        )
      ],
    );
  }

  Column textColumns(Tournaments data, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Widgets.getWidth(context) * 0.65,
          child: Text(
            data?.name ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 7),
        Text(
          data?.gameName ?? '',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
