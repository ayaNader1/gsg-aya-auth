import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_firebase/Auth/helpers/firestore_helper.dart';

class HomePage extends StatelessWidget {
  static final routeName = 'home';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Text(FirestoreHelper.firestoreHelper.getAllUsersFromFirestore().toString()),
      ),
    );
  }
}