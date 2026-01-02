import 'package:flutter/material.dart';
import 'package:we/features/auth/screen/login_screen.dart';
import 'package:we/features/auth/screen/signup_screen.dart';
import 'package:we/features/main/screen/main_scaffold.dart';
import 'package:we/presentation/screens/admin/admin_scaffold.dart';
import 'package:we/presentation/screens/admin/product/admin_product_form_screen.dart';
import 'package:we/presentation/screens/notice/notice_list_screen.dart';
import 'package:we/presentation/screens/points/point_management_screen.dart';
import 'package:we/presentation/screens/user/purchase_history_screen.dart';
import 'package:we/presentation/screens/user/user_info_edit_screen.dart';
import 'package:we/presentation/screens/user/my_product_management_screen.dart';
import 'package:we/presentation/screens/referral/referral_tree_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes {
    return {
      LoginScreen.routeName: (context) => const LoginScreen(),
      SignupScreen.routeName: (context) => const SignupScreen(),
      MainScaffold.routeName: (context) => const MainScaffold(),
      AdminScaffold.routeName: (context) => const AdminScaffold(),
      AdminProductFormScreen.routeName: (context) =>
          const AdminProductFormScreen(),
      NoticeListScreen.routeName: (context) => const NoticeListScreen(),
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
