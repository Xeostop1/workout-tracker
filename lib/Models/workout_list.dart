import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hnworkouttracker/workout_manager.dart';
import '../workout.dart';

class WorkoutListPage extends StatelessWidget {
  final int groupIndex;
  List<Workout> workouts;

  WorkoutListPage({
    super.key,
    required this.groupIndex
}):workouts=WorkoutManager.workoutGroups[groupIndex].workouts;    //인스트럭터 이니셜라이즈 라고 부름
  //컨스트럭터에서 영역에서 초기화 해주고 있다. ->조금 딜레이 초기화를 시킬 수 있는 것 컨스트럭터 바디로 들어가면 : 인스터스의 영역이라서 나중에 초기화 된다

  // List<String> workoutName = ['스쿼트',    '마운틴 클림버',    '푸시업',    '윗몸 일으키기',    '사이드 런지',    '덩키 킥',    '사이드 플랭크',    '리버스 플랭크',    '힙 브릿지',    '어꺠 스트레칭',    '햄스트링'  ];
  // List<String> workoutImage = ['squat.png',  'mountain_climber.png',    'push_up.png',    'sit_up.png',    'side_lunge.png',    'donkey_kick.png',    'side_plank.png',    'reverse_plank.png',    'hip_brdige.png',    'shoulder_stretch.png',    'hamstring_stretch.png',  ];
  // List<int> workoutMinutes = [30, 20, 15, 15, 20, 30, 20, 15, 25, 15, 10];


  //글로벌 변수로 초기화 할 . 있음

  // //이런걸 헬퍼펑션이라고 한다
  List<GestureDetector> getWorkoutList(BuildContext context){

    List<GestureDetector> workoutListResult = [];
    for(int i=0; i<workouts.length; i++){
      //todo: 혼자 꼭 만들어보기 익스펜디드
      workoutListResult.add(
          GestureDetector(
            onTap: () {
              context.go('/workout_home/workout_list/$groupIndex/workout_guide/$i');
            },
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/${workouts[i].imageName}'
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${i+1}${workouts[i].name}',
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Text(
                    '${workouts[i].minutes}분',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
          )
      );
    }
    return workoutListResult;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WorkoutList"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 헤더 부분 (운동 | 세트당 소요시간)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "운동",

                  ),
                  Text(
                    "세트당 소요시간",

                  ),
                ],
              ),
            ),

            // 운동 리스트
            ...getWorkoutList(context),
          ],
        ),
      ),
    );
  }

}
