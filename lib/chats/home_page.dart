import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_firebase/Auth/helpers/firestore_helper.dart';
import 'package:flutter_app_firebase/Auth/providers/auth_provider.dart';
import 'package:flutter_app_firebase/Auth/ui/widgets/userWidget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static final routeName = 'home';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // body: Center(
      //   child: Text(FirestoreHelper.firestoreHelper.getAllUsers().toString()),
      // ),
      body: ListView.builder(
          itemCount: Provider.of<AuthProvider>(context).allUsers.length,
          itemBuilder: (context, index) {
            return UserWidget(
              Provider.of<AuthProvider>(context).allUsers[index],
            );
          }),
    );
  }
}
