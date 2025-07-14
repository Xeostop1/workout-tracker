import 'package:flutter/material.dart';
import 'package:hnworkouttracker/workout_guide_page.dart';
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
      // home: LandingPage(),
      // home: WorkoutListPage(),
      home:WorkoutGuidePage()
    );
  }
}




