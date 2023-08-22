import 'my_colors.dart';

class AppTheme {
  static MyColors myColors = MyColorsLight();

  static void changeTheme(bool isLight) {
    isLight ? myColors = MyColorsLight() : myColors = MyColorsDark();
  }
}
