class Setting{
  final bool isDarkMode;
  final bool dailyReminder;

  Setting({
    required this.isDarkMode,
    required this.dailyReminder,
  });

  Setting copyWith({
    bool? isDarkMode,
    bool? dailyReminder,
  }) {
    return Setting(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      dailyReminder: dailyReminder ?? this.dailyReminder,
    );
  }
}