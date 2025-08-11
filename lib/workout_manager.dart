import 'package:hnworkouttracker/workout_group.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'workout.dart';

class WorkoutManager {
  static int? currentWorkoutGroupIndex;

  static List<Workout> workouts = [
    //ref: 0x123
    Workout(name: '스쿼트', minutes: 30, imageName: 'squat.png', audioName: 'squat.mp3', kcal: 200),
    Workout(name: '윗몸 일으키기', minutes: 20, imageName: 'sit_up.png', audioName: 'sit_up.mp3', kcal: 100),
    Workout(name: '마운틴 클림버', minutes: 15, imageName: 'mountain_climber.png', audioName: 'mountain_climber.mp3', kcal: 50),
    Workout(name: '사이드 런지', minutes: 20, imageName: 'side_lunge.png', audioName: 'side_lunge.mp3', kcal: 100),
    Workout(name: '푸시업', minutes: 15, imageName: 'push_up.png', audioName: 'push_up.mp3', kcal: 100),
    Workout(name: '덩키 킥', minutes: 30, imageName: 'donkey_kick.png', audioName: 'donkey_kick.mp3', kcal: 50),
    Workout(name: '사이드 플랭크', minutes: 25, imageName: 'side_plank.png', audioName: 'side_plank.mp3', kcal: 120),
    Workout(name: '리버스 플랭크', minutes: 25, imageName: 'reverse_plank.png', audioName: 'reverse_plank.mp3', kcal: 120),
    Workout(name: '힙 브릿지', minutes: 20, imageName: 'hip_bridge.png', audioName: 'hip_bridge.mp3', kcal: 80),
    Workout(name: '어깨 스트레칭', minutes: 10, imageName: 'shoulder_stretch.png', audioName: 'shoulder_stretch.mp3', kcal: 30),
    Workout(name: '햄스트링 스트레칭', minutes: 10, imageName: 'hamstring_stretch.png', audioName: 'hamstring_stretch.mp3', kcal: 30),
  ];

  static List<WorkoutGroup> workoutGroups = [
    WorkoutGroup(
      workouts: [workouts[0], workouts[1], workouts[3], workouts[4], workouts[5]],
      groupDescription: '아침을 여는 5가지 운동프로그램',
    ),
    WorkoutGroup(
      workouts: [workouts[0], workouts[2], workouts[3], workouts[4], workouts[5], workouts[7], workouts[8]],
      groupDescription: '근력을 키우는 7가지 운동 프로그램',
    ),
    WorkoutGroup(
      workouts: [workouts[0], workouts[2], workouts[3], workouts[5], workouts[7]],
      groupDescription: '저녁을 마무리 하는 5가지 운동 프로그램',
    ),
  ];

  static Future<void> increaseTodayWorkoutMinutes(int minutes)async{
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    int todayMinutes=await getTodayWorkoutMinutes();
    await asyncPrefs.setInt('todayMinutes', todayMinutes+minutes);
  }

  static Future<int> getTodayWorkoutMinutes()async{
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    return await asyncPrefs.getInt('todayMinutes')??0;
  }

  static Future<void> increaseTodayWorkoutKcal(int kcal)async{
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    int todayKcal=await getTodayWorkoutKcal();
    await asyncPrefs.setInt('todayKcal', todayKcal+kcal);
  }

  static Future<int> getTodayWorkoutKcal()async{
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    return await asyncPrefs.getInt('todayKcal')??0;
  }

}
