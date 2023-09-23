import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hang_game_project/auth/login_screen.dart';
import 'package:hang_game_project/screen/home_screen.dart';
import 'package:hang_game_project/ui/colors.dart';
import 'package:hang_game_project/ui/widget/figure_image.dart';
import 'package:hang_game_project/ui/widget/letter.dart';
import 'package:hang_game_project/utils/game.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
