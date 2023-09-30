import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../model/models.dart';
part 'profile_repo.dart';

abstract class ProfileBaseRepo {
  Future<void> createProfile(Profile profile);
  Future<String> uploadFile(File file);
  Future<void> updateProfileName(
      {required String userName, required String userId});
  Future<void> updateProfileEmail(Profile profile);
  Future<void> updateProfilePhoto(String photo, String userId);
  Future<void> updateProfilePhone({required String phone, required String userId});
  Future<void> updateProfileNotes({required String notes, required String userId});
  Future<void> removePhoto(String photo);
  Stream<Profile> getProfile({required String? userId});
}
