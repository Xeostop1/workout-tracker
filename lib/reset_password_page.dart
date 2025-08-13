//filename:reset_password_page.dart
import 'package:flutter/material.dart';
import 'package:hnworkouttracker/show_snackbar.dart';
import 'firebase_auth_service.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({super.key});
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuthService();

  String? email;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/runner_icon.png',
                      width: 42,
                      color: colorScheme.primary,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '비밀번호 재설정',
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '이메일 보내기',
                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: '이메일',
                    hintText: 'example@example.com',
                    border: UnderlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '이메일을 입력하세요';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return '유효한 이메일을 입력하세요';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    email = value;
                  },
                ),
                SizedBox(height: 24),
                Text(
                  '* 이메일을 통해 비밀번호 재설정 링크를 확인하세요.',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _auth
                            .resetPassword(email: email!)
                            .then((_) {
                              showSnackBar(context, '비밀번호 재설정 이메일이 전송되었습니다.');
                            })
                            .catchError((error) {
                              showSnackBar(context, error.toString());
                            });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      '비밀번호 재설정 이메일 보내기',
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
