import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learning_udemy/firebase_dbs/create_data.dart';

class FireMain extends StatelessWidget {
  const FireMain({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CreateData(),
                ));
              },
              icon: Icon(Icons.add))
        ],
        title: Text("Firebase Thing"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot data = snapshot.data!.docs[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                        title: Text("${data['nama']} | ${data['gender']}"),
                        subtitle: Text(data['email']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Delete"),
                                        content: Text(
                                            "Yakin ingin menghapus data ini?"),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .runTransaction((Transaction
                                                        myTransaction) async {
                                                  await myTransaction.delete(
                                                      snapshot.data!.docs[index]
                                                          .reference);
                                                });
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Yes")),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("No"))
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: Icon(Icons.delete)),
                          ],
                        )),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("Kosong"));
          }
        },
      ),
    );
  }
}
