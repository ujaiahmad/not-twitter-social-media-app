import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/firebase_options.dart';
import 'package:social_media_app/pages/homepage.dart';
import 'package:social_media_app/pages/loginpage.dart';
import 'package:social_media_app/pages/profile.dart';
import 'package:social_media_app/pages/users.dart';
import 'package:social_media_app/theme/dark_mode.dart';
import 'package:social_media_app/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightMode,
      darkTheme: darkMode,
      home: LoginPage(),
      routes: {
        'login': (context) => LoginPage(),
        'home': (context) => HomePage(),
        'user': (context) => Users(),
        'account': (context) => Profile()
      },
    );
  }
}
