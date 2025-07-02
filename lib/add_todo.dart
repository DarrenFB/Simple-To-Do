import 'package:flutter/material.dart';
import 'package:simple_to_do/todo.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {

  String title = "";
  String description = "";
  @override
  Widget build(BuildContext context) {
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
                Todo todo = Todo(title, description, false);
                Navigator.pop(context, todo);
              }
            }, child: Text("Add TODO")),
          ],),
      )
    );
  }
}

