import 'dart:convert';
import 'package:http/http.dart' as http;

class UserModel {
  final int id;
  final String nama;
  final String email;
  final String sex;

  UserModel({
    required this.id,
    required this.nama,
    required this.email,
    required this.sex,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json["id"],
        nama: json["nama"],
        email: json["email"],
        sex: json["sex"]);
  }
}

String myIp = "127.0.0.1";

Future<List<UserModel>> getUser() async {
  var result =
      await http.get(Uri.parse("http://${myIp}:8082/api/user/get_user"));
  Iterable i = jsonDecode(result.body);
  List<UserModel> usersData =
      List<UserModel>.from(i.map((e) => UserModel.fromJson(e)));
  if (result.statusCode == 200) {
    return usersData;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<http.Response> createUser(UserModel user) async {
  final result =
      await http.post(Uri.parse("http://${myIp}:8082/api/user/create_user"),
          headers: <String, String>{
            "Content-type": 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'nama': user.nama,
            'email': user.email,
            'sex': user.sex,
          }));
  return result;
}

Future<http.Response> deleteUser(int id) {
  return http.delete(
      Uri.parse("http://${myIp}:8082/api/user/delete_user/${id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
}

Future<http.Response> updateUser(int id, UserModel user) async {
  var respon = await http.put(
      Uri.parse("http://${myIp}:8082/api/user/update_user/${id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nama': user.nama,
        'email': user.email,
        'sex': user.sex,
      }));
  print(respon.body);
  return respon;
}
