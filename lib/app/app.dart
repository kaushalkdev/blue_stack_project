import 'package:bluestack_test_app/index.dart';

class BlueStackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (loginBloc.getLoginFlag() ?? false) ? HomeScreen() : LoginScreen(),
    );
  }
}
