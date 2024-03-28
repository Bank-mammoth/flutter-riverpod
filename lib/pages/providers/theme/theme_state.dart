sealed class ThemeState{
  ThemeState();
}

final class LightTheme extends ThemeState{
  @override
  String toString()=> 'LightTheme';
}

final class DarkTheme extends ThemeState{
  @override
  String toString ()=> 'DarkTheme';
}