import 'package:flutter/material.dart';
import 'package:flutter_app_firebase/Auth/providers/auth_provider.dart';
import 'package:flutter_app_firebase/Auth/ui/register_page.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

class AuthMainPage extends StatefulWidget {
  static final String routeName = 'authPage';
  @override
  _AuthMainPageState createState() => _AuthMainPageState();
}

class _AuthMainPageState extends State<AuthMainPage>
    with SingleTickerProviderStateMixin {
  @override
  initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).tabController =
        TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Main Page'),
          bottom: TabBar(
              controller: Provider.of<AuthProvider>(context).tabController,
              tabs: [
                Tab(
                  text: 'Register',
                ),
                Tab(
                  text: 'Login',
                )
              ]),
        ),
        body: TabBarView(
          controller: Provider.of<AuthProvider>(context).tabController,
          children: [RegisterPage(), LoginPage()],
        ));
  }
}