import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:platzi_trips_app/Place/model/place.dart';
import 'package:platzi_trips_app/User/model/user.dart' as ModelUser;
import 'package:firebase_auth/firebase_auth.dart';

class CloudFirestoreAPI {
  final String USERS = "users";
  final String PLACES = "places";

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void updateUserDate(ModelUser.User user) async {
    DocumentReference ref = _db.collection(USERS).doc(user.uid);
    return await ref.set({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      'myPlaces': user.myPlaces,
      'myFavoritePlaces': user.myFavoritePlaces,
      'lastSignIn': DateTime.now()
    }, SetOptions(merge: true));
  }

  Future<void> updatePlaceData(Place place) async {
    CollectionReference refPlaces = _db.collection(PLACES);
    //Este método va a generar un identificador unico y autoincremental
    User user = _auth.currentUser;
    await refPlaces.add({
      'name': place.name,
      'description': place.description,
      'likes': place.likes,
      'userOwner': "$USERS/$user.uid",
      "urlImage": place.urlImage //tipo de dato conocido como reference
    });
  }
}
