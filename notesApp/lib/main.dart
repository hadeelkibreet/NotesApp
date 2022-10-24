import 'package:flutter/material.dart';
import 'package:notesapp/app/Notes/add.dart';
import 'package:notesapp/app/Notes/edit.dart';
import 'package:notesapp/app/auth/Login.dart';
import 'package:notesapp/app/home.dart';
import 'package:notesapp/app/auth/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'course PHP Rest API',
      // ignore: unnecessary_null_comparison
      initialRoute: sharedPref.getString("id")== null?"login":"home",
      routes: {
        "login": (context) => const Login(),
        "signup": (context) => const signUp(),
        "home": (context) => const home(),
        "addnotes": (context) => const AddNotes(),
        "editnotes": (context) => const EditNotes(),

      },
    );
  }
}
