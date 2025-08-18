// filename: profile_page.dart
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hnworkouttracker/firebase_auth_service.dart';
import 'package:hnworkouttracker/show_snackbar.dart';
import 'package:image_picker/image_picker.dart';

import 'firebase_storage_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuthService();
  final _storage = FirebaseStorageService();

  String? name;
  String? email;
  String? profileImageURL;
  final ImagePicker _picker = ImagePicker();
  bool isUploading = false;

  Future<void> _pickImage() async {
    setState(() {
      isUploading = true;
    });

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        final Uint8List raw = await pickedFile.readAsBytes();
        final Uint8List bytes = Uint8List.fromList(raw);

        String? downloadURL = await _storage.uploadProfileImage(
          bytes,
          pickedFile.path,
          _auth.user?.uid,
        );

        await _auth.updatePhotoUrl(downloadURL);

        if (!mounted) return;
        setState(() {
          // 업로드 성공 시 네트워크 URL을 우선 사용
          profileImageURL = downloadURL ?? pickedFile.path;
        });
      }
    } catch (e) {
      if (mounted) showSnackBar(context, e.toString());
    } finally {
      if (mounted) {
        setState(() {
          isUploading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    name = _auth.user?.displayName;
    email = _auth.user?.email;
    profileImageURL = _auth.user?.photoURL;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    // 현재 profileImageURL이 http면 네트워크, 파일 경로면 로컬, 없으면 에셋
    late final ImageProvider avatarProvider;
    if (profileImageURL != null && profileImageURL!.isNotEmpty) {
      if (profileImageURL!.startsWith('http')) {
        avatarProvider = NetworkImage(profileImageURL!);
      } else {
        avatarProvider = FileImage(File(profileImageURL!));
      }
    } else {
      avatarProvider = const AssetImage('assets/me.png');
    }

    return Scaffold(
      appBar: AppBar(title: const Text('프로필 설정')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Flexible(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.primary,
                          width: 1.0,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: avatarProvider,
                        onBackgroundImageError: (_, __) {
                          if (!mounted) return;
                          setState(() {
                            profileImageURL = null;
                          });
                        },
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    // 카메라 아이콘 탭 -> 이미지 선택
                    Positioned(
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: isUploading
                            ? const CircularProgressIndicator()
                            : Icon(
                                Icons.camera_alt,
                                size:
                                    (textTheme.headlineMedium?.fontSize ?? 28),
                                color: colorScheme.onPrimary,
                              ),
                      ),
                    ),
                    // 닫기(초기화) 버튼
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceDim,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.close,
                              color: colorScheme.onPrimary,
                            ),
                            onPressed: () async {
                              if (!mounted) return;
                              try {
                                await _auth.deletePhotoUrl();
                                await _storage.deleteProfileImage(
                                  _auth.user?.uid,
                                );
                              } catch (e) {
                                if (mounted) {
                                  showSnackBar(context, e.toString());
                                }
                              }
                              if (!mounted) return;
                              setState(() {
                                profileImageURL = null;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 이름
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: textTheme.titleLarge,
                  hintText: 'Enter your name',
                  border: const UnderlineInputBorder(),
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
                onSaved: (value) => name = value,
              ),

              // 이메일(읽기 전용)
              TextFormField(
                enabled: false,
                initialValue: email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: textTheme.titleLarge,
                  border: const UnderlineInputBorder(),
                ),
              ),

              // 이메일 인증 안내
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
                    onPressed: () {
                      // TODO: 인증 메일 전송 로직 연결
                    },
                    child: Text(
                      'Send Email',
                      style: textTheme.titleSmall?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 수정 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      _auth
                          .updateName(name)
                          .then((_) {
                            showSnackBar(context, '수정 되었습니다.');
                          })
                          .catchError((e) {
                            showSnackBar(context, e.toString());
                          });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
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

              // 로그아웃 / 회원탈퇴
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // TODO: 로그아웃 연결
                    },
                    child: Text(
                      '로그아웃',
                      style: TextStyle(color: colorScheme.primary),
                    ),
                  ),
                  const Text('|'),
                  TextButton(
                    onPressed: () {
                      // TODO: 회원탈퇴 연결
                    },
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
