import 'package:flutter/material.dart';
import 'package:flutter_app_firebase/Auth/models/user_model.dart';

class UserWidget extends StatelessWidget{
  UserModel userModel;
  UserWidget(this.userModel);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.7),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        userModel.fName + ' ' + userModel.lName,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

}