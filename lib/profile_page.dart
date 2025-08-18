// filename: profile_page.dart
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart'; // DEBUG: debugPrint 사용
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
    setState(() => isUploading = true);

    try {
      debugPrint('DEBUG[ProfilePage]: 이미지 선택 시작');
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile == null) {
        debugPrint(
          'DEBUG[ProfilePage]: 사용자가 이미지를 선택하지 않음 (pickedFile == null)',
        );
        if (mounted) showSnackBar(context, '이미지가 선택되지 않았어요.');
        return;
      }

      final uid = _auth.user?.uid;
      debugPrint('DEBUG[ProfilePage]: 선택된 파일 경로 = ${pickedFile.path}');
      debugPrint('DEBUG[ProfilePage]: 현재 로그인 uid = $uid');

      // 파일 바이트 확보
      final Uint8List raw = await pickedFile.readAsBytes();
      final Uint8List bytes = Uint8List.fromList(raw);
      debugPrint('DEBUG[ProfilePage]: 바이트 길이 = ${bytes.length}');

      // 업로드 시도
      debugPrint('DEBUG[ProfilePage]: 업로드 시작...');
      final String? downloadURL = await _storage.uploadProfileImage(
        bytes,
        pickedFile.path,
        uid,
      );
      debugPrint('DEBUG[ProfilePage]: 업로드 완료. downloadURL = $downloadURL');

      // 사용자 photoURL 업데이트
      if (downloadURL != null && downloadURL.isNotEmpty) {
        await _auth.updatePhotoUrl(downloadURL);
        debugPrint('DEBUG[ProfilePage]: Auth photoURL 업데이트 완료');
      } else {
        debugPrint('DEBUG[ProfilePage]: downloadURL이 null/빈 문자열임');
      }

      if (!mounted) return;
      setState(() {
        // 업로드 성공 시 네트워크 URL을 우선 반영
        profileImageURL = downloadURL ?? pickedFile.path;
      });

      if (mounted) {
        showSnackBar(
          context,
          downloadURL != null
              ? '프로필 사진이 업로드 되었어요.'
              : '업로드는 시도했지만 URL을 받지 못했어요.',
        );
      }
    } catch (e, st) {
      debugPrint('ERROR[ProfilePage]: 업로드 중 예외 발생: $e');
      debugPrint('STACK[ProfilePage]: $st');
      if (mounted) showSnackBar(context, '업로드 실패: $e');
    } finally {
      if (mounted) setState(() => isUploading = false);
      debugPrint('DEBUG[ProfilePage]: 업로드 종료 (isUploading=false)');
    }
  }

  @override
  void initState() {
    super.initState();
    name = _auth.user?.displayName;
    email = _auth.user?.email;
    profileImageURL = _auth.user?.photoURL;
    debugPrint(
      'DEBUG[ProfilePage]: 초기값 name=$name, email=$email, photoURL=$profileImageURL',
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    // avatarProvider 결정
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
                          debugPrint(
                            'DEBUG[ProfilePage]: backgroundImage 로드 실패 -> 에셋으로 롤백',
                          );
                          setState(() => profileImageURL = null);
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
                                debugPrint(
                                  'DEBUG[ProfilePage]: 프로필 사진 삭제 시도...',
                                );
                                await _auth.deletePhotoUrl();
                                await _storage.deleteProfileImage(
                                  _auth.user?.uid,
                                );
                                debugPrint('DEBUG[ProfilePage]: 프로필 사진 삭제 완료');
                                setState(() => profileImageURL = null);
                                if (mounted)
                                  showSnackBar(context, '프로필 사진이 삭제되었습니다.');
                              } catch (e, st) {
                                debugPrint('ERROR[ProfilePage]: 삭제 중 예외: $e');
                                debugPrint('STACK[ProfilePage]: $st');
                                if (mounted) showSnackBar(context, '삭제 실패: $e');
                              }
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
                  if (value == null || value.isEmpty) return '이름을 입력하세요';
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
                      debugPrint('DEBUG[ProfilePage]: 이메일 인증 전송 눌림 (TODO)');
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
                      debugPrint('DEBUG[ProfilePage]: 이름 업데이트 시도 -> $name');
                      _auth
                          .updateName(name)
                          .then((_) {
                            if (mounted) showSnackBar(context, '수정 되었습니다.');
                          })
                          .catchError((e, st) {
                            debugPrint(
                              'ERROR[ProfilePage]: 이름 업데이트 실패: $e\n$st',
                            );
                            if (mounted) showSnackBar(context, e.toString());
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
                      debugPrint('DEBUG[ProfilePage]: 로그아웃 클릭 (TODO)');
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
                      debugPrint('DEBUG[ProfilePage]: 회원탈퇴 클릭 (TODO)');
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
