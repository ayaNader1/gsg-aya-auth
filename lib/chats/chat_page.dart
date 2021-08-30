import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_firebase/Auth/helpers/auth_helper.dart';
import 'package:flutter_app_firebase/Auth/helpers/firestore_helper.dart';
import 'package:flutter_app_firebase/Auth/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  static final String routeName = 'chatPage';
  String message;
  TextEditingController msg = TextEditingController();
  sendTOFirestore() async {
    FirestoreHelper.firestoreHelper.addMessageToFirestore({
      'message': this.message,
      'dateTime': DateTime.now(),
      'id': AuthHelper.authHelper.getUserId()
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('Group Chat'),
      ),
      body: Consumer<AuthProvider>(builder: (context, provider, x) {
        return Container(
          child: Column(
            children: [
              Expanded(
                  child: Container(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirestoreHelper.firestoreHelper.getFirestoreStream(),
                  builder: (context, datasnapshot) {
                    QuerySnapshot<Map<String, dynamic>> querySnapshot =
                        datasnapshot.data;
                    List<Map> messages =
                        querySnapshot.docs.map((e) => e.data()).toList();
                    return ListView.builder(
                        itemCount: messages.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                              padding: EdgeInsets.only(
                                  left: 14, right: 14, top: 10, bottom: 10),
                              child: Align(
                                  alignment: messages[index]['id'] !=
                                          AuthHelper.authHelper.getUserId()
                                      ? Alignment.topLeft
                                      : Alignment.topRight,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: (messages[index]['id'] !=
                                                AuthHelper.authHelper
                                                    .getUserId()
                                            ? Colors.grey.shade200
                                            : Colors.orangeAccent[200]),
                                      ),
                                      padding: EdgeInsets.all(16),
                                      child:
                                          Text(messages[index]['message']))));
                        });
                  },
                ),
              )),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: msg,
                      cursorColor: Colors.orangeAccent,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.orangeAccent)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onChanged: (x) {
                        this.message = x;
                      },
                    )),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(5),
                        child: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              if (this.message == null) {
                                print('no message to send');
                              } else {
                                msg.clear();
                                sendTOFirestore();
                              }
                            }))
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
