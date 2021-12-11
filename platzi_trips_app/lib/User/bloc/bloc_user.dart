import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/User/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:platzi_trips_app/User/repository/cloud_firestore_repository.dart';
import 'package:platzi_trips_app/User/model/user.dart' as UserModel;

class UserBloc implements Bloc {
  final authRepository = AuthRepository();

  // Flujo de datos - Streams
  // Stream Firebase
  // StreamController
  Stream<User> streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User> get authStatus => streamFirebase;

  // Casos de uso:
  // 1. Sign in con Google.
  Future<User> signIn() => authRepository.signInFirebase();

  // 2. Registrar un usuario en la base de datos.
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateUserData(UserModel.User user) =>
      _cloudFirestoreRepository.updateUserDataFirestore(user);

  signOut() {
    authRepository.signOut();
  }

  @override
  void dispose() {}
}
