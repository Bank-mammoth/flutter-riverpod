
import 'package:todo_riverpod_sync/models/todo_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_filter_provider.g.dart';

@riverpod
class TodoFilter extends _$TodoFilter {
  //เปลี่ยนสถานะ ใน button Filter 
  @override
  Filter build() {
    return Filter.all;
  }

  void changeFilter (Filter newFilter){
    state = newFilter;
  }
}