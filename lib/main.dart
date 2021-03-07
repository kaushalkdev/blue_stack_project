import 'package:bluestack_test_app/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await preferenceUtils.init();
  await mainAppBloc.init();
  runApp(BlueStackApp());
}
