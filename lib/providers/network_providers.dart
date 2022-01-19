import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkProvider with ChangeNotifier {
  int postioned = 1;
  SharedPreferences? _pref;
  Future<void> vidpos() async {
    final sharePrefs = await SharedPreferences.getInstance();
  }

  initPrefs() async {
    if (_pref == null) _pref = await SharedPreferences.getInstance();
  }

  loadFromPrefs() async {
    await initPrefs();
    postioned = _pref!.getInt('position')!;
    print(postioned);
    notifyListeners();
  }

  saveToPrefs(int time) async {
    await initPrefs();
    _pref!.setInt('position', time);
    print(time);
    postioned = time;
    print(postioned);
    notifyListeners();
  }
}
