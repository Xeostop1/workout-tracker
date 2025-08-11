import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hnworkouttracker/widgets/animated_icon_widget.dart';
import 'package:hnworkouttracker/workout_manager.dart';

import 'constants.dart';
import 'dashboard_card.dart';

class WorkoutHomePage extends StatefulWidget {
  const WorkoutHomePage({super.key});

  @override
  State<WorkoutHomePage> createState() => _WorkoutHomePageState();
}

class _WorkoutHomePageState extends State<WorkoutHomePage> {
  late Future<int> todayMinutesFuture;
  late Future<({int todayKcal, int todayMinutes})> todayStatisticsFuture;

  Future<({int todayKcal, int todayMinutes})> getTodayStatistics() async{
    int todayMinutes=await WorkoutManager.getTodayWorkoutMinutes();
    int todayKcal=await WorkoutManager.getTodayWorkoutKcal();

    //return [todayKcal, todayMinutes];
    //return {'todayMinutes':todayMinutes, 'todayKcal':todayKcal};
    // return TwoData(
    //   todayKcal:todayKcal,
    //   todayMinutes:todayMinutes,
    // );

    return (todayKcal:todayKcal,todayMinutes:todayMinutes);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todayMinutesFuture=WorkoutManager.getTodayWorkoutMinutes();
    todayStatisticsFuture=getTodayStatistics();
  }

