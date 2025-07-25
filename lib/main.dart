import 'package:flutter/material.dart';
import 'package:hnworkouttracker/workout_guide_page.dart';
import 'package:hnworkouttracker/workout_home_page.dart';
import 'package:hnworkouttracker/workout_list_page.dart';
import 'landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugShowCheckedModeBanner: false;
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: Color(0xff006eff),
          primary: Color(0xff006eff),
          outline: Color(0xff717171),
          outlineVariant: Color(0xff717171),
          surfaceDim: Color(0xff979797)
        )
      ),
      darkTheme: ThemeData(
        fontFamily: 'Pretendard',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xff006eff),
          brightness: Brightness.dark,
        )
      ),
      // home: LandingPage(),
      // home: WorkoutListPage(),
      home:WorkoutGuidePage()
      // home:WorkoutHomePage()
    );
  }
}




