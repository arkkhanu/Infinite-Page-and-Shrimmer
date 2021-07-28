import 'dart:async';

import 'package:flutter/cupertino.dart';

class StreamExample_Controller {
  bool loading = false;
  List<Recipe> listOfRecipe = [];
  // StreamController<List<Recipe>> _streamControllerList =   StreamController<List<Recipe>>();
  // Stream getStreamList() => _streamControllerList.stream;
  List<Recipe> list = [
    Recipe(id: "1", name: "Biryani"),
    Recipe(id: "2", name: "Thika"),
    Recipe(id: "3", name: "Boti"),
    Recipe(id: "4", name: "Paye"),
    Recipe(id: "5", name: "Nali"),
  ];
  int counter = 0;

  StreamController<Recipe> _streamController =
      StreamController<Recipe>.broadcast();
  Stream<Recipe> getStream() => _streamController.stream;

  getFromAPI() {
    print("GetFromAPI");
    getStream().listen((event) {
      print("Event:" + event.toString());
      // listOfRecipe.add(event);
    });
  }

  insertData() async {
    print("InsertDATA");
    setLoading(true);
    await Future.delayed(Duration(seconds: 1));
    for (int i = 0; i < list.length; i++) {
      if (i == counter) {
        _streamController.sink.add(list[i]);
        counter++;
        break;
      }
    }
    setLoading(false);
  }

  void setLoading(bool val) {
    loading = val;
  }
}

class Recipe {
  String name = "";
  String id = "";
  Recipe({required String name, required String id}) {
    this.name = name;
    this.id = id;
  }
}
