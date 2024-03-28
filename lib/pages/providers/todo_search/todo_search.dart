import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_search.g.dart';

@riverpod
class TodoSearch extends _$TodoSearch {
  //ตามชื่อ คือ ค้นหา iTem
  @override
   String build() {
    return '';
  }

  void setSearchTerm(String newSearchTerm){
    state = newSearchTerm;
  }
}