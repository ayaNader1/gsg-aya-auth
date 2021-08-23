import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_firebase/Auth/helpers/auth_helper.dart';
import 'package:flutter_app_firebase/Auth/helpers/firestore_helper.dart';
import 'package:flutter_app_firebase/Auth/models/register_request.dart';
import 'package:flutter_app_firebase/Auth/models/user_model.dart';
import 'package:flutter_app_firebase/chats/home_page.dart';
import 'package:flutter_app_firebase/servises/custom_dialog.dart';
import 'package:flutter_app_firebase/servises/routes_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(){
    getAllUsers();
  }
  List<UserModel> allUsers;
  TabController tabController;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cituController = TextEditingController();
  resetControllers() {
    emailController.clear();
    passwordController.clear();
  }

  register() async {
    try {
      UserCredential userCredential = await AuthHelper.authHelper
          .signup(emailController.text, passwordController.text);
      RegisterRequest registerRequest = RegisterRequest(
          id: userCredential.user.uid,
          city: cituController.text,
          country: countryController.text,
          email: emailController.text,
          fName: firstNameController.text,
          lName: lastNameController.text,
          password: passwordController.text);
      await FirestoreHelper.firestoreHelper.addUserToFirestore(registerRequest);
      await AuthHelper.authHelper
          .signup(emailController.text, passwordController.text);
      await AuthHelper.authHelper.verifyEmail();
      await AuthHelper.authHelper.logout();
      tabController.animateTo(1);
    } on Exception catch (e) {
      // TODO
    }
// navigate to login

    resetControllers();
  }

  login() async {
    UserCredential userCredential = await AuthHelper.authHelper
        .signin(emailController.text, passwordController.text);
    FirestoreHelper.firestoreHelper
        .getUserFromFirestore(userCredential.user.uid);
    bool isVerifiedEmail = AuthHelper.authHelper.checkEmailVerification();
    if (isVerifiedEmail) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', emailController.text);
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.remove('email');
      RouteHelper.routeHelper.goToPageWithReplacement(HomePage.routeName);
    } else {
      CustomDialoug.customDialoug.showCustomDialoug(
          'You have to verify your email, press ok to send another email',
          sendVericiafion);
    }
    resetControllers();
  }

  sendVericiafion() {
    AuthHelper.authHelper.verifyEmail();
    AuthHelper.authHelper.logout();
  }

  resetPassword() async {
    AuthHelper.authHelper.resetPassword(emailController.text);
    resetControllers();
  }

  getAllUsers() async {
    this.allUsers = await FirestoreHelper.firestoreHelper.getAllUsers();
  }
}

