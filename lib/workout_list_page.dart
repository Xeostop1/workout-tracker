import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hnworkouttracker/workout_manager.dart';

import 'workout.dart';

class WorkoutListPage extends StatelessWidget {
  final int groupIndex;
  List<Workout> workouts;
  WorkoutListPage({super.key,required this.groupIndex}):workouts=WorkoutManager.workoutGroups[groupIndex].workouts{
    WorkoutManager.currentWorkoutGroupIndex=groupIndex;
  }


  //todo: List index를 통한 관계성 설정 rule 개선필요
  List<Widget> getWorkoutList(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    List<Widget> rowResult = [];
    for (int i = 0; i < workouts.length; i++) {
      Widget row = GestureDetector(
        onTap: (){
          context.go('/workout_home/workout_list/$groupIndex/workout_guide/$i');
        },
        child: Row(
          spacing: 20,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, bottom: 20),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/${workouts[i].imageName}'),
                ),
              ),
            ),
            Expanded(
              child: Text(
                '${i + 1}.${workouts[i].name}',
                //style: TextStyle(fontSize: 20),
                style: textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                '${workouts[i].minutes}',
                //style: TextStyle(fontSize: 20, color: Colors.blue),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      );
      rowResult.add(row);
    }

    return rowResult;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WorkoutList'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: getWorkoutList(context),
        ),
      ),
    );
  }
}
