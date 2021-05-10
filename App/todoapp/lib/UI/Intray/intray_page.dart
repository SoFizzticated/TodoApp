import 'package:flutter/material.dart';
import 'package:todoapp/models/classes/todo_item.dart';
import 'package:todoapp/models/global.dart';
import 'package:todoapp/models/widgets/intray_todo_widget.dart';

class IntrayPage extends StatefulWidget {
  @override
  _IntrayPageState createState() => _IntrayPageState();
}

// Home tab
class _IntrayPageState extends State<IntrayPage> {
  List<Task> taskList = [];

  @override
  Widget build(BuildContext context) {
    // Fill list before creating reorderable list
    taskList = getList();
    return Container(
      color: darkGreyColor,
      child: _buildReorderableListSimple(context),
      /*
      child: ReorderableListView(
        // 160 from card, extra 20 for margin
        padding: EdgeInsets.only(top: 180),
        children: todoItems,
        onReorder: _onReorder,
      ),
      */
    );
  }

  Widget _buildListTile(BuildContext context, Task item) {
    return ListTile(
      key: Key(item.taskId),
      title: IntrayTodo(
        title: item.title,
      ),
    );
  }

  Widget _buildReorderableListSimple(BuildContext context) {
    return Theme(
      data: ThemeData(canvasColor: Colors.transparent),
      child: ReorderableListView(
        // handleSide: ReorderableListSimpleSide.Right,
        // handleIcon: Icon(Icons.access_alarm),
        padding: EdgeInsets.only(top: 300.0),
        children:
            taskList.map((Task item) => _buildListTile(context, item)).toList(),
        onReorder: (oldIndex, newIndex) {
          setState(() {
            Task item = taskList[oldIndex];
            taskList.remove(item);
            taskList.insert(newIndex, item);
          });
        },
      ),
    );
  }

  // ReorderableListView onReorder handler
  /*
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final Task item = this.taskList.removeAt(oldIndex);
      this.taskList.insert(newIndex, item);
    });
  }
  */

  // Return all IntrayTodos
  List<Task> getList() {
    for (int i = 1; i < 5; i++) {
      taskList.add(Task("My first todo " + i.toString(), false, i.toString()));
    }
    return taskList;
  }
}
