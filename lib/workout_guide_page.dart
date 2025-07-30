//filename:workout_guide_page.dart
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hnworkouttracker/workout_manager.dart';
import '../workout.dart';

class WorkoutGuidePage extends StatefulWidget {
  final int workoutsIndex;
  final int groupIndex;

  late List<Workout> workouts;

  WorkoutGuidePage({super.key,
    required this.workoutsIndex,
    required this.groupIndex
  });

  @override
  State<WorkoutGuidePage> createState() => _WorkoutGuidePageState();
}

class _WorkoutGuidePageState extends State<WorkoutGuidePage> {
  // List<Workout> workouts = [
  //   Workout(
  //     name: '스쿼트',
  //     minutes: 30,
  //     imageName: 'squat.png',
  //     audioName: 'squat.mp3',
  //     kcal: 200,
  //   ),
  //   Workout(
  //     name: '윗몸 일으키기',
  //     minutes: 20,
  //     imageName: 'sit_up.png',
  //     audioName: 'sit_up.mp3',
  //     kcal: 100,
  //   ),
  //   Workout(
  //     name: '마운틴 클림버',
  //     minutes: 15,
  //     imageName: 'mountain_climber.png',
  //     audioName: 'mountain_climber.mp3',
  //     kcal: 50,
  //   ),
  //   Workout(
  //     name: '사이드 런지',
  //     minutes: 20,
  //     imageName: 'side_lunge.png',
  //     audioName: 'side_lunge.mp3',
  //     kcal: 100,
  //   ),
  //   Workout(
  //     name: '푸시업',
  //     minutes: 15,
  //     imageName: 'push_up.png',
  //     audioName: 'push_up.mp3',
  //     kcal: 100,
  //   ),
  //   Workout(
  //     name: '덩키 킥',
  //     minutes: 30,
  //     imageName: 'donkey_kick.png',
  //     audioName: 'donkey_kick.mp3',
  //     kcal: 50,
  //   ),
  //   Workout(
  //     name: '사이드 플랭크',
  //     minutes: 25,
  //     imageName: 'side_plank.png',
  //     audioName: 'side_plank.mp3',
  //     kcal: 120,
  //   ),
  //   Workout(
  //     name: '리버스 플랭크',
  //     minutes: 25,
  //     imageName: 'reverse_plank.png',
  //     audioName: 'reverse_plank.mp3',
  //     kcal: 120,
  //   ),
  //   Workout(
  //     name: '힙 브릿지',
  //     minutes: 20,
  //     imageName: 'hip_bridge.png',
  //     audioName: 'hip_bridge.mp3',
  //     kcal: 80,
  //   ),
  //   Workout(
  //     name: '어꺠 스트레칭',
  //     minutes: 10,
  //     imageName: 'shoulder_stretch.png',
  //     audioName: 'shoulder_stretch.mp3',
  //     kcal: 30,
  //   ),
  //   Workout(
  //     name: '햄스트링',
  //     minutes: 10,
  //     imageName: 'hamstring_stretch.png',
  //     audioName: 'hamstring_stretch.mp3',
  //     kcal: 30,
  //   ),
  // ];

  List<Workout> workouts = WorkoutManager.workouts;
  final player = AudioPlayer();
  late Workout currentWorkout;
  int workoutsIndex = 0;


  @override
  void initState() {
    super.initState();
    //인잇에 넣은 이유!
    workoutsIndex=widget.workoutsIndex;
    currentWorkout = workouts[workoutsIndex];
     workouts=WorkoutManager.workoutGroups[widget.groupIndex].workouts;
  }

  ///다음 운동으로 이동
  void nextWorkout(){
    if(workoutsIndex<workouts.length-1){
      workoutsIndex++;
    }else{
      workoutsIndex = 0;
    }
    currentWorkout=workouts[workoutsIndex];
  }

  ///이전 운동으로 이동
  void prevWorkout(){
    if(workoutsIndex>0){
      workoutsIndex--;
    }else{
      workoutsIndex = workouts.length-1;
    }
    currentWorkout=workouts[workoutsIndex];
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('WorkoutGuide'),
        backgroundColor: Colors.white,
      ),
      body: Column(
          spacing: 20,
          children: [
          Row(
          children: [
          Spacer(),
      Text(
        '${currentWorkout.name}', // 변경
        style: TextStyle(
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w700,
          fontSize: 30,
          color: Colors.black,
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
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
      Spacer(),
      ],
    ),

    Container(
    height: 300,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage('assets//${currentWorkout.imageName}'),
    fit: BoxFit.cover,
    ),
    ),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    IconButton(
    onPressed: () async {
    await player.stop();
    setState(() {
    prevWorkout();
    });
    },
    icon: Icon(Icons.arrow_back_ios),
    iconSize: 70,
    color: Colors.grey,
    ),
    IconButton(
    onPressed: () async {
    await player.stop();
    setState(() {
    nextWorkout();
    });
    },
    icon: Icon(Icons.arrow_forward_ios),
    iconSize: 70,
    color: Colors.grey,
    ),
    ],
    ),
    ),

    Row(
    children: [
    Spacer(),
    Container(
    width: 160,
    height: 100,
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
    border: Border.all(color: Colors.grey.shade300),
    borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
    Text(
    '운동 부위',
    style: TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w500,
    fontSize: 15,
    color: Colors.black,
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
    SizedBox(width: 23),
    Container(
    width: 160,
    height: 100,
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
    border: Border.all(color: Colors.grey.shade300),
    borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
    Text(
    '이런 사람에게 강추!',
    style: TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w500,
    fontSize: 15,
    color: Colors.black,
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
    Spacer(),
    ],
    ),

    Container(
    padding: EdgeInsets.symmetric(horizontal: 140, vertical: 20),
    decoration: BoxDecoration(
    border: Border.all(color: Colors.grey.shade300),
    borderRadius: BorderRadius.circular(16),
    ),
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

    getIconButton(),
    ],
    ),
    );
  }

  IconButton getIconButton() {
    if(player.state==PlayerState.playing){
      return IconButton(
        onPressed: () async{
          await player.stop();
          setState(() {});
        },
        icon: Icon(Icons.stop_circle, color: Colors.blue),
        iconSize: 70,
      );
    }else{
      return IconButton(
        onPressed: () async{
          await player.play(AssetSource('${currentWorkout.audioName}'));
          setState(() {});
        },
        icon: Icon(Icons.play_circle, color: Colors.blue),
        iconSize: 70,
      );
    }
  }
}

