import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_gestion/data/authentification.dart';
import 'package:easy_gestion/model/user_model.dart';
import 'package:easy_gestion/utils/loaders/firebase_exception.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get Instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      print('ici');
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong; please try again';
    }
  }

  Future<void> saveUserRecordWithGoogle(UserCredential? userCredential) async {
    try {
      if (userCredential != null) {
        final nameParts =
            UserModel.nameParts(userCredential.user!.displayName ?? '');
        final userName =
            UserModel.generateUsername(userCredential.user!.displayName ?? '');

        final user = UserModel(
          id: userCredential.user!.uid,
          username: userName,
          email: userCredential.user!.email ?? '',
          phoneNumber: userCredential.user!.phoneNumber ?? '',
          profilePicture: userCredential.user!.photoURL ?? '',
        );

        await saveUserRecord(user);
      }
    } catch (e) {
      throw 'Something went wrong; please try again';
    }
  }

  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      print('ici');
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong; please try again';
    }
  }

  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db
          .collection("Users")
          .doc(updateUser.id)
          .update(updateUser.toJson());
    } on FirebaseException catch (e) {
      print('ici');
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong; please try again';
    }
  }

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      print('ici');
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong; please try again';
    }
  }

  Future<void> removeRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
    } on FirebaseException catch (e) {
      print('ici');
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong; please try again';
    }
  }
}
