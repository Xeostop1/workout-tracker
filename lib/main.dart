import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(),
      // home: LayoutSample(),
    );
  }
}
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

//컬럼먼저 사용하고 그안에 로우로 화면 구성
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                color: Colors.black,
                padding: EdgeInsets.all(8),
                child: Text("My perfect workout mate",
                style: TextStyle(
                  color: Colors.white
                ),
                ),
              ),
              Image(image: AssetImage('assets/runner.png')),
              Align(
                alignment: Alignment.center,
                child: Text("Workout \nTracker",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 50
                  ),
                ),
              ),
             Padding(
               padding: const EdgeInsets.all(18.0),
               child: ElevatedButton(
                   onPressed: (){},
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.black87
        
                   ),
                   child:
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Text("시작하기",
                          style: TextStyle(
                            color: Colors.white,
                                fontSize: 30,
                          ),
                        ),
                      ),
                    )
        
               ),
             ),
            ],
          ),
          
        ),
      ),
    );
      
  }
}

// class LayoutSample extends StatelessWidget {
//   const LayoutSample({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Image(image: AssetImage('assets/runner-lager.png'),),
//
//       ),
//     );
//   }
// }




