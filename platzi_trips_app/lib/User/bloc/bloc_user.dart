import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/Place/model/place.dart';
import 'package:platzi_trips_app/Place/repository/firebase_storage_repository.dart';
import 'package:platzi_trips_app/Place/ui/widgets/widgets/profile_place.dart';
import 'package:platzi_trips_app/User/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:platzi_trips_app/User/repository/cloud_firestore_api.dart';
import 'package:platzi_trips_app/User/repository/cloud_firestore_repository.dart';
import 'package:platzi_trips_app/User/model/user.dart' as UserModel;

class UserBloc implements Bloc {
  final authRepository = AuthRepository();

  // Flujo de datos - Streams
  // Stream Firebase
  // StreamController
  Stream<User> streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User> get authStatus => streamFirebase;
  Future<User> get currentUser async => FirebaseAuth.instance.currentUser;

  // Casos de uso:
  // 1. Sign in con Google.
  Future<User> signIn() => authRepository.signInFirebase();

  // 2. Registrar un usuario en la base de datos.
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateUserData(UserModel.User user) =>
      _cloudFirestoreRepository.updateUserDataFirestore(user);

  Future<void> updatePlaceData(Place place) =>
      _cloudFirestoreRepository.updatePlaceDate(place);

  Stream<QuerySnapshot> placesListStream = FirebaseFirestore.instance
      .collection(CloudFirestoreAPI().PLACES)
      .snapshots();

  Stream<QuerySnapshot> get PlacesStream => placesListStream;

  List<ProfilePlace> buildPlaces(List<DocumentSnapshot> placesListSnapshot) =>
      _cloudFirestoreRepository.buildPlaces(placesListSnapshot);

  final _firebaseStorageRepository = FirebaseStorageRepository();
  Future<UploadTask> uploadFile(String path, File image) async =>
      _firebaseStorageRepository.uploadFile(path, image);

  signOut() {
    authRepository.signOut();
  }

  @override
  void dispose() {}
}
