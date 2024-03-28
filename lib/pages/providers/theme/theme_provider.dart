import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod_sync/pages/providers/theme/theme_state.dart';
part 'theme_provider.g.dart';


@riverpod
class Theme extends _$Theme {
  @override
  ThemeState build() {
    return LightTheme();
  }

  void toggleThem(){
    state = state is LightTheme ? DarkTheme():LightTheme();
  }
}

















// part 'theme_provider.g.dart';

// enum AppTheme{
//   ligth,
//   dark
// }

// @riverpod
// class ThemeProvider extends _$ThemeProvider {
//   @override
//   AppTheme build() {
//     return AppTheme.ligth;
//   }

//   void toggleThem(){
//     state = state == AppTheme.ligth ? AppTheme.dark:AppTheme.ligth;
//   }
// }