import 'package:flutter/material.dart';
import 'package:racket_match/models/match.dart';

class EditMatchViewModel extends ChangeNotifier{
  bool _isLoading = false;
  bool _isChecked = false;
  String _checkboxTitle = "Single";
  Match? _match;

  bool get isLoading => _isLoading;
  Match? get match => _match;
  bool get isChecked => _isChecked;
  String get checkboxTitle => _checkboxTitle;

  void toggleIsChecked(){
    _isChecked = !_isChecked;
    _isChecked ? _checkboxTitle = "Double" : _checkboxTitle = "Single";
    notifyListeners();
  }

  EditMatchViewModel(Match? match){
    _match = match;
  }

}