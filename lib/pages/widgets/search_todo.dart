
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod_sync/pages/providers/todo_search/todo_search.dart';
import 'package:todo_riverpod_sync/utils/debounce.dart';

class SearchTodo extends ConsumerStatefulWidget {
  const SearchTodo({super.key});

  @override
  ConsumerState<SearchTodo> createState() => _SearchTodoState();
}

class _SearchTodoState extends ConsumerState<SearchTodo> {
  final debounce = Debounce(millisecond: 1000);

  @override
  void dispose() {
    debounce.close();
    super.dispose();
  }
@override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Search todos... ',
        filled: true,
        prefixIcon: Icon(Icons.search),
        
      ),
      onChanged: (String? newSearchTerm){
        if(newSearchTerm != null){
         debounce.run(() { 
            ref.read(todoSearchProvider.notifier).setSearchTerm(newSearchTerm);
         });
        }
      },
    );
  }
}