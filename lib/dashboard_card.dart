//filename:dashboard_card.dart
import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final Widget icon;
  final Text title;
  final Widget info;
  final Color? backgroundColor;
  final LinearGradient? gradient;
  final EdgeInsets margin;
  final Function ()? customOnTap;   //보이드 콜백타입

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.info,
    this.backgroundColor,
    this.gradient,
    this.margin= const EdgeInsets.all(8),
    this.customOnTap,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: customOnTap,
      child: Container(
      margin:margin,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: colorScheme.surfaceContainerHigh,
          ),
        color: backgroundColor,
        gradient: gradient,
        ),
      child: Column(
        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            icon,
            SizedBox(width: 5),
            title,
          ],
          ),
          Expanded(
            child: Center(
             child: info,
            )
          ),
        ],
      ),
      ),
    );
  }
}

