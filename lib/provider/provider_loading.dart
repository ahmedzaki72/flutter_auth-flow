import 'package:flutter/material.dart';

class LoadingProvider extends ChangeNotifier {
  bool loading = false;

 void changeLoading(bool value) {
    loading = value;
    notifyListeners();
  }
}