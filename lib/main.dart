import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_firebase/Auth/providers/auth_provider.dart';
import 'package:flutter_app_firebase/Auth/ui/login_page.dart';
import 'package:flutter_app_firebase/Auth/ui/register_page.dart';
import 'package:flutter_app_firebase/Auth/ui/reset_password_page.dart';
import 'package:flutter_app_firebase/chats/chat_page.dart';
import 'package:flutter_app_firebase/chats/home_page.dart';
import 'package:flutter_app_firebase/chats/profile_page.dart';
import 'package:flutter_app_firebase/chats/users_page.dart';
import 'package:flutter_app_firebase/servises/routes_helper.dart';
import 'package:flutter_app_firebase/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Auth/ui/auth_main.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // var email = prefs.getString('email');
  runApp(ChangeNotifierProvider<AuthProvider>(
      create: (context)=>AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          routes: {
            LoginPage.routeName: (context) => LoginPage(),
            RegisterPage.routeName: (context) => RegisterPage(),
            ResetPasswordPage.routeName: (context) => ResetPasswordPage(),
            HomePage.routeName: (context) => HomePage(),
            AuthMainPage.routeName: (context) => AuthMainPage(),
            UserPage.routeName: (context) => UserPage(),
            ProfilePage.routeName: (context) => ProfilePage(),
            ChatPage.routeName: (context) => ChatPage(),
          },
          navigatorKey: RouteHelper.routeHelper.navKey,
          home: FirebaseConfiguration())));
}

class FirebaseConfiguration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, AsyncSnapshot<FirebaseApp> dataSnapShot) {
          if (dataSnapShot.hasError) {
            return Scaffold(
              backgroundColor: Colors.red,
              body: Center(
                child: Text(dataSnapShot.error.toString()),
              ),
            );
          }
          if (dataSnapShot.connectionState == ConnectionState.done) {
            return SplachScreen();
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}

// class FirebaseConfiguration extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return FutureBuilder(builder: (context,AsyncSnapshot<FirebaseApp> dataSnapshot){
//       if (dataSnapshot.hasError) {
//         return Scaffold(
//           body: Center(
//             child: Center(
//               child: Text(dataSnapshot.error.toString()),
//             ),
//           ),
//         );
//       }
//       // Once complete, show your application
//       if (dataSnapshot.connectionState == ConnectionState.done) {
//         return Scaffold(
//           body: Center(
//             child: Center(
//               child: Text('Done'),
//             ),
//           ),
//         );
//       }
//       return Scaffold(
//         body: Center(
//           child: Center(
//             child: CircularProgressIndicator(),
//           ),
//         ),
//       );
//     },
//     future: Firebase.initializeApp(),);
//   }
//
// }

