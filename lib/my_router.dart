import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:hnworkouttracker/landing_page.dart';
import 'package:hnworkouttracker/login_page.dart';
import 'package:hnworkouttracker/registration_page.dart';
import 'package:hnworkouttracker/reset_password_page.dart';
import 'package:hnworkouttracker/profile_page.dart';
import 'package:hnworkouttracker/settings_page.dart';
import 'package:hnworkouttracker/workout_home_page.dart';
import 'package:hnworkouttracker/workout_list_page.dart';
import 'package:hnworkouttracker/workout_guide_page.dart';
import 'package:hnworkouttracker/frame_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _homeTabNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'homeTab');
final GlobalKey<NavigatorState> _settingsTabNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'settingsTab');

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  redirect: (context, state) {
    final user = FirebaseAuth.instance.currentUser;

    // 로그인 안 된 유저가 접근하면 로그인 페이지로 보냄
    if (user == null &&
        state.uri.path != '/settings/login' &&
        state.uri.path != '/settings/login/registration' &&
        state.uri.path != '/settings/login/reset_password' &&
        state.uri.path != '/') {
      return '/settings/login';
    }

    // 로그인한 유저가 로그인 페이지에 접근하려 할 경우 /settings로 리디렉션
    if (user != null &&
        (state.uri.path == '/settings/login' ||
            state.uri.path == '/settings/login/registration')) {
      return '/settings';
    }

    return null; // 리디렉션 없음
  },
  routes: [
    GoRoute(path: '/', builder: (context, state) => LandingPage()),
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state, navigationShell) =>
          FramePage(child: navigationShell),
      branches: [
        // 🏋️ workout 홈 탭
        StatefulShellBranch(
          navigatorKey: _homeTabNavigatorKey,
          routes: [
            GoRoute(
              path: '/workout_home',
              builder: (context, state) => WorkoutHomePage(),
              routes: [
                GoRoute(
                  path: 'workout_list/:group_index',
                  builder: (context, state) {
                    final groupIndex = int.parse(
                      state.pathParameters['group_index']!,
                    );
                    return WorkoutListPage(groupIndex: groupIndex);
                  },
                  routes: [
                    GoRoute(
                      path: 'workout_guide/:workout_index',
                      builder: (context, state) {
                        final groupIndex = int.parse(
                          state.pathParameters['group_index']!,
                        );
                        final workoutIndex = int.parse(
                          state.pathParameters['workout_index']!,
                        );
                        return WorkoutGuidePage(
                          groupIndex: groupIndex,
                          workoutIndex: workoutIndex,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        // ⚙️ settings 탭
        StatefulShellBranch(
          navigatorKey: _settingsTabNavigatorKey,
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => SettingsPage(),
              routes: [
                GoRoute(
                  path: 'profile',
                  builder: (context, state) => ProfilePage(),
                ),
                GoRoute(
                  path: 'login',
                  builder: (context, state) => LoginPage(),
                  routes: [
                    GoRoute(
                      path: 'registration',
                      builder: (context, state) => RegistrationPage(),
                    ),
                    GoRoute(
                      path: 'reset_password',
                      builder: (context, state) => ResetPasswordPage(),
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
