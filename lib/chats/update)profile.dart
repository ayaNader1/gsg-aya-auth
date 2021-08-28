import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_firebase/Auth/providers/auth_provider.dart';
import 'package:flutter_app_firebase/Auth/ui/widgets/profileItem.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget{
  static final routeName = 'updateprofile';
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.amber.withOpacity(0.5),
        appBar: AppBar(
          title: Text('Editing Profile Page'),
          actions: [
            IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false)
                    .updateProfile();
              },
              icon: Icon(Icons.done),
            )
          ],
        ),
        body: Consumer<AuthProvider>(
          builder: (context, provider, x) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      provider.captureUpdateProfileImage();
                    },
                    child: provider.updatedFile == null
                        ? CircleAvatar(
                      radius: 80,
                      backgroundImage:
                      NetworkImage(provider.user.imgURL),
                    )
                        : CircleAvatar(
                      radius: 80,
                      backgroundImage: FileImage(provider.updatedFile),
                    ),
                  ),
                  ProfileItem('first Name', provider.firstNameController),
                  ProfileItem('last Name', provider.lastNameController),
                  ProfileItem('country Name', provider.countryController),
                  ProfileItem('city Name', provider.cituController),
                ],
              ),
            );
          },
        )
    );
  }
}

class ProfileItem extends StatelessWidget {
  String label;
  TextEditingController valueController;
  ProfileItem(this.label, this.valueController);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextField(
              controller: valueController,
              style: TextStyle(fontSize: 22),
            ),
          )
        ],
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
    );
  }
}