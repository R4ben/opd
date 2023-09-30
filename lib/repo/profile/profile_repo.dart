part of 'base_profile_repo.dart';

class ProfileRepository extends ProfileBaseRepo {
  final CollectionReference userRef =
      FirebaseFirestore.instance.collection('users');
  final fire = FirebaseStorage.instance.ref();

  @override
  Future<void> createProfile(Profile profile) async {}

  Future<void> updateProfile(Profile profile) async {
    DocumentReference profileRef = userRef.doc(profile.id);
    if (profileRef.path.isEmpty) {
      createProfile(profile);
    } else {
      profileRef.update(profile.toDocument());
    }
  }

  @override
  Future<String> uploadFile(File file) async {
    try {
      final img = await file.readAsBytes();
      final result = fire.child('users/${file.path}');
      UploadTask uploadTask = result.putData(img);
      TaskSnapshot snapShot = await uploadTask;
      return snapShot.ref.getDownloadURL();
    } catch (_) {
      throw ();
    }
  }

  @override
  Future<void> updateProfileEmail(Profile profile) {
    // TODO: implement updateProfileEmail
    throw UnimplementedError();
  }

  @override
  Future<void> updateProfileName(
      {required String userName, required String userId}) {
    return userRef
        .doc(userId)
        .update({'name': userName}).catchError((erro) => print("nooo:$erro"));
  }

  @override
  Future<void> updateProfilePhone({required String phone, required String userId}) {
    return userRef
        .doc(userId)
        .update({'phone': phone}).catchError((erro) => print("nooo:$erro"));
  }

  @override
  Future<void> updateProfilePhoto(String photo, String userId) async {
    userRef.doc(userId).update({'photo': photo});

  }

  @override
  Future<void> removePhoto(String photo) async {
    await fire.child(photo).delete();
  }

  @override
  Stream<Profile> getProfile({required String? userId}) {
    return userRef
        .doc(userId)
        .snapshots()
        .map((profile) => Profile.fromSnapshot(profile));
  }

  @override
  Future<void> updateProfileNotes({required String notes, required String userId}) {
    // TODO: implement updateProfileNotes
    throw UnimplementedError();
  }

}
