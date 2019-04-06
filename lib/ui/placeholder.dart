import 'dart:async';

import 'package:assign_02/database/DBhelper.dart';
import 'package:assign_02/model/Contact.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<List<Contact>> getContactsFormDB() async {
  var dbHelper = DBHelper();
  Future<List<Contact>> contacts = dbHelper.getContacts();
  return contacts;
}

class MyContactList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyContactListState();
}

class MyContactListState extends State<MyContactList> {
  final controller_name = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Create con
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
        actions: <Widget>[
              new FlatButton(
                  child: new IconTheme(
                    data: new IconThemeData(color: Colors.white),
                    child: new Icon(Icons.add),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/second");
                  },
                )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: FutureBuilder<List<Contact>>(
            future: getContactsFormDB(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(snapshot.data[index].name,
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),

                          //update/
                          GestureDetector(
                            onTap: () {
                              var dbHelper = DBHelper();
                              Contact contact = new Contact();
                              contact.id = snapshot.data[index].id;
                              contact.done = 1;
                              dbHelper.updateContact(contact);
                              Fluttertoast.showToast(msg: 'Subject was check', toastLength: Toast.LENGTH_SHORT,);
                              setState(() {
                               getContactsFormDB(); 
                              });
                            },
                            child: Icon(
                              Icons.check_box_outline_blank,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              }

              //show loading while snap shot not getting data
              return new Container(
                alignment: AlignmentDirectional.center,
                child: new CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState(){
    super.initState();
  }
}
