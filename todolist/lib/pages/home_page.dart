import 'package:flutter/material.dart';
import 'package:todolist/pages/list_page.dart';
import 'package:todolist/titles.dart';
import 'package:todolist/menu_tile.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  List<ToDoMenuTile> menuTilesList = [];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController menuTileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
      foregroundColor: Colors.black87,
      backgroundColor: Colors.grey[100],
      elevation: 2,
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
          Container(
            height: 60.0 * widget.menuTilesList.length + 10,
            padding: const EdgeInsets.only(top: 10),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.menuTilesList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ListPage(
                            menuTile: widget.menuTilesList[index],
                          );
                        }
                      ),
                    );
                  },
                  child: widget.menuTilesList[index],
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
                      widget.menuTilesList.add(
                        ToDoMenuTile(
                          text: menuTileController.text,
                          waitingList: [],
                          completedList: [],
                        ),
                      );
                      menuTileController.text = "";
                    });
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
