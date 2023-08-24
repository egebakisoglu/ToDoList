import 'package:flutter/material.dart';

class ToDoMenuTile extends StatefulWidget {
  final String text;
  final List<String> waitingList;
  final List<String> completedList;

  const ToDoMenuTile({super.key,
    required this.text,
    required this.waitingList,
    required this.completedList,
  });

  @override
  State<ToDoMenuTile> createState() => _ToDoMenuTileState();
}

class _ToDoMenuTileState extends State<ToDoMenuTile> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
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
          Text(
            widget.text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500
            ),
          ),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Waiting:${widget.waitingList.length}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                    Text(
                      "Completed:${widget.completedList.length}",
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
