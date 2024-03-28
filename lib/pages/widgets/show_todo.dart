import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod_sync/models/todo_model.dart';
import 'package:todo_riverpod_sync/pages/providers/todo_filter/todo_filter_provider.dart';
import 'package:todo_riverpod_sync/pages/providers/todo_item/todo_item_provider.dart';
import 'package:todo_riverpod_sync/pages/providers/todo_list/todo_list_provider.dart';
import 'package:todo_riverpod_sync/pages/providers/todo_search/todo_search.dart';
import 'package:todo_riverpod_sync/pages/widgets/todo_item.dart';

class ShowTodos extends ConsumerStatefulWidget {
  const ShowTodos({super.key});

  @override
  ConsumerState<ShowTodos> createState() => _ShowTodosState();
}

class _ShowTodosState extends ConsumerState<ShowTodos> {
  Widget prevTodoWidget = const SizedBox.shrink();

  List<Todo> filterTodos(List<Todo> allTodos) {
    final filter = ref.watch(todoFilterProvider);
    final search = ref.watch(todoSearchProvider);

    List<Todo> tempTodos;

    tempTodos = switch (filter) {
      Filter.active => allTodos.where((todo) => !todo.completed).toList(),
      Filter.completed => allTodos.where((todo) => todo.completed).toList(),
      Filter.all => allTodos,
    };

    if (search.isNotEmpty) {
      tempTodos = tempTodos
          .where(
              (todo) => todo.desc.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }

    return tempTodos;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<List<Todo>>>(todoListProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          if (!next.isLoading) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                    'Error',
                    textAlign: TextAlign.center,
                  ),
                  content: Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            );
          }
        },
      );
    });

    final todoListState = ref.watch(todoListProvider);

    return todoListState.when(
      skipError: true,
      data: (List<Todo> allTodos) {
        if (allTodos.isEmpty) {
          prevTodoWidget = const Center(
            child: Text(
              'write somthing... ',
              style: TextStyle(fontSize: 20),
            ),
          );
          return prevTodoWidget;
        }
        final filteredTodos = filterTodos(allTodos);

        prevTodoWidget = ListView.separated(
          itemBuilder: (context, index) {
            final todo = filteredTodos[index];
            return ProviderScope(
                overrides: [todoItemProvider.overrideWithValue(todo)],
                child: const TodoItem());
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.grey,
            );
          },
          itemCount: filteredTodos.length,
        );
        return prevTodoWidget;
      },
      error: (error, stackTrace) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                error.toString(),
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                  onPressed: () {
                    // ref.read(todoListProvider.notifier).getTodos();
                    //changed to
                    ref.invalidate(todoListProvider);
                  },
                  child: const Text(
                    'Please Retry!',
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ),
        );
      },
      loading: () {
        return prevTodoWidget;
      },
    );
  }
}
