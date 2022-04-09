import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todo.dart';

class TodoProvider with ChangeNotifier {
  TodoProvider({
    required this.database,
    this.todoList = const [],
}) {
    initialize();
  }

  final Database database;
  late List<Todo> todoList;

  Future<void> initialize() async {
    todoList = await getTodoList(database);
  }

  Future<List<Todo>> getTodoList(
      Database database,
      ) async {
    final List<Map<String, dynamic>> maps = await database.query('todo');
    return List.generate(maps.length, (i) {
      return Todo(
        id : maps[i]['id'],
        title: maps[i]['title'],
        deadline: maps[i]['deadline'],
        description: maps[i]['description'],
        imagePath: maps[i]['imagePath'],
        done: maps[i]['done'],
      );
    });
  }

  Future<void> addTodo(Todo todo) async {
    todoList.add(todo);

    await database.insert(
      'todo',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  Future<void> updateTodo(
      Todo newTodo,
      ) async {
    final index = todoList.indexWhere((todo) => todo.id == newTodo.id);
    todoList[index] = newTodo;

    await database.update('todo',
        newTodo.toMap(),
    where: 'id = ?',
    whereArgs: [newTodo.id],
    );
    notifyListeners();
  }

  Future<void> deleteTodo(int targetTodoId) async {
    final existingTodoIndex =
        todoList.indexWhere((todo) => todo.id == targetTodoId);
    todoList.removeAt(existingTodoIndex);

    await database.delete(
      'todo',
      where: 'id = ?',
      whereArgs: [targetTodoId],
    );
    notifyListeners();
  }
}