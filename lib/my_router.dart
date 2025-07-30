//filename:my_router.dart
import 'package:go_router/go_router.dart';
import 'package:hnworkouttracker/workout_guide_page.dart';
import 'package:hnworkouttracker/workout_home_page.dart';
import 'Models/workout_list.dart';
import 'landing_page.dart';


// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LandingPage(),
    ),
    GoRoute(
      path: '/workout_home',
      builder: (context, state) => WorkoutHomePage(),
      routes: [
        GoRoute(
          path: 'workout_list:/group_index',
          builder: (context, state) {
            String? groupIndexString=state.pathParameters['group_index'];
            final groupIndex=int.parse(groupIndexString!);
            return  WorkoutListPage(groupIndex:groupIndex);
          },
          routes:[
            GoRoute(
              path: 'workout_guide/:workouts_index',
              builder: (context, state) {
                String? workoutsIndexString=state.pathParameters['workouts_index'];
                final workoutsIndex=int.parse(workoutsIndexString!);
                //객체로 넘겨주면서 종속성을 분리해서 인자로 넘겨줌 라우터 자체로 넘겨주지 않고
                String? groupIndexString=state.pathParameters['group_index'];
                final groupIndex=int.parse(groupIndexString!);

                return WorkoutGuidePage(workoutsIndex: workoutsIndex, groupIndex:groupIndex);
              },
            ),
          ]
        ),
      ]
    ),

  ],
);
