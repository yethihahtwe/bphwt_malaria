import 'package:bphwt/screen/home.dart';
import 'package:bphwt/screen/profile_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MalariaApp());
}

class MalariaApp extends StatelessWidget {
  const MalariaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        'profile_detail': (context) => const ProfileDetail(),
      },
      theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(
        Theme.of(context).textTheme,
      )),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      // home: Home(),
    );
  }
}
