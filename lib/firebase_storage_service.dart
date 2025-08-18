import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';

class FirebaseStorageService {
  final storageRef = FirebaseStorage.instance.ref();

  Future<String> uploadProfileImage(
    Uint8List bytes,
    String path,
    String? uid,
  ) async {
    if (uid == null) throw Exception('잘못된 접근입니다');
    try {
      //경로를 나타냄 주소값을 나타냄 이것에 데이터를 업로드해
      final profileRef = storageRef.child(
        'user_profiles/${uid}_profile_image.png',
      );
      final metadata = SettableMetadata(
        contentType: 'image/png',
        customMetadata: {'picked-file-path': path},
      );
      //메타데이터는 이미지 경로
      await profileRef.putData(bytes, metadata);
      //풋 으로 하는 메소드가 있음 -> 우리는 풋데이터를 꼭 ㄱ써야함(유일하게 웹과 연동이 되기 때문이다)
      final downloadUrl = await profileRef.getDownloadURL();
      //성공데이터로 스트링 액세스 정보(url을 뷰로 보내줌)
      return downloadUrl;
    } catch (e) {
      throw Exception('upload 실패');
    }
  }

  Future<void> deleteProfileImage(String? uid) async {
    if (uid == null) throw Exception('잘못된 접근입니다');
    try {
      final profileRef = storageRef.child(
        'user_profiles/${uid}_profile_image.png',
      );
      await profileRef.delete();
    } catch (e) {
      throw Exception('delete 실패');
    }
  }
}
