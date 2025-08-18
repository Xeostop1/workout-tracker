import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart'; // debugPrint, debugPrintStack

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuthService() {
    // 언어 코드는 'kr'이 아니라 'ko' 입니다.
    _auth.setLanguageCode('ko');
  }

  // 회원가입 (디버깅 로그 강화 버전)
  Future<void> singUpWithEmail({
    required String email,
    required String password,
    String? name,
  }) async {
    String? errorMessage;

    try {
      // STEP 1: 계정 생성
      debugPrint('[회원가입][STEP1] 사용자 생성 시작 email=${email}');
      debugPrint('[회원가입][STEP1] 사용자 생성 시작 password=${password}');
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint(
        '[회원가입][STEP1 OK] uid=${cred.user?.uid} emailVerified=${cred.user?.emailVerified}',
      );
      //
      // // STEP 2: 표시 이름 업데이트 (name이 있을 때만)
      // if ((name ?? '').isNotEmpty) {
      //   debugPrint('[회원가입][STEP2] displayName 업데이트 시도 -> "$name"');
      //   await cred.user?.updateDisplayName(name);
      //   await cred.user?.reload();
      //   debugPrint(
      //     '[회원가입][STEP2 OK] 현재 displayName=${_auth.currentUser?.displayName}',
      //   );
      // } else {
      //   debugPrint('[회원가입][STEP2 SKIP] name이 비어있어 업데이트 생략');
      // }
      //
      // // STEP 3: 인증 메일 전송
      // debugPrint('[회원가입][STEP3] 인증 이메일 전송 시도');
      // await cred.user?.sendEmailVerification();
      // debugPrint('[회원가입][STEP3 OK] 인증 이메일 전송 완료');
    } on FirebaseAuthException catch (e, st) {
      // Firebase Auth 예외: 코드/메시지/플러그인과 스택 모두 출력
      debugPrint(
        '[회원가입][FirebaseAuthException] code=${e.code} | message=${e.message} | plugin=${e.plugin}',
      );
      debugPrintStack(
        label: '[회원가입][FirebaseAuthException][STACK]',
        stackTrace: st,
      );

      switch (e.code) {
        case 'weak-password':
          errorMessage = '취약한 비밀번호입니다. 최소 6자 이상 입력하세요.';
          break;
        case 'email-already-in-use':
          errorMessage = '이미 사용 중인 이메일입니다. 다른 이메일을 입력하세요.';
          break;
        case 'invalid-email':
          errorMessage = '유효하지 않은 이메일 형식입니다. 이메일을 확인하세요.';
          break;
        case 'internal-error':
          // internal-error 시 한국어 가이드 추가
          errorMessage = '내부 오류가 발생했습니다. Firebase 초기화/구성 및 네트워크를 확인해 주세요.';
          break;
        default:
          errorMessage = e.message ?? '알 수 없는 오류가 발생했습니다. (code=${e.code})';
      }
      // UI 쪽에서 catchError로 받아 스낵바 표출
      throw Exception(errorMessage);
    } catch (e, st) {
      // 예상치 못한 예외: 타입과 스택을 모두 출력
      debugPrint('[회원가입][Unexpected] type=${e.runtimeType} | error=$e');
      debugPrintStack(label: '[회원가입][Unexpected][STACK]', stackTrace: st);
      throw Exception('계정을 생성하지 못했습니다. 잠시 후 다시 시도해 주세요.');
    }
  }

  // 이메일 일부 마스킹 (로그에 민감정보 최소화)
  String _maskEmail(String email) {
    final at = email.indexOf('@');
    if (at <= 2) return '***${email.substring(at)}';
    return '${email.substring(0, 2)}***${email.substring(at)}';
    // 예: ab***@example.com
  }

  //로그인
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    String errorMessage;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return;
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'user-not-found':
          errorMessage = '해당 이메일로 가입된 사용자가 없습니다.';
          break;
        case 'wrong-password':
          errorMessage = '비밀번호가 올바르지 않습니다.';
          break;
        case 'invalid-email':
          errorMessage = '유효하지 않은 이메일입니다.';
          break;
        case 'invalid-credential':
          errorMessage = '비밀번호가 올바르지 않거나 유효하지 않은 이메일입니다.';
          break;
        default:
          errorMessage = error.message ?? '알 수 없는 오류가 발생했습니다.';
      }
    } catch (e) {
      errorMessage = '알 수 없는 오류가 발생했습니다.';
    }
  }

  //패스워드 변경  -> 비동기니까 비동기를 꼭 걸어줘야 함
  Future<void> resetPassword({required String email}) async {
    String? errorMessage;
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print('비밀번호 재설정 이메일이 전송되었습니다.');
    } on FirebaseAuthException catch (error) {
      String? errorMessage;

      switch (error.code) {
        case 'auth/user-not-found':
          errorMessage = '해당 이메일로 가입된 사용자가 없습니다.';
          break;
        case 'auth/invalid-email':
          errorMessage = '유효하지 않은 이메일입니다.';
          break;
        default:
          errorMessage = error.message ?? '알 수 없는 오류가 발생했습니다.';
      }
    } catch (error) {
      errorMessage = '알 수 없는 오류가 발생했습니다.';
    }
    if (errorMessage != null) {
      throw Exception(errorMessage);
    }
  }

  //널을 리턴함 게터로 함수를 만듬
  User? get user => _auth.currentUser;

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  //성격적으로 분리해서 이름을 분리한다. 결국 같은 기능을 하기 때문에 분리하면 더 복잡하다
  Future<void> updateName(String? name) async {
    try {
      await _auth.currentUser?.updateDisplayName(name);
    } catch (e) {
      throw Exception('수정 실패:$e');
    }
  }

  //로그아웃
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //회원탈퇴
  Future<void> deleteAccount() async {}
}
