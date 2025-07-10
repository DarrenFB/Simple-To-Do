// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:simple_to_do/todo.dart';
import 'package:simple_to_do/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple To-Do',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true, 
      ),
      home: TodoScreen(),
    );
  }
}
