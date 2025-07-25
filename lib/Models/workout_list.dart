//filename: workout_list_page.dart
import 'package:flutter/material.dart';
import '../workout.dart';

class WorkoutListPage extends StatelessWidget {
  WorkoutListPage({super.key});

  List<Workout> workouts = [
    Workout(
      name: '스쿼트',
      minutes: 30,
      imageName: 'squat.png',
      audioName: 'squat.mp3',
      kcal: 200,
    ),
    Workout(
      name: '윗몸 일으키기',
      minutes: 20,
      imageName: 'sit_up.png',
      audioName: 'sit_up.mp3',
      kcal: 100,
    ),
    Workout(
      name: '마운틴 클림버',
      minutes: 15,
      imageName: 'mountain_climber.png',
      audioName: 'mountain_climber.mp3',
      kcal: 50,
    ),
    Workout(
      name: '사이드 런지',
      minutes: 20,
      imageName: 'side_lunge.png',
      audioName: 'side_lunge.mp3',
      kcal: 100,
    ),
    Workout(
      name: '푸시업',
      minutes: 15,
      imageName: 'push_up.png',
      audioName: 'push_up.mp3',
      kcal: 100,
    ),
    Workout(
      name: '덩키 킥',
      minutes: 30,
      imageName: 'donkey_kick.png',
      audioName: 'donkey_kick.mp3',
      kcal: 50,
    ),
    Workout(
      name: '사이드 플랭크',
      minutes: 25,
      imageName: 'side_plank.png',
      audioName: 'side_plank.mp3',
      kcal: 120,
    ),
    Workout(
      name: '리버스 플랭크',
      minutes: 25,
      imageName: 'reverse_plank.png',
      audioName: 'reverse_plank.mp3',
      kcal: 120,
    ),
    Workout(
      name: '힙 브릿지',
      minutes: 20,
      imageName: 'hip_bridge.png',
      audioName: 'hip_bridge.mp3',
      kcal: 80,
    ),
    Workout(
      name: '어꺠 스트레칭',
      minutes: 10,
      imageName: 'shoulder_stretch.png',
      audioName: 'shoulder_stretch.mp3',
      kcal: 30,
    ),
    Workout(
      name: '햄스트링',
      minutes: 10,
      imageName: 'hamstring_stretch.png',
      audioName: 'hamstring_stretch.mp3',
      kcal: 30,
    ),
  ];

  List<GestureDetector> getWorkoutList(){
    List<GestureDetector> workoutListRow=[];
    for(var i=0;i<workouts.length;i++){
      var name =workouts[i].name;
      var image = workouts[i].imageName;
      var minutes = workouts[i].minutes;
      workoutListRow.add(
        GestureDetector(
          onTap: (){
            //route code here
          },
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage('assets/$image')),
                ),
              ),
              Expanded(
                child: Text('${i+1}.$name', style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.only(right:10.0),
                child: Text('$minutes 분', style: TextStyle(fontSize: 20, color: Colors.blue)),
              )
            ],
          ),
        ),
      );
    }
    return workoutListRow;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('WorkoutList'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: getWorkoutList(),
          ),
        )
    );
  }
}

