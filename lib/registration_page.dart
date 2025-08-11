import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hnworkouttracker/firebase_auth_service.dart';
import 'package:hnworkouttracker/show_snackbar.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});

  //폼을 컨트롤 하는것
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  FirebaseAuthService auth = FirebaseAuthService();

  String? name;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text('회원가입')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '회원 가입',
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '정보기입',
                            style: textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 24),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: '이름',
                                  labelStyle: textTheme.headlineSmall,
                                  border: UnderlineInputBorder(),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '이름을 입력하세요';
                                  }
                                  //이거면 성공을 나타냄
                                  return null;
                                },
                                onSaved: (value) {
                                  name = value;
                                },
                              ),
                              //이메일 파트
                              SizedBox(height: 16),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: '이메일',
                                  labelStyle: textTheme.headlineSmall,
                                  hintText: 'example@example.com',
                                  border: UnderlineInputBorder(),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '이메일을 입력하세요';
                                  }
                                  if (!RegExp(
                                    r'^[^@]+@[^@]+\.[^@]+',
                                  ).hasMatch(value)) {
                                    return '유효한 이메일을 입력하세요';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  email = value;
                                },
                              ),
                              //비밀번호 파트
                              SizedBox(height: 16),
                              TextFormField(
                                //컨트롤하고 싶은것에 넣어줌 할당된 유젯을 동적으로 제어할 수 있음
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  labelText: '비밀번호',
                                  labelStyle: textTheme.headlineSmall,
                                  hintText: '비밀번호를 입력하세요',
                                  helperText: '*비밀번호는 6자 이상 입력해주세요.',
                                  helperStyle: textTheme.bodySmall?.copyWith(
                                    color: colorScheme.primary,
                                  ),
                                  border: UnderlineInputBorder(),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                                //비밀번호 별표로 보여주기
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '비밀번호를 입력하세요';
                                  }
                                  if (value.length < 6) {
                                    return '비밀번호는 6자 이상이어야 합니다';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  password = value;
                                },
                              ),
                              //비밀번호 확인 핃ㄹ드
                              TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: '비밀번호확인',
                                  labelStyle: textTheme.headlineSmall,
                                  hintText: '비밀번호를 한번더 입력하세요',
                                  border: UnderlineInputBorder(),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '비밀번호를 다시한번 입력하세요';
                                    //비밀번호의 갑을 동적으로 읽어옴
                                  } else if (value !=
                                      _passwordController.text) {
                                    return '비밀번호가 일치하지 않습니다.';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      auth
                                          .singUpWithEmail(
                                            email: email!,
                                            password: password!,
                                          )
                                          .then((v) {
                                            showSnackBar(
                                              context,
                                              '회원가입이 완료되었습니다.',
                                            );
                                          })
                                          .catchError((error) {
                                            showSnackBar(
                                              context,
                                              error.toString(),
                                            );
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
                                    '가입하기',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
