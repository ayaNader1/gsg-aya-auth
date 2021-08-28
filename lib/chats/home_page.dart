import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_firebase/Auth/helpers/firestore_helper.dart';
import 'package:flutter_app_firebase/Auth/providers/auth_provider.dart';
import 'package:flutter_app_firebase/Auth/ui/widgets/userWidget.dart';
import 'package:flutter_app_firebase/chats/profile_page.dart';
import 'package:flutter_app_firebase/chats/users_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static final routeName = 'home';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 2,
        child:
        Scaffold(body: TabBarView(children: [UserPage(), ProfilePage()])));
  }
}
