import 'package:flutter/material.dart';
import 'package:medical_app/authantication/loginScreen.dart';
import 'package:medical_app/provider/homeProvider.dart';
import 'package:medical_app/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  bool isLoggedIn = await checkLoginStatus();
  runApp(ChangeNotifierProvider(
    create: (context) => HomeProvider(),
    child: MyApp(isLoggedIn: isLoggedIn),
  ));
}

Future<bool> checkLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  return isLoggedIn;
}

class MyApp extends StatelessWidget {
  final bool? isLoggedIn;
  const MyApp({super.key, this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medical App',
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.green),
      routes: route,
      initialRoute: isLoggedIn! ? homeScreen : loginScreen,
    );
  }
}
