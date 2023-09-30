import 'dart:io';
import 'dart:typed_data';

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
  Future<void> updateProfilePhone(String phone);
  Future<void> updateProfileNotes(String notes);
  Future<void> removePhoto(String photo);
  Stream<Profile> getProfile({required String? userId});
}