  @override
  void didUpdateWidget(covariant WorkoutHomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    todayMinutesFuture=WorkoutManager.getTodayWorkoutMinutes();
    todayStatisticsFuture=getTodayStatistics();
  }
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //A
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/runner_icon.png',
                  width: textTheme.headlineSmall?.fontSize,
                ),
                Image.asset('assets/notifications_icon.png', width: textTheme.titleLarge?.fontSize),
              ],
            ),
            //B
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '반가워요',
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: ' 건강을 위한 한 걸음\n',
                            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700, color: colorScheme.primary),
                          ),
                          TextSpan(
                            text: '오늘도 힘차게 운동을 해볼까요? \n',
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w400,
                              height: 2,
                            ),
                          ),
                          TextSpan(
                            text: '> 내 프로필',
                            style: textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w300,
                              color: colorScheme.surfaceDim,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Image.asset('assets/half_circle.png', width: 132),
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
                            width: 1,
                          ),
                          image: const DecorationImage(
                            image: AssetImage('assets/me.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            //C
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    //1번 카드
                    child: DashboardCard(
                      icon: AnimatedIconWidget(
                        icon: Icons.push_pin_outlined,
                        size: textTheme.titleMedium?.fontSize ?? 16,
                        color: colorScheme.outlineVariant,
                      ),
                      title: Text(
                        'Today',
                        style: textTheme.titleSmall?.copyWith(
                          color: colorScheme.outlineVariant,
                        ),
                      ),
                      info: FutureBuilder<({int todayMinutes,int todayKcal})>(
                          future: todayStatisticsFuture,
                          builder: (_, snapshot) {
                            if(snapshot.connectionState== ConnectionState.waiting){
                              return Center(child: CircularProgressIndicator());
                            }
                            if(snapshot.hasError){
                              return Center(
                                child: Text('${snapshot.error}'),
                              );
                            }

                            final int todayWorkoutMinutes=snapshot.data?.todayMinutes??0;
                            final int todayWorkoutKcal=snapshot.data?.todayKcal??0;

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text.rich(
                                  textAlign: TextAlign.center,
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '운동시간\n',
                                        style: textTheme.titleSmall?.copyWith(color: colorScheme.outline),
                                      ),
                                      TextSpan(
                                        text: '${todayWorkoutMinutes}분',
                                        style: textTheme.headlineSmall?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: colorScheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text.rich(
                                  textAlign: TextAlign.center,
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        // text: '${CustomLocale.consumedKcal}\n',
                                        style: textTheme.titleSmall?.copyWith(color: colorScheme.outline),
                                      ),
                                      TextSpan(
                                        text: '$todayWorkoutKcal',
                                        style: textTheme.titleLarge?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: colorScheme.primary,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' kcal',
                                        style: textTheme.titleLarge?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                      ),
                    ),
                  ),
                  Expanded(
                    //2번 카드
                    child: DashboardCard(
                      icon: Icon(
                        Icons.calendar_month_outlined,
                        size: textTheme.titleMedium?.fontSize,
                        color: colorScheme.outlineVariant,
                      ),
                      title: Text(
                        'Monthly',
                        style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: colorScheme.outlineVariant,
                        ),
                      ),
                      info: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '운동시간\n',
                                  style: textTheme.titleSmall?.copyWith(
                                    color: colorScheme.outline,
                                  ),
                                ),
                                TextSpan(
                                  text: '403시간',
                                  style: textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '지난달 대비 \n',
                                  style: textTheme.titleMedium?.copyWith(color: colorScheme.shadow),
                                ),
                                TextSpan(
                                  text: '10시간 ',
                                  style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: colorScheme.primary),
                                ),
                                TextSpan(
                                  text: '더 했어요 ',
                                  style: textTheme.titleMedium?.copyWith(color: colorScheme.shadow),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //D
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      //3번 카드
                      width: 170,
                      child: DashboardCard(
                          customOnTap: (){
                            context.go('/workout_home/workout_list/0');
                          },
                          icon: Icon(
                            Icons.run_circle_outlined,
                            size: textTheme.titleMedium?.fontSize,
                            color: colorScheme.shadow,
                          ),
                          title: Text(
                            '그룹1',
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: colorScheme.shadow,
                            ),
                          ),
                          info: Text(
                            '${WorkoutManager.workoutGroups[0].groupDescription}',
                            style: textTheme.titleSmall?.copyWith(color: colorScheme.shadow),
                          ),
                          backgroundColor: CustomColors.cardBg1
                      ),
                    ),
                    SizedBox(
                      //4번 카드
                      width: 170,
                      child: DashboardCard(
                          customOnTap: (){
                            context.go('/workout_home/workout_list/1');
                          },
                          icon: Icon(
                            Icons.fitness_center_outlined,
                            size: textTheme.titleMedium?.fontSize,
                            color: colorScheme.shadow,
                          ),
                          title: Text(
                            '그룹2',
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: colorScheme.shadow,
                            ),
                          ),
                          info: Text(
                            '${WorkoutManager.workoutGroups[1].groupDescription}',
                            style: textTheme.titleSmall?.copyWith(color: colorScheme.shadow),
                          ),
                          backgroundColor: CustomColors.cardBg2
                      ),
                    ),
                    SizedBox(
                      //5번 카드
                      width: 170,
                      child: DashboardCard(
                          customOnTap: (){
                            context.go('/workout_home/workout_list/2');
                          },
                          icon: Icon(
                            Icons.rowing_outlined,
                            size: textTheme.titleMedium?.fontSize,
                            color: colorScheme.shadow,
                          ),
                          title: Text(
                            '그룹3',
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: colorScheme.shadow,
                            ),
                          ),
                          info: Text(
                            '${WorkoutManager.workoutGroups[2].groupDescription}',
                            style: textTheme.titleSmall?.copyWith(color: colorScheme.shadow),
                          ),
                          backgroundColor: CustomColors.cardBg3
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //E
            Expanded(
              flex: 2, //6번 카드
              child: DashboardCard(
                customOnTap: (){
                  if(WorkoutManager.currentWorkoutGroupIndex ==null) return;
                  context.go('/workout_home/workout_list/${WorkoutManager.currentWorkoutGroupIndex}');
                },
                icon: Icon(
                  Icons.autorenew_outlined,
                  size: textTheme.headlineSmall?.fontSize,
                  color: colorScheme.primary,
                ),
                title: Text(
                  '운동이어서하기',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: colorScheme.primary,
                  ),
                ),
                info: Text(
                  '당신의 몸은 해 낼 수 있다. 당신의 마음만 설득하면 된다.',
                  style: textTheme.titleMedium?.copyWith(color: colorScheme.outline),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
