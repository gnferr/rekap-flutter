import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<http.Response> getData() async {
  final result =
      await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

  return result;
}

Future<http.Response> postData() async {
  Map<String, dynamic> data = {"name": "Joko", "email": "emasd@gmail.com"};
  final result = await http.post(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(data));
  print(result.statusCode);
  print(result.body);
  return result;
}

Future<http.Response> putData(int id) async {
  Map<String, dynamic> data = {"name": "Joko", "email": "emasd@gmail.com"};
  var result = await http.put(
      Uri.parse("https://jsonplaceholder.typicode.com/users/${id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(data));
  print(result.statusCode);
  return result;
}

Future<http.Response> deleteData(int id) async {
  var result = await http.delete(
    Uri.parse("https://jsonplaceholder.typicode.com/users/${id}"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
  );

  print(result.statusCode);
  return result;
}

class NetworkHttp extends StatelessWidget {
  NetworkHttp({super.key});

  var data = getData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.add),
      // ),
      appBar: AppBar(
        title: const Text('API Data'),
        actions: [
          IconButton(
              onPressed: () {
                postData();
                // showDialog(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return AlertDialog(
                //         scrollable: true,
                //         title: const Text('New User'),
                //         content: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Form(
                //             child: Column(
                //               children: <Widget>[
                //                 TextFormField(
                //                   decoration: const InputDecoration(
                //                     labelText: 'Name',
                //                   ),
                //                 ),
                //                 TextFormField(
                //                   decoration: const InputDecoration(
                //                     labelText: 'Email',
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       );
                //     });
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Container(
        child: FutureBuilder<http.Response>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<dynamic> json = jsonDecode(snapshot.data!.body);
              return ListView.builder(
                itemCount: json.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(child: Text(json[index]["name"][0])),
                    title: Text(json[index]["name"]),
                    subtitle: Text(json[index]["email"]),
                    trailing: PopupMenuButton<Text>(
                        itemBuilder: (context) => <PopupMenuEntry<Text>>[
                              PopupMenuItem<Text>(
                                child: Text('Update'),
                                onTap: () {
                                  putData(json[index]["id"]);
                                },
                              ),
                              PopupMenuItem<Text>(
                                onTap: () {
                                  deleteData(json[index]["id"]);
                                },
                                child: Text('Delete'),
                              ),
                            ]),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
