enum ThemeState {
  light,
  dark;

  bool get isDark => this == ThemeState.dark;
}

extension BoolExtension on bool{
  ThemeState get isEnable =>
      this == true ? ThemeState.dark : ThemeState.light;
}