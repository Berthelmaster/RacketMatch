import 'dart:io';

import 'package:flutter/material.dart';

class RoomSelectionViewModel with ChangeNotifier {
  bool _loading = false;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();

  }

}