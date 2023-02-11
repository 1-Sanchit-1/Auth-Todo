import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_all/firestore/cloudfirestore.dart';
import 'package:flutter_auth_all/pages/updatetodo.dart';
import 'package:flutter_auth_all/pages/user.dart';
import 'package:get/get.dart';

import 'auth.dart';
import 'login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController titlec = TextEditingController();
  TextEditingController desc = TextEditingController();
  List<model> list = [];

  @override
  Widget build(BuildContext context) {
    bool _isloading = false;
    signout() async {
      setState(() {
        _isloading = true;
      });
      String res = await Auth().logout();
      setState(() {
        _isloading = false;
      });
      if (res == "success") {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => login(),
            ));
      } else {
        var snackBar = SnackBar(content: Text("Not Signin"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        automaticallyImplyLeading: false,
        actions: [
          MaterialButton(onPressed: () {}),
          SizedBox(
            width: 12,
          ),
          InkWell(
            child: _isloading
                ? Center(child: LinearProgressIndicator())
                : Icon(Icons.logout),
            onTap: () {
              signout();
            },
          ),
          SizedBox(
            width: 22,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: 22,
              ),
              Divider(),
              TextField(
                controller: titlec,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  labelText: "Title",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Divider(),
              TextField(
                maxLines: 4,
                controller: desc,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  labelText: "Description",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      padding: EdgeInsets.all(11),
                      primary: Colors.lightBlueAccent),
                  onPressed: () {
                    if (titlec.text != "" || desc.text != "") {
                      store().addtasks(title: titlec.text, dec: desc.text);
                      titlec.clear();
                      desc.clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("Please Fill both title and description")));
                    }
                  },
                  child: Text("Add Task")),
              SizedBox(
                height: 12,
              ),
              Divider(),
              Text(
                "Tasks",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.lightBlueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
              SizedBox(
                height: 15,
              ),
              StreamBuilder(
                stream: firebaseFirestore.collection('tasks').snapshots(),
                builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final res = snapshot.data!.docs[index];
                        return Dismissible(
                          key: UniqueKey(),
                          background: Container(
                            color: Colors.red,
                          ),
                          onDismissed: (v) {
                            store().delete(id: snapshot.data!.docs[index].id);
                            var snackbar = SnackBar(
                              content: Text("Task Deleted",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black ,
                              ),),
                              backgroundColor: Colors.red,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          },
                          secondaryBackground: Container(
                            color: Colors.cyanAccent,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                              Border.all(width: 2, color: Colors.lightBlueAccent),
                            ),
                            margin: EdgeInsets.all(12),
                            child: ListTile(
                              title: Center(
                                child: Text(
                                  res['title'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              subtitle: Text(
                                res['description'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              leading: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => update(
                                              id: res.id,
                                              title: res['title'],
                                              des: res['description']),
                                        ));
                                  },
                                  child: Icon(Icons.edit)),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                }),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
