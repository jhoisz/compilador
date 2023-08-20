import 'my_colors.dart';

class AppTheme {
  static MyColors myColors = MyColorsDark();

  static void changeTheme(bool isDark) {
    isDark ? myColors = MyColorsDark() : myColors = MyColorsLight();
  }
}
