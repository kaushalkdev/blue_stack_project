import 'package:bluestack_test_app/index.dart';

class Widgets {
  static String getImage(String imageName) {
    return 'images/$imageName';
  }

  static void navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(seconds: 1),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation =
              CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
          return ScaleTransition(
            alignment: Alignment.center,
            scale: animation,
            child: child,
          );
        },
        pageBuilder: (context, animation, secAnimaton) => page,
      ),
    );
  }

  static Widget loader(BuildContext context) {
    return Container(
      color: Colors.black12,
      height: getheight(context) / 2,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static void navigateByReplacement(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(seconds: 1),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation =
              CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
          return ScaleTransition(
            alignment: Alignment.center,
            scale: animation,
            child: child,
          );
        },
        pageBuilder: (context, animation, secAnimaton) => page,
      ),
    );
  }

  static double getheight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
