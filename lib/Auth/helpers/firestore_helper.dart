import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_firebase/Auth/models/countries_model.dart';
import 'package:flutter_app_firebase/Auth/models/register_request.dart';
import 'package:flutter_app_firebase/Auth/models/user_model.dart';

class FirestoreHelper {
  FirestoreHelper._();

  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  addUserToFirestore(RegisterRequest registerRequest) async {
    try {
      // await firebaseFirestore.collection('Users').add(registerRequest.toMap());
      await firebaseFirestore
          .collection('Users')
          .doc(registerRequest.id)
          .set(registerRequest.toMap());
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    final listOfMaps = await firebaseFirestore.collection('Users').get();
    final users = listOfMaps.docs.map((e) => UserModel.fromMap(e.data()))
        .toList();
    return users;
  }

  Future<List<CountryModel>> getAllCountries() async{
    QuerySnapshot<Map<String,dynamic>> querySnapshot = await firebaseFirestore.collection('Countries').get();
    List<CountryModel> countries = querySnapshot.docs.map((e) {
      Map map = e.data();
      map['id'] = e.id;
      return CountryModel.fromJson(map);
    }).toList();
    return countries;
  }

  Future<UserModel> getUserFromFirestore(String userId) async {
    DocumentSnapshot documentSnapshot =
    await firebaseFirestore.collection('Users').doc(userId).get();

    print(documentSnapshot.data());
    return UserModel.fromMap(documentSnapshot.data());
  }

  Future<List<UserModel>> getAllUsersFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await firebaseFirestore.collection('Users').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<UserModel> users =
    docs.map((e) => UserModel.fromMap(e.data())).toList();
    print(users.length);
    return users;
  }

  updateProfile(UserModel userModel) async {
    await firebaseFirestore
        .collection('Users')
        .doc(userModel.id)
        .update(userModel.toMap());
  }


}