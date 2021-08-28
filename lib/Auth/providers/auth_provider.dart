import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_firebase/Auth/helpers/auth_helper.dart';
import 'package:flutter_app_firebase/Auth/helpers/firestore_helper.dart';
import 'package:flutter_app_firebase/Auth/helpers/firestroge_helper.dart';
import 'package:flutter_app_firebase/Auth/models/countries_model.dart';
import 'package:flutter_app_firebase/Auth/models/register_request.dart';
import 'package:flutter_app_firebase/Auth/models/user_model.dart';
import 'package:flutter_app_firebase/Auth/ui/auth_main.dart';
import 'package:flutter_app_firebase/chats/home_page.dart';
import 'package:flutter_app_firebase/servises/custom_dialog.dart';
import 'package:flutter_app_firebase/servises/routes_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(){
    getAllUsers();
    getCountriesFromFirestore();
  }
  List<UserModel> allUsers;
  TabController tabController;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cituController = TextEditingController();

  UserModel user;

  getUserFromFirestore()async{
    String userId = AuthHelper.authHelper.getUserId();
    user = await FirestoreHelper.firestoreHelper.getUserFromFirestore(userId);
    notifyListeners();
  }
  resetControllers() {
    emailController.clear();
    passwordController.clear();
  }

  List<CountryModel> countries;
  List<dynamic> cities = [];
  CountryModel selectedCountry;
  String selectedCity;
  selectCountry(CountryModel countryModel){
    this.selectedCountry = countryModel;
    this.cities = countryModel.cities;
    selectCity(cities.first.toString());
    notifyListeners();
  }

  selectCity(dynamic city){
    this.selectedCity = city;
    notifyListeners();
  }

  getCountriesFromFirestore() async{
    List<CountryModel> countries = await FirestoreHelper.firestoreHelper.getAllCountries();
    this.countries = countries;
    selectCountry(countries.first);
    notifyListeners();
  }

  File file;
  selectFile() async{
    XFile imageFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    this.file = File(imageFile.path);
    notifyListeners();
  }

  register() async {
    try {
      UserCredential userCredential = await AuthHelper.authHelper
          .signup(emailController.text, passwordController.text);
      String imgURL = await FirebaseStorageHelper.firebaseStorageHelper.uploadImage(file);
      RegisterRequest registerRequest = RegisterRequest(
        imgURL: imgURL,
          id: userCredential.user.uid,
          city: selectedCity,
          country: selectedCountry.name,
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', emailController.text);
      RouteHelper.routeHelper.goToPageWithReplacement(HomePage.routeName);
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

  checkLogin(){
    bool isLoggedIn = AuthHelper.authHelper.checkUserLoging();
    if (isLoggedIn) {
      RouteHelper.routeHelper.goToPageWithReplacement(HomePage.routeName);
    }else{
      RouteHelper.routeHelper.goToPageWithReplacement(AuthMainPage.routeName);
    }
  }

  logOut()async{
    await AuthHelper.authHelper.logout();
    RouteHelper.routeHelper.goToPageWithReplacement(AuthMainPage.routeName);
  }

  fillControllers(){
    emailController.text = user.email;
    firstNameController.text = user.fName;
    lastNameController.text = user.lName;
    countryController.text = user.country;
    cituController.text = user.city;
  }

  File updatedFile;
  captureUpdateProfileImage() async {
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    this.updatedFile = File(file.path);
    notifyListeners();
  }

  updateProfile() async {
    String imgURL;
    if (updatedFile != null) {
      imgURL = await FirebaseStorageHelper.firebaseStorageHelper
          .uploadImage(updatedFile);
    }
    UserModel userModel = imgURL == null
        ? UserModel(
        city: cituController.text,
        country: countryController.text,
        fName: firstNameController.text,
        lName: lastNameController.text,
        id: user.id)
        : UserModel(
        city: cituController.text,
        country: countryController.text,
        fName: firstNameController.text,
        lName: lastNameController.text,
        id: user.id,
        imgURL: imgURL);

    await FirestoreHelper.firestoreHelper.updateProfile(userModel);
    getUserFromFirestore();
    Navigator.of(RouteHelper.routeHelper.navKey.currentContext).pop();
  }




}

