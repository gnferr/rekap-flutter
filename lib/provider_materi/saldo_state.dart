import 'package:flutter/material.dart';

class SaldoState with ChangeNotifier {
  int _isSaldo = 10000;

  int get getSaldo {
    return _isSaldo;
  }

  void minusSaldo(int harga) {
    _isSaldo -= harga;
    notifyListeners();
  }
}
