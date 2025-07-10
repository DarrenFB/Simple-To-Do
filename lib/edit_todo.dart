// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:simple_to_do/todo.dart';

class EditTodo extends StatefulWidget {
  const EditTodo({super.key});

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  
  String title = "";
  String description = "";
  TextEditingController titleEdit = TextEditingController();
  TextEditingController descEdit = TextEditingController();

  late Todo todo;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    todo = ModalRoute.of(context)!.settings.arguments as Todo;
    titleEdit.text = todo.title;
    descEdit.text = todo.description;
    return Scaffold(
      appBar: AppBar(title: const Text("Add Todo")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add Title",
              ),
              onChanged: (value) {
                title = value;
              },
              onEditingComplete: () {
                print("Done. . .");
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add Description",
              ),
              onChanged: (value) {
                description = value;
              },
              onEditingComplete: () {
                print("Done. . .");
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed:() {
              if(title.isEmpty || description.isEmpty) {
                ScaffoldMessenger.of(context)
                ..removeCurrentMaterialBanner()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      "Please enter a title and description for your TODO",
                    ),
                  ),
                );
              } else {
                Todo updatedTodo = editTodo(title, description, false, todo.id as int);
                Navigator.pop(context, updatedTodo);
              }
            }, child: Text("Add TODO")),
          ],),
      )
    );
  }

  Todo editTodo(String title, String description, bool done, int id) {
    return Todo(
      title: title,
      description: description,
      done: done,
      id: id.toString(),
    );
  }
}
