

import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final Icon icon;
  final Text title;
  final Widget info;
  final Color? backgroundColor;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.info,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    //자바스크립트처럼 앞에 써주는것 
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: colorScheme.surfaceContainerHigh,
          ),
        color: backgroundColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              icon, //컨스트럭처로 받은 프로퍼티
              SizedBox(width: 5,),
              title,
            ],
          ),
          info,
        ],
      ),
    );
  }
}




