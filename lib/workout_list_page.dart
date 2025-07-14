import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutListPage extends StatelessWidget {

  List<String> workoutName = ['스쿼트',    '마운틴 클림버',    '푸시업',    '윗몸 일으키기',    '사이드 런지',    '덩키 킥',    '사이드 플랭크',    '리버스 플랭크',    '힙 브릿지',    '어꺠 스트레칭',    '햄스트링'  ];
  List<String> workoutImage = ['squat.png',    'mountain_climber.png',    'push_up.png',    'sit_up.png',    'side_lunge.png',    'donkey_kick.png',    'side_plank.png',    'reverse_plank.png',    'hip_brdige.png',    'shoulder_stretch.png',    'hamstring_stretch.png',  ];
  List<int> workoutMinutes = [30, 20, 15, 15, 20, 30, 20, 15, 25, 15, 10];

  // //이런걸 헬퍼펑션이라고 한다
  List<Widget> getWorkoutList(){
    List<Widget> workoutListResult = [];
    for(int i=0; i<workoutName.length; i++){
      //todo: 혼자 꼭 만들어보기 익스펜디드
      workoutListResult.add(
        Row(
          children: [
            Container(
              width: 80,
              height: 80,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/${workoutImage[i]}'
                  ),
              ),
            ),
            ),
            Expanded(
                child: Text(
                  '${i+1}${workoutName[i]}',
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(
                '${workoutMinutes[i]}분',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
            )
          ],
        )
      );
    }
    return workoutListResult;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WorkoutList"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: getWorkoutList(),
        ),
      ),
    );
  }
}
