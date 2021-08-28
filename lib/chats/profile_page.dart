import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_firebase/Auth/providers/auth_provider.dart';
import 'package:flutter_app_firebase/Auth/ui/widgets/profileItem.dart';
import 'package:flutter_app_firebase/chats/update)profile.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static final routeName = 'profile';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).getUserFromFirestore();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.amber.withOpacity(0.5),
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false)
                    .fillControllers();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return UpdateProfile();
                }));
              },
              icon: Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
        body: Consumer<AuthProvider>(
          builder: (context, provider, x) {
            return provider.user == null
                ? Center(
              child: CircularProgressIndicator(),
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 30,
                ),
                CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(provider.user.imgURL),
                ),
                profileItem('Email', provider.user.email),
                profileItem('first Name', provider.user.fName),
                profileItem('last Name', provider.user.lName),
                profileItem('country Name', provider.user.country),
                profileItem('city Name', provider.user.city),
              ],
            );
          },
        )
    );
  }
}
