import 'package:flutter/material.dart';
import 'package:learning_udemy/17Aug_Spring/create.dart';
import 'package:learning_udemy/17Aug_Spring/model_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SpringFlutter extends StatelessWidget {
  const SpringFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<UserModel>> usersData;
  @override
  void initState() {
    // TODO: implement initStat
    super.initState();
    usersData = getUser();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CreateUser()))
                    .then((value) {
                  setState(() {});
                });
              },
              icon: Icon(Icons.add))
        ],
        title: Text("Flutter x Spring"),
      ),
      body: Container(
        child:

            // FUTURE BUILDER //
            ////////////////////
            FutureBuilder<List<UserModel>>(
          future: getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                        leading: CircleAvatar(
                          child: Text("${snapshot.data?[index].nama[0]}"),
                        ),
                        title: Text(
                            "${snapshot.data?[index].nama} | ${snapshot.data?[index].sex}"),
                        subtitle: Text("${snapshot.data?[index].email}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  print(snapshot.data?[index].nama);
                                  Navigator.pushNamed(context, "/updateuser",
                                      arguments: {
                                        'gender': snapshot.data?[index].sex,
                                        'datauser': snapshot.data?[index]
                                      }).then((value) {
                                    setState(() {});
                                  });
                                },
                                icon: Icon(Icons.edit)),
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
                                                await deleteUser(
                                                    snapshot.data![index].id);
                                                setState(() {});
                                                Navigator.pop(context);
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
                  );
                },
              );
            } else {
              return Center(child: const CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
