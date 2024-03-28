import 'dart:ffi';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod_sync/models/todo_model.dart';
import 'package:todo_riverpod_sync/repositories/providers/todos_repository_provider.dart';

part 'todo_list_provider.g.dart';

@riverpod
class TodoList extends _$TodoList {
  @override
  FutureOr<List<Todo>> build() {
    print('[todoListProvider] initialized');
    ref.onDispose(() {
      print(' [todoListProvider]  Dispose');
    });
    return _getTodos();
  }



  // ==========[เรียกรายการจาก API]==========
  Future<List<Todo>> _getTodos() async {
    return ref.read(todoRepositoryProvider).getTodos();
  }  //========================================






  // ==========[add product to API]==========
  Future<void> addTodo(String desc) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      // AsyncValue.guard likes Try catch
      final newTodo = Todo.add(desc: desc);
      await ref.read(todoRepositoryProvider).addTodo(todo: newTodo);
      return [...state.value!, newTodo];
    });
  }  //========================================




  //==============[edit Product]===============
  void editTodo({required String id, required String desc}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(todoRepositoryProvider).editTodo(id: id, desc: desc);
      return [
        for (final todo in state.value!)
          if (todo.id == id) todo.copyWith(desc: desc) else todo
      ];
    });
  }  //========================================




  //==========[เปลี่ยนสถานะ product]==========
  void toggleTodo(String id) async {
    state = const AsyncLoading();
     state = await AsyncValue.guard(() async{
        await ref.read(todoRepositoryProvider).toggleTodo(id: id);
        return [for (final todo in state.value!)
          if (todo.id == id) todo.copyWith(completed: !todo.completed) else todo];
     },);
  }//======================================
  




  //==========[ลบ Product]==========
  void removeTodo(String id) async {
    state = const AsyncLoading();
     state = await AsyncValue.guard(() async{
       await ref.read(todoRepositoryProvider).removeTodo(id: id);
       return [
        for (final todo in state.value!)
          if (todo.id != id) todo
      ];
     },);
  }//==============================
  
}


