import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_riverpod_sync/pages/providers/theme/theme_provider.dart';
import 'package:todo_riverpod_sync/pages/providers/theme/theme_state.dart';
import 'package:todo_riverpod_sync/repositories/fake_todos_repository.dart';
import 'package:todo_riverpod_sync/repositories/hive_todos_repository.dart';
import 'package:todo_riverpod_sync/repositories/providers/todos_repository_provider.dart';

import 'pages/todos_page.dart';

void main() async{
  await Hive.initFlutter();
  await Hive.openBox('todo');
  
  runApp(
    ProviderScope(
      overrides: [
        // todoRepositoryProvider.overrideWithValue(FakeTodoRepositoty()) 
         todoRepositoryProvider.overrideWithValue(HiveTodoRepositoty())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currenTheme = ref.watch(themeProvider);
    return MaterialApp(
      title: 'Todos',
      debugShowCheckedModeBanner: false,
      theme: currenTheme is LightTheme
          ? ThemeData.light(useMaterial3: true)
          : ThemeData.dark(useMaterial3: true),
      home: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: const TodosPage()),
    );
  }
}
