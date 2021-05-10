import 'package:flutter/material.dart';
import 'package:todoapp/models/global.dart';
import 'package:todoapp/models/classes/todo_item.dart';

class ReorderableViewPage extends StatefulWidget {
  final List<String> item = ["Clients", "Designer", "Owner"];
  @override
  _ReorderableViewPageState createState() => _ReorderableViewPageState();
}

class _ReorderableViewPageState extends State<ReorderableViewPage> {
  List<Task> taskList = [];
  // Return all IntrayTodos
  List<Task> getList() {
    List<Task> returnList = [];
    for (int i = 1; i < 5; i++) {
      returnList.add(Task("My first todo " + i.toString(), false, i.toString()));
    }
    returnList = shuffleList(returnList);
    return returnList;
  }

  // Main display
  @override
  Widget build(BuildContext context) {
    if (taskList.length == 0) taskList = getList();

    return Theme(
      data: ThemeData(canvasColor: Colors.transparent),
      child: ReorderableListView.builder(
        itemCount: taskList.length, // length of list
        onReorder: reorderData, // action on reorder
        // constructor called for each item in the list [0, itemCount]
        itemBuilder: (context, index) {
          final Task task = taskList[index];
          return buildTask(index, task);
        },
      ),
    );
  }

  // Single task builder
  Widget buildTask(int index, Task task) {
    return Container(
      key: ValueKey(task),
      margin: EdgeInsets.only(bottom: 5),
      height: 100,
      decoration: BoxDecoration(
        color: redColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          new BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Radio(value: null, groupValue: null, onChanged: null),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(task.title, style: darkTodoTitle)],
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              edit(index);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              remove(index);
            },
          ),
        ],
      ),
    );
  }

  // onReorder handler
  void reorderData(int oldindex, int newindex) {
    setState(() {
      // On removal at taskList[oldindex], newindex is offset by +1
      newindex = (newindex > oldindex) ? newindex - 1 : newindex;

      final Task task = taskList.removeAt(oldindex);
      taskList.insert(newindex, task);
    });
  }

  // shuffling capability
  List<Task> shuffleList(List<Task> list) {
    list.shuffle();
    return list;
  }

  // Edit task title
  void edit(int index) {
    showDialog(
      context: context,
      builder: (context) {
        final Task task = taskList[index];
        return AlertDialog(
          content: TextFormField(
            initialValue: task.title,
            onChanged: (newTitle) {
              changeName(newTitle, index);
            },
            onFieldSubmitted: (newTitle) {
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  void changeName(String newTitle, int index) {
    setState(() {
      final Task task = taskList[index];
      task.title = newTitle;
    });
  }

  void remove(int index) {
    setState(() {
      taskList.removeAt(index);
    });
  }
}
