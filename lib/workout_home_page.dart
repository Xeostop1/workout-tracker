import 'package:flutter/material.dart';

import 'dashboard_card.dart';

class WorkoutHomePage extends StatefulWidget {
  const WorkoutHomePage({super.key});

  @override
  State<WorkoutHomePage> createState() => _WorkoutHomePageState();
}

class _WorkoutHomePageState extends State<WorkoutHomePage> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme= Theme.of(context).textTheme;
    ColorScheme colorScheme= Theme.of(context).colorScheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/runner_icon.png',
                      width: textTheme.headlineSmall?.fontSize,
                    ),
                    Image.asset(
                      'assets/notifications_icon.png',
                      width: textTheme.titleLarge?.fontSize,),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:"반가워요 ",
                                style: textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                )
                              ),
                              TextSpan(
                                text:"건강을 위한 한 걸음\n",
                                style: textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: colorScheme.primary
                                )
                              ),
                              TextSpan(
                                text:"오늘도 힘차게 운동을 해볼까요? \n",
                                style: textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    height:2
                                )
                              ),
                              TextSpan(
                                text:"> 내 프로필",
                                style: textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w300,
                                  color: colorScheme.surfaceDim,
                                )
                              ),
                            ]
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Image.asset('assets/half_circle.png', width: 132,),
                        Positioned(
                          left: 15,
                          bottom: 19,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.blue,
                                width: 1
                              ),
                              image: const DecorationImage(
                                image: AssetImage('assets/me.png'),
                                fit: BoxFit.cover,
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Expanded(child: DashboardCard()),
                      Expanded(child: DashboardCard()),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 170,
                          child: DashboardCard(),
                        ),
                        SizedBox(
                          width: 170,
                          child: DashboardCard(),
                        ),
                        SizedBox(
                          width: 170,
                          child: DashboardCard(),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: DashboardCard())
              ],
            )
        ),
      ),
    );
  }
}

