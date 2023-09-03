import 'package:flutter/material.dart';
import 'package:notephp/app/constant/auth/signup.dart';
import 'package:notephp/app/notes/add.dart';
import 'package:notephp/app/notes/edit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/constant/auth/login_view.dart';
import 'app/constant/auth/success.dart';
import 'app/home_view.dart';

late SharedPreferences sharedPre;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPre = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "course php rest API",
      initialRoute: sharedPre.getString("id") == null ? "login" : "home",
      routes: {
        "login": (context) => const LoginView(),
        "signup": (context) => const singupView(),
        "home": (context) => const Home(),
        "success": (context) => const Success(),
        "addnotes": (context) => const AddNote(),
        "editnotes": (context) => const EditNote(),
      },
    );
  }
}
