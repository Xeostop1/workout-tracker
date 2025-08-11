import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Setting Menu',style: Theme.of(context).textTheme.bodyLarge,),
            OutlinedButton(
              onPressed: () {
                context.go('/settings/login');
              },
              child: Text('go to LoginPage'),
            ),
          ],
        ),
      ),
    );
  }
}
