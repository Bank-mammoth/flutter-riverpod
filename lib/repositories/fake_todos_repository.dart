import 'dart:math';

import 'package:todo_riverpod_sync/models/todo_model.dart';
import 'package:todo_riverpod_sync/repositories/todos_repository.dart';

final initialTodos = [
  {"id": '1', "desc": 'clean the room', "completed": false},
  {"id": '2', "desc": 'Wash the dish', "completed": false},
  {"id": '3', "desc": 'Do homework', "completed": false},
  {"id": '4', "desc": 'Read cartoon', "completed": false},
  {"id": '5', "desc": 'Make Dinner', "completed": false},
];

//add delay
const double kProbabiltyOfError = 0.5;
const int kDelayDuration = 1;

class FakeTodoRepositoty extends TodosRepository {
  List<Map<String, dynamic>> fakeTodos = initialTodos;
  final Random random = Random();

  Future<void> waitSeconds() {
    return Future.delayed(const Duration(seconds: kDelayDuration));
  }

  

  @override
  Future<void> addTodo({required Todo todo}) async {
    await waitSeconds();
    try {
      if (random.nextDouble() < kProbabiltyOfError) {
        throw 'Fail to add todos';
      }
      fakeTodos = [...fakeTodos, todo.toJson()];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> editTodo({required String id, required String desc}) async {
    await waitSeconds();
    try {
      if (random.nextDouble() < kProbabiltyOfError) {
        throw 'Fail to editTodo todos';
      }
      fakeTodos = [
        for (final todo in fakeTodos)
          if (todo['id'] == id)
            {'id': id, 'desc': desc, 'completed': todo['completed']}
          else
            todo
      ];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Todo>> getTodos() async {
    await waitSeconds();
    try {
      if (random.nextDouble() < kProbabiltyOfError) {
        throw 'Fail to retrieve todos';
      }
      return [for (final todo in fakeTodos) Todo.fromJson(todo)];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> toggleTodo({required String id}) async {
    await waitSeconds();
    try {
      if (random.nextDouble() < kProbabiltyOfError) {
        throw 'Fail to retrieve todos';
      }
      fakeTodos = [
        for (final todo in fakeTodos)
          if (todo['id'] == id)
            {'id': id, 'desc': todo['desc'], 'completed': !todo['completed']}
          else
            todo
      ];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeTodo({required String id}) async {
    await waitSeconds();
    try {
      if (random.nextDouble() < kProbabiltyOfError) {
        throw 'Fail to retrieve todos';
      }
      fakeTodos = [
        for (final todo in fakeTodos)
          if (todo['id'] != id) todo
      ];
    } catch (e) {
      rethrow;
    }
  }
}
