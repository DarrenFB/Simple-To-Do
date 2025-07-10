import 'package:flutter/material.dart';
import 'package:simple_to_do/edit_todo.dart';
import 'package:simple_to_do/todo.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  
  late Todo todo;

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(todo.title),),
      body: Padding(padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        Text(todo.description),
        ElevatedButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => const EditTodo(),
            settings: RouteSettings(arguments: todo)
          )).then((value) {
            if(value != null && value is Todo) {
              setState(() {
                todo = value;
              });
            }
          });
        }, child: Text("Edit TODO"))
        ]
        )
      )
    );
  }
}