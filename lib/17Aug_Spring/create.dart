import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learning_udemy/17Aug_Spring/model_user.dart';

class CreateUser extends StatefulWidget {
  CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final _formKey = GlobalKey<FormState>();
  final namaController = TextEditingController();

  final emailController = TextEditingController();

  final genderController = TextEditingController();

  UserModel? data;

  String? nama;

  String? email;

  String? sex;

  String? gender = "Pria";

  bool validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("NEW USER")),
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                  labelText: 'Email',
                ),
                controller: emailController,
              ),
              SizedBox(
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
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            data = UserModel(
                                id: 0,
                                nama: namaController.text,
                                email: emailController.text,
                                sex: gender!);

                            Navigator.pop(context);
                          });
                          await createUser(data!);
                          setState(() {
                            namaController.clear();
                            emailController.clear();
                          });
                        }
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

class UpdateUser extends StatefulWidget {
  UpdateUser({super.key});

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  UserModel? dataU;
  String? nama;
  String? email;
  String? sex;
  String? gender;

  @override
  Widget build(BuildContext context) {
    final dataUser =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final namaController =
        TextEditingController(text: dataUser["datauser"].nama);
    final emailController =
        TextEditingController(text: dataUser["datauser"].email);
    String gValue = dataUser["datauser"].sex;

    return Scaffold(
      appBar: AppBar(title: Text("UPDATE USER")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                  labelText: 'Nama',
                ),
                controller: namaController,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                  labelText: 'Email',
                ),
                controller: emailController,
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioListTile(
                    title: Text("Laki - Laki"),
                    value: "Pria",
                    groupValue: dataUser["datauser"].sex,
                    onChanged: (value) {
                      setState(() {
                        gValue = value.toString();
                        print(gValue);
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("Perempuan"),
                    value: "Wanita",
                    groupValue: dataUser["datauser"].sex,
                    onChanged: (value) {
                      setState(() {
                        gValue = value.toString();
                        print(dataUser["datauser"].id.toString());
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
                        setState(() {
                          dataU = UserModel(
                              id: 0,
                              nama: namaController.text,
                              email: emailController.text,
                              sex: gValue);
                        });
                        await updateUser(
                            int.parse(dataUser["datauser"].id.toString()),
                            dataU!);
                        print(dataUser["datauser"].nama);
                        Navigator.pop(context);
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
