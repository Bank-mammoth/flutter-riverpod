import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod_sync/models/todo_model.dart';

part 'todo_item_provider.g.dart';
//ทำเพื่อให้สามารถดึงmodel Todo ไปใช้ได้ทุกหน้าโดยไม่ต้องเรียกผ่าน paramiter
@Riverpod(dependencies: [])
Todo todoItem(TodoItemRef ref) {
  throw UnimplementedError();
}



