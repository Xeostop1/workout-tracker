import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hnworkouttracker/animation_pracice_widget.dart';
import 'package:hnworkouttracker/landing_page.dart';
import 'package:hnworkouttracker/registration_page.dart';
import 'package:hnworkouttracker/workout_home_page.dart';

import 'frame_page.dart';
import 'login_page.dart';
import 'settings_page.dart';
import 'workout_guide_page.dart';
import 'workout_list_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _homeTabNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'homeTab');
final GlobalKey<NavigatorState> _settingsTabNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'settingsTab');

// GoRouter configuration
final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LandingPage(),

      // builder: (context, state) => AnimationPraciceWidget(),
    ),
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state, navigationShell) {
        return FramePage(child: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeTabNavigatorKey,
          routes: [
            GoRoute(
              path: '/workout_home',
              builder: (context, state) => WorkoutHomePage(),
              routes: [
                //workout_home/workout_list/1/workout_guide/3
                GoRoute(
                  path: 'workout_list/:group_index',
                  builder: (context, state) {
                    String? groupIndexString =
                        state.pathParameters['group_index'];
                    final int groupIndex = int.parse(groupIndexString!);
                    return WorkoutListPage(groupIndex: groupIndex);
                  },
                  routes: [
                    GoRoute(
                      path: 'workout_guide/:workout_index',
                      builder: (context, state) {
                        String? workoutIndexString =
                            state.pathParameters['workout_index'];
                        final int workoutIndex = int.parse(workoutIndexString!);

                        String? groupIndexString =
                            state.pathParameters['group_index'];
                        final int groupIndex = int.parse(groupIndexString!);

                        return WorkoutGuidePage(
                          workoutIndex: workoutIndex,
                          groupIndex: groupIndex,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _settingsTabNavigatorKey,
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) {
                return SettingsPage();
              },
              routes: [
                GoRoute(
                  path: 'login',
                  builder: (context, state) {
                    return LoginPage();
                  },
                  //하부라우트를 지정할 수 있음
                  routes: [
                    GoRoute(
                      path: 'registration',
                      builder: (context, state) {
                        return RegistrationPage();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
