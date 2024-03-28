import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:todo_riverpod_sync/models/todo_model.dart';
import 'package:todo_riverpod_sync/pages/providers/theme/theme_provider.dart';
import 'package:todo_riverpod_sync/pages/providers/theme/theme_state.dart';
import 'package:todo_riverpod_sync/pages/providers/todo_list/todo_list_provider.dart';

class TodoHeader extends ConsumerStatefulWidget {
  const TodoHeader({super.key});

  


  @override
  ConsumerState<TodoHeader> createState() => _TodoHeaderState();
}

class _TodoHeaderState extends ConsumerState<TodoHeader> {
  Widget prevTodoCountWidget = const SizedBox.shrink();

  Widget getActiveTodoCount (List<Todo> todos){
    final totalCount = todos.length;
    final activeTodoCount = todos.where((todo) => !todo.completed).toList().length;

    prevTodoCountWidget = Text(
              '($activeTodoCount/ $totalCount item${activeTodoCount != 1 ? "s" : ""} left)',
              style: const TextStyle(fontSize: 15.0, color: Colors.blueAccent),
            );

        return prevTodoCountWidget;
  }



@override
  Widget build(BuildContext context) {
    // final activeTodoCount = ref.watch(activeTodoCountProvider);
    
    final currenIconTheme = ref.watch(themeProvider);
    final todoListState = ref.watch(todoListProvider);
    // final activeTodoCount = getActiveTodoCount(todoListState.todo);


    todoListState.maybeWhen(
    
      skipLoadingOnRefresh: false,
      loading: () {
        context.loaderOverlay.show();
      },
      orElse: () {
        context.loaderOverlay.hide();
      },
    );

    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text(
              'TODO',
              style: TextStyle(fontSize: 36.0),
            ),
            const SizedBox(
              width: 10,
            ),
            todoListState.maybeWhen(
              data: (List<Todo> todo) => getActiveTodoCount(todo),
              orElse: () => prevTodoCountWidget,)
            
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed:  () {
                  ref.read(themeProvider.notifier).toggleThem();
                },
                icon: currenIconTheme is LightTheme
                    ? const Icon(Icons.sunny)
                    : const Icon(Icons.nightlight)),
                    IconButton(
                onPressed:() {
                  ref.invalidate(todoListProvider);
                },
                icon: 
                     const Icon(Icons.refresh),),
                
          ],
        )
      ],
    );
  }
}
