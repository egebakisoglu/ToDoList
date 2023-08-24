import 'package:flutter/material.dart';
import 'package:todolist/menu_tile.dart';
import 'package:todolist/titles.dart';
import 'package:todolist/to_do_list_tile.dart';

class ListPage extends StatefulWidget {
  final ToDoMenuTile menuTile;

  const ListPage ({super.key, required this.menuTile});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  TextEditingController listTileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
        title: Text(widget.menuTile.text),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeadingText(text: 'Waiting'),
            Container(
              height: 60.0 * widget.menuTile.waitingList.length + 10,
              padding: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.menuTile.waitingList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ToDoListTile(
                    text: widget.menuTile.waitingList[index],
                    menuTile: widget.menuTile,
                    onDelete: () {
                      setState(() {
                      });
                    },
                    onTicked: () {
                      setState(() {
                      });
                    },
                  );
                },
              ),
            ),
            const HeadingText(text: 'Completed'),
            Container(
              height: 60.0 * widget.menuTile.completedList.length + 10,
              padding: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.menuTile.completedList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ToDoListTile(
                    text: widget.menuTile.completedList[index],
                    menuTile: widget.menuTile,
                    onDelete: () {
                      setState(() {
                      });
                    },
                    onTicked: () {
                      setState(() {
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> alertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Add Something To Do',
          style:  TextStyle(
            fontSize: 24,
          ),
        ),
        content: TextFormField(
          controller: listTileController,
          decoration: InputDecoration(
              filled: true,
              hintText: "Enter something",
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
                      widget.menuTile.waitingList.add(
                        listTileController.text);
                      listTileController.text = "";
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
