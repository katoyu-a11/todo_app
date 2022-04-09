import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class Todo{
  final String id;
  final String title;
  final DateTime date;
  final String description;
  final String? url;
  final bool done;

  Todo({required this.id,required this.title,required this.date,required this.description,this.url,required this.done});

}

class TodoProvider{
  Database? db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute();
        });
  }

  Future<Todo> insert(Todo todo) async{
  }
}