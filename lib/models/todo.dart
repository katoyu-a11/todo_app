import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class Todo{
  final int id;
  final String title;
  final String deadline;
  final String description;
  final String imagePath;
  final int done;

  Todo({required this.id,
        required this.title,
        required this.deadline,
        required this.description,
        this.imagePath='',
        this.done=0
  });

  Todo copyWith({int? id,
                 String? title,
                 String? deadline,
                 String? description,
                 String? imagePath,
                 int? done
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      deadline: deadline ?? this.deadline,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      done: done ?? this.done
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'title': title,
      'deadline' :deadline,
      'description': description,
      'imagePath': imagePath,
      'done': done
    };
  }

  @override
  String toString() {
    return 'Todo{'
        'id: $id'
        'title: $title'
        'deadline: $deadline'
        'description: $description'
        'imagePath: $imagePath'
        'done: $done}';
  }
}

