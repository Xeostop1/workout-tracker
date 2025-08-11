import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FramePage extends StatelessWidget {
  final StatefulNavigationShell child;
  const FramePage({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data:Theme.of(context).copyWith(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.black,
          )
      ),
      child: Scaffold(
        body: child,
        bottomNavigationBar: NavigationBar(
          selectedIndex: child.currentIndex,
          destinations: [
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.settings),
              icon: Icon(Icons.settings_outlined),
              label: 'Setttings',
            ),
          ],
          onDestinationSelected:(index){
            final isSameTap=index==child.currentIndex;
            child.goBranch(
              index,
              initialLocation: isSameTap,
            );
          } ,
        ),

      ),
    );
  }
}
