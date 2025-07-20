import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:simple_to_do/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> serializeTODO(List<String> savedTodo, List<Todo> todos) async {
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