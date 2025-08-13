//filename:profile_page.dart
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? email;
  String? profileImageURL;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text('프로필 설정')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: colorScheme.primary, width: 1.0),
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: profileImageURL != null
                      ? NetworkImage(profileImageURL!)
                      : const AssetImage('assets/me.png'),
                  onBackgroundImageError: (_, __) {
                    setState(() {
                      profileImageURL = null;
                    });
                  },
                ),
              ),
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: textTheme.titleLarge,
                  hintText: 'Enter your name',
                  border: UnderlineInputBorder(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.primary),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '이름을 입력하세요';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value;
                },
              ),
              TextFormField(
                enabled: false,
                initialValue: email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: textTheme.titleLarge,
                  border: UnderlineInputBorder(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Have you verified your email yet?',
                    style: textTheme.titleSmall?.copyWith(
                      color: colorScheme.shadow,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Send Email',
                      style: textTheme.titleSmall?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              // 수정 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    '수정',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
              // 로그아웃/회원탈퇴
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      '로그아웃',
                      style: TextStyle(color: colorScheme.primary),
                    ),
                  ),
                  Text('|'),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      '회원탈퇴',
                      style: TextStyle(color: colorScheme.primary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
