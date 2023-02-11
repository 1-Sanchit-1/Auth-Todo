import 'package:flutter/material.dart';
import 'package:flutter_auth_all/firestore/cloudfirestore.dart';

class update extends StatefulWidget {
   String id, title, des;
   update({required this.id, required this.title, required this.des});

  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {


   TextEditingController tc=TextEditingController();
   TextEditingController dc=TextEditingController();
   void initState() {
     super.initState();
     {
       tc.text = widget.title;
       dc.text = widget.des;
     }
   }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    print(widget.title);
    print(widget.des);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Update"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(18),
          child: Column(
          children: [
            SizedBox(
              height: 22,
            ),
            Divider(),
            TextField(
              controller: tc,
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
              controller: dc,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                labelText: "Description",
                fillColor: Colors.white,
                border: OutlineInputBorder(
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
                   store().update(id: widget.id, title: tc.text, des: dc.text) ;
                   Navigator.pop(context);
                   var snackbar = SnackBar(
                     content: Text("updated Successfully",style: TextStyle(
                       fontWeight: FontWeight.bold,
                       color: Colors.black ,
                     ),),
                     backgroundColor: Colors.greenAccent,
                   );
                   ScaffoldMessenger.of(context).showSnackBar(snackbar);
                },
                child: Text("Update")),
            SizedBox(
              height: 12,
            ),
          ],
          ),
        ),
      ),
    );
  }
}
