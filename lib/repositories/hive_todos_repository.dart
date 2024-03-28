import 'dart:math';

import 'package:hive/hive.dart';
import 'package:todo_riverpod_sync/models/todo_model.dart';
import 'package:todo_riverpod_sync/repositories/todos_repository.dart';



//add delay
const double kProbabiltyOfError = 0.5;
const int kDelayDuration = 1;

class HiveTodoRepositoty extends TodosRepository {
  final Box todoBox = Hive.box('todo');
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

      await todoBox.put(todo.id, todo.toJson());

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
      final todoMap = todoBox.get(id);
      todoMap['desc'] = desc;
      await todoBox.put(id, todoMap);

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

      if(todoBox == 0 ) return [];


      return [for (final todo in todoBox.values ) Todo.fromJson(Map<String, dynamic>.from(todo))];
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
        final todoMap = todoBox.get(id);
        todoMap['completed'] = !todoMap['completed'];
        await todoBox.put(id, todoMap);
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
      await todoBox.delete(id);
    } catch (e) {
      rethrow;
    }
  }
}
