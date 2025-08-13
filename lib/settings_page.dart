//fielname:settings_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hnworkouttracker/show_snackbar.dart';
import 'firebase_auth_service.dart';
import 'item_card.dart';

class SettingsPage extends StatelessWidget {
  static String id = 'setings_page';
  final _auth = FirebaseAuthService();

  Widget _arrow() {
    return Icon(Icons.arrow_forward_ios, size: 20.0);
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      backgroundColor: Colors.grey.shade50,
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'App Settings',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ItemCard(
                      title: _auth.isLoggedIn() ? '로그아웃' : '로그인',
                      color: (brightness == Brightness.light)
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: null,
                      callback: () {
                        if (_auth.isLoggedIn()) {
                          _auth
                              .signOut()
                              .then((_) {
                                showSnackBar(context, '로그아웃되었습니다.');
                              })
                              .catchError((error) {
                                showSnackBar(context, error.toString());
                              });
                        } else {
                          context.go('/settings/login');
                        }
                      },
                    ),
                    ItemCard(
                      title: '알림',
                      color: (brightness == Brightness.light)
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: _arrow(),
                      callback: () {},
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Others',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ItemCard(
                      title: '공지사항',
                      color: (brightness == Brightness.light)
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: _arrow(),
                      callback: () {
                        print('Tap Settings Item 03');
                      },
                    ),
                    ItemCard(
                      title: '고객센터/도움말',
                      color: (brightness == Brightness.light)
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: _arrow(),
                      callback: () {
                        print('Tap Settings Item 04');
                      },
                    ),
                    ItemCard(
                      title: '테마',
                      color: (brightness == Brightness.light)
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: null,
                      callback: () {
                        print('Tap Settings Item 05');
                      },
                    ),
                    ItemCard(
                      title: '화면',
                      color: (brightness == Brightness.light)
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: null,
                      callback: () {
                        print('Tap Settings Item 06');
                      },
                    ),
                    ItemCard(
                      title: '검색어 관리',
                      color: (brightness == Brightness.light)
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: null,
                      callback: () {
                        print('Tap Settings Item 07');
                      },
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Info',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ItemCard(
                      title: '퀵 액션 관리',
                      color: (brightness == Brightness.light)
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: null,
                      callback: () {
                        print('Tap Settings Item 08');
                      },
                    ),
                    ItemCard(
                      title: '기타',
                      color: (brightness == Brightness.light)
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      callback: () {
                        print('Tap Settings Item 09');
                      },
                    ),
                    ItemCard(
                      title: 'version',
                      color: (brightness == Brightness.light)
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: Center(
                        child: Text(
                          '1.0.0',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      callback: () {},
                    ),
                    SizedBox(height: 200),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
