import 'package:flutter/material.dart';
import 'menu_tile.dart';

class ToDoListTile extends StatefulWidget {
  final String text;
  final ToDoMenuTile menuTile;
  final VoidCallback onDelete;
  final VoidCallback onTicked;

  const ToDoListTile ({
    super.key,
    required this.text,
    required this.menuTile,
    required this.onDelete,
    required this.onTicked,
  });

  @override
  State<ToDoListTile> createState() => _ToDoListTileState();
}

class _ToDoListTileState extends State<ToDoListTile> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(right: 10),
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            height: 50,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(-1, 2),
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
              ],
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Colors.black,
                width: 0.5,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (widget.menuTile.waitingList.contains(widget.text)){
                        widget.menuTile.waitingList.remove(widget.text);
                        widget.menuTile.completedList.add(widget.text);
                      }
                      else {
                        widget.menuTile.waitingList.add(widget.text);
                        widget.menuTile.completedList.remove(widget.text);
                      }
                    });
                    widget.onTicked();
                  },
                  icon: widget.menuTile.waitingList.contains(widget.text)
                      ? const Icon(Icons.check_box_outline_blank_rounded)
                      : const Icon(Icons.check_box_rounded),
                ),
                Text(
                  widget.text,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (widget.menuTile.waitingList.contains(widget.text)){
                            widget.menuTile.waitingList.remove(widget.text);
                          }
                          else{
                            widget.menuTile.completedList.remove(widget.text);
                          }

                          widget.onDelete();
                        });
                      },
                      child: const Icon(Icons.close_rounded),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
