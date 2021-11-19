import 'package:flutter/cupertino.dart';

class AddPlayersViewModel extends ChangeNotifier{
  bool _loading = false;

  void setLoading(bool loading){
    _loading = loading;
  }

  Future<void> OnDelete(int id) async{
    setLoading(true);

    print(id);

    setLoading(false);
  }
}