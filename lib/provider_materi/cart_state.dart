import 'package:flutter/material.dart';

class CartState with ChangeNotifier {
  int _quantity = 0;

  int get getQuantity {
    return _quantity;
  }

  void addKeranjang() {
    _quantity++;
    notifyListeners();
  }
}
