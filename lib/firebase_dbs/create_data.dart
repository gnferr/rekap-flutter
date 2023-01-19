import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateData extends StatefulWidget {
  CreateData({super.key});

  @override
  State<CreateData> createState() => _CreateDataState();
}

class _CreateDataState extends State<CreateData> {
  final _formKey = GlobalKey<FormState>();
  final namaController = TextEditingController();
  final emailController = TextEditingController();

  String gender = "Pria";

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
    return Scaffold(
      appBar: AppBar(
        title: Text('CREATE USER'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Cannot empty!";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                  labelText: 'Nama',
                ),
                controller: namaController,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Cannot empty!";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                  labelText: 'Email',
                ),
                controller: emailController,
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioListTile(
                    title: Text("Laki - Laki"),
                    value: "Pria",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("Perempuan"),
                    value: "Wanita",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        users.add({
                          'nama': namaController.text,
                          'email': emailController.text,
                          'gender': gender
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text("Submit")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
