import 'package:flutter/material.dart';

import 'constants.dart';
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
                      //1번
                      Expanded(
                          child: DashboardCard(
                            icon:Icon(
                              Icons.push_pin_outlined,
                              size: textTheme.titleMedium?.fontSize,
                              color: colorScheme.outlineVariant,
                            ),
                            title:Text(
                              "Today",
                              style: textTheme.titleSmall?.copyWith(color: colorScheme.outlineVariant),
                            ),
                            info:
                            Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text.rich(
                                    textAlign:TextAlign.center,
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                            text: "운동시간\n",
                                            style: textTheme.titleSmall?.copyWith(
                                              color: colorScheme.outline,
                                            )
                                        ),
                                        TextSpan(
                                            text: "450분",
                                            style: textTheme.titleLarge?.copyWith(
                                                color: colorScheme.primary,
                                                fontWeight: FontWeight.w600)
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text.rich(
                                      textAlign:TextAlign.center,
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                              text: "소모칼로리\n",
                                              style: textTheme.titleSmall?.copyWith(color: colorScheme.outline)
                                          ),
                                          TextSpan(
                                              text: "2,400",
                                              style: textTheme.titleLarge?.copyWith(
                                                  color: colorScheme.primary,
                                                  fontWeight: FontWeight.w600)
                                          ),
                                          TextSpan(
                                              text: "kcal",
                                              style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)
                                          )
                                        ],
                                      )
                                  ),
                                ],
                              ),
                            ),
                      ),
                      //2번
                      Expanded(child: DashboardCard(
                        icon:Icon(
                          Icons.calendar_month_outlined,
                          size: textTheme.titleMedium?.fontSize,
                          color: colorScheme.outlineVariant,
                        ),
                        title:Text(
                          "Monthly",
                          style: textTheme.titleSmall?.copyWith(
                              color: colorScheme.outlineVariant),
                        ),
                        info:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text.rich(
                              textAlign:TextAlign.center,
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: "운동시간\n",
                                      style: textTheme.titleSmall?.copyWith(
                                        color: colorScheme.outline,
                                      )
                                  ),
                                  TextSpan(
                                      text: "450분",
                                      style: textTheme.titleLarge?.copyWith(
                                          color: colorScheme.primary,
                                          fontWeight: FontWeight.w600)
                                  ),
                                ],
                              ),
                            ),
                            Text.rich(
                                textAlign:TextAlign.center,
                                TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "소모칼로리\n",
                                        style: textTheme.titleSmall?.copyWith(color: colorScheme.outline)
                                    ),
                                    TextSpan(
                                        text: "2,400",
                                        style: textTheme.titleLarge?.copyWith(
                                            color: colorScheme.primary,
                                            fontWeight: FontWeight.w600)
                                    ),
                                    TextSpan(
                                        text: "kcal",
                                        style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)
                                    )
                                  ],
                                )
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
                            icon:Icon(
                              Icons.run_circle_outlined,
                              size: textTheme.titleMedium?.fontSize,
                              color: colorScheme.outlineVariant,
                            ),
                            title:Text(
                              "그룹1",
                              style: textTheme.titleSmall?.copyWith(
                                color: colorScheme.outlineVariant,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            info: Row(
                              children: [
                                Expanded(child: Image.asset("assets/group1.png")),
                                Expanded(child: Text("아침을 여는 \n5가지 운동 "))
                              ],
                            ),
                            backgroundColor: CustomColors.cardBg1
                          ),
                        ),
                        SizedBox(
                          width: 170,
                          child: DashboardCard(
                            icon:Icon(
                              Icons.fitness_center_outlined,
                              size: textTheme.titleMedium?.fontSize,
                              color: colorScheme.outlineVariant,
                            ),
                            title:Text(
                              "그룹2",
                              style: textTheme.titleSmall?.copyWith(
                                color: colorScheme.outlineVariant,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            info: Row(
                              children: [
                                Expanded(child: Image.asset("assets/group2.png")),
                                Expanded(child: Text("근력을 키우 \n는 7가지 운동 "))
                              ],
                            ),
                            backgroundColor: CustomColors.cardBg2,
                          ),
                        ),
                        SizedBox(
                          width: 170,
                          child: DashboardCard(
                            icon:Icon(
                              Icons.rowing_outlined,
                              size: textTheme.titleMedium?.fontSize,
                              color: colorScheme.outlineVariant,
                            ),
                            title:Text(
                              "그룹3",
                              style: textTheme.titleSmall?.copyWith(
                                color: colorScheme.outlineVariant,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            info: Row(
                              children: [
                                Expanded(child: Image.asset("assets/group3.png")),
                                Expanded(child: Text("하루를 마무\n리하는 4가지 운동 "))
                              ],
                            ),
                            backgroundColor: CustomColors.cardBg3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: DashboardCard(
                    icon:Icon(
                      Icons.autorenew_outlined,
                      size: textTheme.titleLarge?.fontSize,
                      color: colorScheme.primary,
                    ),
                    title:Text(
                      "운동이어서 하기",
                      style: textTheme.titleSmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: textTheme.titleLarge?.fontSize,
                      ),
                    ),
                    //info
                    info: SizedBox.expand(
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image:AssetImage('assets/continue.png'),
                              fit:BoxFit.fitWidth,
                              alignment: Alignment.bottomCenter
                            ),
                          ),
                        child: Row(
                        children: [
                          SizedBox(width: 120,),
                         Expanded(
                             child: Text(
                               '당신의 몸은 해 낼 수 있다. 당신의 마음만 설득하면 된다.',
                               style: textTheme.titleMedium?.copyWith(color: colorScheme.outline,fontWeight: FontWeight.w600)
                             ),
                         ),
                        ],
                        )
                      ),
                    )
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}

