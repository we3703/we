import 'package:flutter/material.dart';
import 'package:we/presentation/screens/auth/login_screen.dart';
import 'package:we/presentation/screens/auth/signup_screen.dart';
import 'package:we/presentation/screens/main/home_screen.dart';
import 'package:we/presentation/screens/main/main_scaffold.dart';
import 'package:we/presentation/screens/main/my_page_screen.dart';
import 'package:we/presentation/screens/main/product_list_screen.dart';
import 'package:we/presentation/screens/main/recommendation_screen.dart';
import 'package:we/presentation/screens/notice/notice_list_screen.dart';
import 'package:we/presentation/screens/points/point_management_screen.dart';
import 'package:we/presentation/screens/user/purchase_history_screen.dart';
import 'package:we/presentation/screens/user/user_info_edit_screen.dart';
import 'package:we/presentation/screens/notification/notification_screen.dart';
import 'package:we/presentation/screens/user/my_product_management_screen.dart';
import 'package:we/presentation/screens/referral/referral_tree_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes {
    return {
      LoginScreen.routeName: (context) => const LoginScreen(),
      SignUpScreen.routeName: (context) => const SignUpScreen(),
      MainScaffold.routeName: (context) => const MainScaffold(),
      HomeScreen.routeName: (context) => const HomeScreen(),
      ProductListScreen.routeName: (context) => const ProductListScreen(),
      RecommendationScreen.routeName: (context) => const RecommendationScreen(),
      MyPageScreen.routeName: (context) => const MyPageScreen(),
      NoticeListScreen.routeName: (context) => const NoticeListScreen(),
      NotificationScreen.routeName: (context) => const NotificationScreen(),
      MyProductManagementScreen.routeName: (context) =>
          const MyProductManagementScreen(),
      PointManagementScreen.routeName: (context) =>
          const PointManagementScreen(),
      PurchaseHistoryScreen.routeName: (context) =>
          const PurchaseHistoryScreen(),
      UserInfoEditScreen.routeName: (context) => const UserInfoEditScreen(),
      ReferralTreeScreen.routeName: (context) => const ReferralTreeScreen(),
    };
  }
}
