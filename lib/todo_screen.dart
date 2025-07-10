import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_to_do/add_todo.dart';
import 'package:simple_to_do/details_screen.dart';
import 'package:simple_to_do/todo.dart';

class TodoScreen extends StatefulWidget {
  final List<Todo> todos = [];

  TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  SharedPreferences? _prefs;

  List<String> savedTodo = List.empty(growable: true);

  List<Todo> todos = [];
  
  List<String>? get fromMem => null;

  @override
  void initState() {
    deserializeTODO();
    super.initState();
    _initializePrefs();
  }

  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    var fromMem = _prefs?.getStringList("TODO");
    if (fromMem != null) {
      todos.clear();
      savedTodo = fromMem;
      for (int i = 0; i < savedTodo.length; i++) {
        Todo todo = Todo.fromJson(json.decode(savedTodo[i]));
        todos.add(todo);
      }
      setState(() {});
    }
  }

  Future<void> serializeTODO() async {
    // savedTodo.clear();
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < widget.todos.length; i++) {
      String todo = json.encode(widget.todos[i]);
      savedTodo.add(todo);
    }
    await prefs?.setStringList("TODO", savedTodo);
  }

  Future<void> deserializeTODO() async {
    var fromMem = _prefs?.getStringList("TODO");
    if (fromMem != null) {
      print(fromMem.length);
      savedTodo = fromMem;
      todos.clear();
      for (int i = 0; i < savedTodo.length; i++) {
        print(savedTodo[i]);
        Todo todo = Todo.fromJson(json.decode(savedTodo[i]));
        setState(() {
          todos.add(todo);
        });
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: 
        todos.isEmpty 
            ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 90),
                  Icon(
                    Icons.space_bar_rounded,
                    size: 150,
                    color: Colors.deepPurpleAccent,
                  ),
                  Text(
                    "There are no TODOs, click the plus button to add one.", 
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ) 
            : ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(todos[index].title),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailScreen(),
                      settings: RouteSettings(arguments: todos[index]),
                    ),
                  );
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              _navigateAndDisplayAddTodo(context);
            },
            child: const Icon(Icons.add),
          ),
    );
  }
  Future<void>_navigateAndDisplayAddTodo(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTodo()),
    );

    if(!context.mounted) return;

    if(result != null && result is Todo){
      setState(() {
        todos.add(result);
        serializeTODO();
      });

    }
  }
}


