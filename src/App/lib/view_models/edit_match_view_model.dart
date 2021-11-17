import 'package:flutter/material.dart';
import 'package:racket_match/models/match.dart';

class EditMatchViewModel extends ChangeNotifier{
  bool _isLoading = false;
  Match? _match;

  bool get isLoading => _isLoading;
  Match? get match => _match;

  EditMatchViewModel(Match? match){
    _match = match;
  }

}