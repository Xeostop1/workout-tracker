import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:go_router/go_router.dart';

import 'workout.dart';
import 'workout_manager.dart';

class WorkoutGuidePage extends StatefulWidget {
  final int workoutIndex;
  final int groupIndex;
  WorkoutGuidePage({super.key, required this.workoutIndex,required this.groupIndex});

  @override
  State<WorkoutGuidePage> createState() => _WorkoutGuidePageState();
}

class _WorkoutGuidePageState extends State<WorkoutGuidePage> {
  final player = AudioPlayer();
  late Workout currentWorkout;
  int workoutsIndex=0;
  late List<Workout> workouts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    workouts=WorkoutManager.workoutGroups[widget.groupIndex].workouts;
    workoutsIndex=widget.workoutIndex;
    currentWorkout=workouts[workoutsIndex];
    WorkoutManager.increaseTodayWorkoutMinutes(currentWorkout.minutes);
    WorkoutManager.increaseTodayWorkoutKcal(currentWorkout.kcal);
  }

  IconButton getIconButton() {
    if (player.state==PlayerState.stopped) {
      return IconButton(
        onPressed: () async{
          await player.play(AssetSource('${currentWorkout.audioName}'));
          setState(() {});
        },
        icon: Icon(Icons.play_circle),
        iconSize: 70,
      );
    } else {
      return IconButton(
        onPressed: () async{
          await player.stop();
          setState(() {});
        },
        icon: Icon(Icons.stop_circle, color: Colors.blue),
        iconSize: 70,
      );
    }
  }
  void prevWorkout()async{
    await player.stop();

    if(workoutsIndex>0) {
      workoutsIndex--;
    }else{
      workoutsIndex= workouts.length-1;
    }
    currentWorkout=workouts[workoutsIndex];

    setState(() { });

  }
  void nextWorkout(){
    if(workoutsIndex > workouts.length -1){
      workoutsIndex=0;
    }else{
      workoutsIndex++;
    }
    currentWorkout=workouts[workoutsIndex];

  }
  @override
  void dispose() {
    player.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //final workoutsIndex = GoRouterState.of(context).pathParameters['workouts_index'];

    return Scaffold(
      appBar: AppBar(
        title: Text('WorkoutGuide'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text(
                '${currentWorkout.name}',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue,
                  decorationThickness: 2.0,
                ),
              ),
              SizedBox(width: 20),
              Text(
                '산을 오르는 자세를 닮아 붙은\n이름으로 단시간 안에 체지방을\n많이 태워 복부 비만에 제격입니다.',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Spacer(),
            ],
          ), //1
          Row(
            children: [
              IconButton(
                onPressed: () {
                  //event 처리, action 처리
                  prevWorkout();
                },
                icon: Icon(Icons.arrow_back_ios),
                iconSize: 70,
              ),
              Expanded(
                child: Image.asset('assets/${currentWorkout.imageName}', fit: BoxFit.cover),
              ),

              IconButton(
                onPressed: () async{
                  //event 처리, action 처리
                  await player.stop();
                  setState(() {
                    nextWorkout();
                  });
                },
                icon: Icon(Icons.arrow_forward_ios),
                iconSize: 70,
              ),
            ],
          ), //2
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 160,
                height: 100,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      '운동 부위',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '배, 상체 근육',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 160,
                height: 100,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      '이런 사람에게 강추!',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '뱃살이 고민이에요',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '체지방 태우고싶어요',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ), //3
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      '${currentWorkout.minutes}분',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ), //4
          getIconButton(),
        ],
      ),
    );
  }
}
