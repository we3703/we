// icon, image path
class AppConstant {
  static const String logoPath = "assets/Logo.svg";
  static const String iconPath = "assets/icons";
  static const String imagePath = "assets/images";

  static const String checkIcon = "$iconPath/check.svg";
  static const String backIcon = "$iconPath/back.svg";
  static const String searchIcon = "$iconPath/search.svg";

  static const String background = "$imagePath/background.png";
  static String banner1 = "$imagePath/banner1.png";
  static String banner2 = "$imagePath/banner2.png";
  static String banner3 = "$imagePath/banner3.png";

  static List<String> get banners => [banner1, banner2, banner3];
}
