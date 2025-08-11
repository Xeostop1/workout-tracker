import 'package:flutter/material.dart';
import 'my_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; //

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugShowCheckedModeBanner:
    false;
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        fontFamily: 'Pretendard',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: Color(0xff006eff),
          primary: Color(0xff006eff),
          outline: Color(0xff717171),
          outlineVariant: Color(0xff717171),
          surfaceDim: Color(0xff979797),
        ),
      ),
      darkTheme: ThemeData(
        fontFamily: 'Pretendard',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xff006eff),
          brightness: Brightness.dark,
        ),
      ),
      // home: LandingPage(),
      // home: WorkoutListPage(),
      // home:WorkoutGuidePage()
      // home:WorkoutHomePage()
    );
  }
}
