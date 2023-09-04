import 'package:hive_flutter/hive_flutter.dart';

class ToDoListDatabase {
  List menuTilesList = [];

  final todolistBox = Hive.box('todolist');

  void loadData() {
    menuTilesList = todolistBox.get('TODOLIST');
  }

  void updateData() {
    todolistBox.put("TODOLIST", menuTilesList);
  }
}