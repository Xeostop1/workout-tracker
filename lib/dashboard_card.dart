

import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final Icon icon;
  final Text title;
  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    //자바스크립트처럼 앞에 써주는것 
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade300
      ),
      child: Column(

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              icon,
              // Icon(
              //   Icons.push_pin_outlined,
              //   size: textTheme.titleMedium?.fontSize,
              //   color: colorScheme.outlineVariant,
              // ),
              SizedBox(width: 5,),
              title,
              // Text(
              //   "Today",
              //   style: textTheme.titleSmall?.copyWith(color: colorScheme.outlineVariant),
              //
              // ),
            ],
          ),
          Expanded(

              child: Column(
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
        ],
      ),
    );
  }
}