//filename:workout_home_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'dashboard_card.dart';

class WorkoutHomePage extends StatefulWidget {
  const WorkoutHomePage({super.key});

  @override
  State<WorkoutHomePage> createState() => _WorkoutHomePageState();
}

class _WorkoutHomePageState extends State<WorkoutHomePage> {
  final f1 = NumberFormat.decimalPattern('ko_KR');
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/runner_icon.png', width: 24),
                  Image.asset('assets/notifications_icon.png', width: 19),
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
                              text: '반가워요.',
                              style: textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: '건강을 위한 한 걸음\n',
                              style: textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: colorScheme.primary,
                              ),
                            ),
                            TextSpan(
                              text: '오늘도 힘차게 운동을 해볼까요?\n',
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
              Expanded(
                flex: 3,
                child: Row(
                  //C line
                  children: [
                    Expanded(
                      child: DashboardCard(
                        icon: Icon(
                          Icons.push_pin_outlined,
                          size: textTheme.titleMedium?.fontSize,
                          color: colorScheme.outlineVariant,
                        ),
                        title: Text(
                          'Today',
                          style: textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: colorScheme.outlineVariant,
                          ),
                        ),
                        margin:EdgeInsets.only(right: 4,bottom:4),
                        info: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: 15,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: CircularProgressIndicator(
                                  value: 450 / 500,
                                  strokeWidth: 7,
                                  backgroundColor: Colors.grey[300],
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                        text: '450분',
                                        style: textTheme.titleLarge?.copyWith(
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
                                        text: '소모 칼로리\n',
                                        style: textTheme.titleSmall?.copyWith(color: colorScheme.outline),
                                      ),
                                      TextSpan(
                                        text: '${f1.format(2400)} kcal',
                                        style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600, color: colorScheme.primary),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
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
                        margin:EdgeInsets.only(left: 4, bottom:4),
                        info: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: 15,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: CircularProgressIndicator(
                                  value: 450 / 500,
                                  strokeWidth: 7,
                                  backgroundColor: Colors.grey[300],
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                        style: textTheme.titleLarge?.copyWith(
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
                          ],
                        ),
                      ),
                    ),
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
                        child: DashboardCard(
                          customOnTap: () {
                            context.go('/workout_home/workout_list');
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
                          margin:EdgeInsets.only(right: 4, top:4, bottom:4),
                          info: Row(
                            children: [
                              Expanded(child: Image.asset('assets/group1.png')),
                              Expanded(
                                child: Text(
                                  '아침을 여는 5가지 운동',
                                  style: textTheme.titleSmall?.copyWith(color: colorScheme.shadow),
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: Color(0xffFCFFE3),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Color(0xFFFCFFE3), Colors.white],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 170,
                        child: DashboardCard(
                          customOnTap: () {
                            context.go('/workout_home/workout_list');
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
                          margin:EdgeInsets.only(left: 4, top:4, bottom:4),
                          info: Row(
                            children: [
                              Expanded(child: Image.asset('assets/group2.png')),
                              Expanded(
                                child: Text(
                                  '근력을 키우는 7가지 운동',
                                  style: textTheme.titleSmall?.copyWith(color: colorScheme.shadow),
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: Color(0xffE3F7FF),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Color(0xffE3F7FF), Colors.white],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 170,
                        child: DashboardCard(
                          customOnTap: () {
                            context.go('/workout_home/workout_list');
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
                          margin:EdgeInsets.only(left: 4, top:4, bottom:4),
                          info: Row(
                            children: [
                              Expanded(child: Image.asset('assets/group3.png')),
                              Expanded(
                                child: Text(
                                  '하루를 마무리하는 4가지 운동',
                                  style: textTheme.titleSmall?.copyWith(color: colorScheme.shadow),
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: Color(0xffFFE3ED),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Color(0xffFFE3ED), Colors.white],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: DashboardCard(
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
                  margin:EdgeInsets.only(top:4),
                  info: SizedBox.expand(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/continue.png'),
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width:120),
                          Expanded(
                            child: Text(
                              '당신의 몸은 해 낼 수 있다. 당신의 마음만 설득하면 된다.',
                              style: textTheme.titleMedium?.copyWith(color: colorScheme.outline,fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

