import 'package:flutter/cupertino.dart';
import 'package:learning_udemy/17Aug_Spring/flutterxspring.dart';
import 'package:learning_udemy/bloc/bloc_materi.dart';
import 'package:learning_udemy/firebase_dbs/FireMain.dart';
import 'package:learning_udemy/http/http_network.dart';
import 'package:learning_udemy/provider_materi/provider_main.dart';

class DaftarMateri {
  String title;
  String deskripsi;
  Widget page;

  DaftarMateri(
      {required this.title, required this.deskripsi, required this.page});
}

List<DaftarMateri> materi = [
  DaftarMateri(
    title: "Provider Things",
    deskripsi: "Contoh simple penggunaan provider",
    page: ProviderMain(),
  ),
  DaftarMateri(
    title: "Flutter Bloc",
    deskripsi: "Contoh simple bloc",
    page: CubitExample(),
  ),
  DaftarMateri(
    title: "Network Http",
    deskripsi: "~~~ http network",
    page: NetworkHttp(),
  ),
  DaftarMateri(
    title: "Local Http",
    deskripsi: "~~~ simple crud localan cuy",
    page: HomePage(),
  ),
  DaftarMateri(
    title: "Firebase Things",
    deskripsi: "~~~ using firebase for store data",
    page: FireMain(),
  ),
];
