import 'package:brainbox/helpers/show_snackbar.dart';
import 'package:brainbox/models/todo_model.dart';
import 'package:brainbox/services/todo_service.dart';
import 'package:brainbox/utils/router.dart';
import 'package:brainbox/widgets/todo_card.dart';
import 'package:flutter/material.dart';

class CompletedTab extends StatefulWidget {
  final List<ToDo> completeToDos;
  const CompletedTab({super.key, required this.completeToDos});

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  //handle mark as done
  void _markAsUnDone(ToDo toDo) async {
    try {
      //updated todo
      final ToDo updatedToDo = ToDo(
        id: toDo.id,
        title: toDo.title,
        date: toDo.date,
        time: toDo.time,
        isDone: false,
      );
      await ToDoService().markAsDone(updatedToDo);

      //show snackbar
      AppHelpers.showSnackBar(context, "Marked as UnDone");
      setState(() {
        widget.completeToDos.remove(toDo);
      });
      AppRouter.router.go("/todos");
    } catch (e) {
      //show snackbar
      AppHelpers.showSnackBar(context, "Failed to mark as UnDone");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: widget.completeToDos.length,
              itemBuilder: (context, index) {
                final ToDo toDo = widget.completeToDos[index];
                return Dismissible(
                  key: Key(toDo.id.toString()),
                  onDismissed: (direction) {
                    setState(() {
                      widget.completeToDos.removeAt(index);
                      ToDoService().deleteTodo(toDo);
                    });
                    AppHelpers.showSnackBar(context, "Deleted");
                  },
                  child: TodoCard(
                    toDo: toDo,
                    isComplete: true,
                    onCheckBoxChanged: () => _markAsUnDone(toDo),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
