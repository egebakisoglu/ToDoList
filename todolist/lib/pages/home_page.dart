import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/data/database.dart';
import 'package:todolist/pages/list_page.dart';
import 'package:todolist/titles.dart';
import 'package:todolist/menu_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todolistBox = Hive.box('todolist');
  ToDoListDatabase db = ToDoListDatabase();

  TextEditingController menuTileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (todolistBox.get('TODOLIST') != null){
      db.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
      foregroundColor: Colors.black87,
      backgroundColor: Colors.grey[100],
      elevation: 2,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          padding: const EdgeInsets.only(right: 20),
          icon: const Icon(
            Icons.add,
            size: 36,
            ),
          onPressed: () {
            alertDialog(context);
          },
          ),
        ],
      ),
      body: Column(
        children: [
          const HeadingText(text: "To-Do's"),
          db.menuTilesList.length == 0
          ? Center(
            child: Text('Nothing to see here'),
          ):
          Container(
            height: 60.0 * db.menuTilesList.length + 10,
            padding: const EdgeInsets.only(top: 10),
            child: ListView.builder(
              itemCount: db.menuTilesList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ListPage(
                            db: db,
                            menuTile: db.menuTilesList[index],
                          );
                        }
                      ),
                    );
                  },
                  child: db.menuTilesList[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> alertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Add A To-Do List',
          style:  TextStyle(
            fontSize: 24,
          ),
        ),
        content: TextFormField(
          controller: menuTileController,
          decoration: InputDecoration(
            filled: true,
            hintText: "Enter a text",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black),
            )
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                TextButton(
                  onPressed: () {
                    setState(() {
                      db.menuTilesList.add(
                        ToDoMenuTile(
                          text: menuTileController.text,
                          waitingList: [],
                          completedList: [],
                          db: db,
                        ),
                      );
                      menuTileController.text = "";
                    });
                    db.updateData();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
