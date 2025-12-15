import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:we/core/auth/token_provider.dart';
import 'package:we/core/config/http_client.dart';
import 'package:we/data/api/auth/auth_api.dart';
import 'package:we/data/api/auth/license_api.dart';
import 'package:we/data/api/order/order_api.dart';
import 'package:we/data/api/user/user_api.dart';
import 'package:we/data/api/product/product_api.dart';
import 'package:we/data/api/notice/notice_api.dart';
import 'package:we/data/api/points/points_api.dart';
import 'package:we/data/api/referrals/referrals_api.dart';
import 'package:we/data/api/product/cart_api.dart';
import 'package:we/data/api/admin/admin_notice_api.dart';
import 'package:we/data/api/admin/admin_order_api.dart';
import 'package:we/data/api/admin/admin_referrals_api.dart';
import 'package:we/data/api/admin/admin_user_api.dart';
import 'package:we/data/repositories/admin/admin_notice_repository_impl.dart';
import 'package:we/data/repositories/admin/admin_order_repository_impl.dart';
import 'package:we/data/repositories/admin/admin_referral_repository_impl.dart';
import 'package:we/data/repositories/admin/admin_user_repository_impl.dart';
import 'package:we/data/repositories/auth/auth_repository_impl.dart';
import 'package:we/data/repositories/auth/license_repository_impl.dart';
import 'package:we/data/repositories/cart/cart_repository_impl.dart';
import 'package:we/data/repositories/notice/notice_repository_impl.dart';
import 'package:we/data/repositories/order/order_repository_impl.dart';
import 'package:we/data/repositories/points/points_repository_impl.dart';
import 'package:we/data/repositories/product/product_repository_impl.dart';
import 'package:we/data/repositories/referrals/referral_repository_impl.dart';
import 'package:we/data/repositories/user/user_repository_impl.dart';
import 'package:we/domain/repositories/admin/admin_notice_repository.dart';
import 'package:we/domain/repositories/admin/admin_order_repository.dart';
import 'package:we/domain/repositories/admin/admin_referral_repository.dart';
import 'package:we/domain/repositories/admin/admin_user_repository.dart';
import 'package:we/domain/repositories/auth/auth_repository.dart';
import 'package:we/domain/repositories/auth/license_repository.dart';
import 'package:we/domain/repositories/cart/cart_repository.dart';
import 'package:we/domain/repositories/notice/notice_repository.dart';
import 'package:we/domain/repositories/order/order_repository.dart';
import 'package:we/domain/repositories/points/points_repository.dart';
import 'package:we/domain/repositories/product/product_repository.dart';
import 'package:we/domain/repositories/referrals/referral_repository.dart';
import 'package:we/domain/repositories/user/user_repository.dart';
import 'package:we/domain/use_cases/admin/notice/create_admin_notice_use_case.dart';
import 'package:we/domain/use_cases/admin/notice/delete_admin_notice_use_case.dart';
import 'package:we/domain/use_cases/admin/notice/update_admin_notice_use_case.dart';
import 'package:we/domain/use_cases/admin/order/get_admin_orders_use_case.dart';
import 'package:we/domain/use_cases/admin/referral/get_admin_user_referral_tree_use_case.dart';
import 'package:we/domain/use_cases/admin/user/get_admin_users_use_case.dart';
import 'package:we/domain/use_cases/auth/change_password_use_case.dart';
import 'package:we/domain/use_cases/auth/login_use_case.dart';
import 'package:we/domain/use_cases/auth/logout_use_case.dart';
import 'package:we/domain/use_cases/auth/refresh_token_use_case.dart';
import 'package:we/domain/use_cases/auth/send_code_use_case.dart';
import 'package:we/domain/use_cases/auth/signup_use_case.dart';
import 'package:we/domain/use_cases/auth/verify_code_use_case.dart';
import 'package:we/domain/use_cases/cart/add_cart_item_use_case.dart';
import 'package:we/domain/use_cases/cart/delete_cart_item_use_case.dart';
import 'package:we/domain/use_cases/cart/get_cart_use_case.dart';
import 'package:we/domain/use_cases/cart/update_cart_item_use_case.dart';
import 'package:we/domain/use_cases/notice/get_notice_detail_use_case.dart';
import 'package:we/domain/use_cases/notice/get_notices_use_case.dart';
import 'package:we/domain/use_cases/order/create_order_use_case.dart';
import 'package:we/domain/use_cases/order/get_my_orders_use_case.dart';
import 'package:we/domain/use_cases/points/get_points_history_use_case.dart';
import 'package:we/domain/use_cases/points/get_recharge_history_use_case.dart';
import 'package:we/domain/use_cases/points/recharge_points_fail_use_case.dart';
import 'package:we/domain/use_cases/points/recharge_points_success_use_case.dart';
import 'package:we/domain/use_cases/points/recharge_points_use_case.dart';
import 'package:we/domain/use_cases/product/create_product_use_case.dart';
import 'package:we/domain/use_cases/product/delete_product_use_case.dart';
import 'package:we/domain/use_cases/product/get_product_detail_use_case.dart';
import 'package:we/domain/use_cases/product/get_products_use_case.dart';
import 'package:we/domain/use_cases/product/update_product_use_case.dart';
import 'package:we/domain/use_cases/referrals/get_referral_summary_use_case.dart';
import 'package:we/domain/use_cases/referrals/get_referral_tree_use_case.dart';
import 'package:we/domain/use_cases/user/get_me_use_case.dart';
import 'package:we/domain/use_cases/user/update_me_use_case.dart';
import 'package:we/presentation/screens/admin/notice/admin_notice_view_model.dart';
import 'package:we/presentation/screens/admin/order/admin_order_view_model.dart';
import 'package:we/presentation/screens/admin/product/admin_product_view_model.dart';
import 'package:we/presentation/screens/admin/referral/admin_referral_view_model.dart';
import 'package:we/presentation/screens/admin/user/admin_user_view_model.dart';
import 'package:we/presentation/screens/auth/login_view_model.dart';
import 'package:we/presentation/screens/auth/signup_view_model.dart';
import 'package:we/presentation/screens/cart/cart_view_model.dart';
import 'package:we/presentation/screens/notice/notice_view_model.dart';
import 'package:we/presentation/screens/order/order_view_model.dart';
import 'package:we/presentation/screens/points/points_view_model.dart';
import 'package:we/presentation/screens/product/product_view_model.dart';
import 'package:we/presentation/screens/referral/referral_view_model.dart';
import 'package:we/presentation/screens/user/user_view_model.dart';

// 컴파일 타임 환경변수는 최상위 레벨에서 const로 선언
const String kApiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://healthon.store:81',
);

Future<List<SingleChildWidget>> setupProviders() async {
  // Core Dependencies
  final tokenProvider = TokenProvider();

  // Load tokens from storage before setting up the rest
  await tokenProvider.loadTokens();

  // 최상위 레벨에서 선언한 const 사용
  final httpClient = HttpClient(
    baseUrl: kApiBaseUrl,
    tokenProvider: tokenProvider,
  );

  return [
    ChangeNotifierProvider<TokenProvider>.value(value: tokenProvider),
    Provider<HttpClient>.value(value: httpClient),

    // APIs - Lazy initialization
    Provider<AuthApi>(create: (_) => AuthApi(httpClient)),
    Provider<LicenseApi>(create: (_) => LicenseApi(httpClient)),
    Provider<UserApi>(create: (_) => UserApi(httpClient)),
    Provider<ProductApi>(create: (_) => ProductApi(httpClient)),
    Provider<NoticeApi>(create: (_) => NoticeApi(httpClient)),
    Provider<PointsApi>(create: (_) => PointsApi(httpClient)),
    Provider<OrderApi>(create: (_) => OrderApi(httpClient)),
    Provider<ReferralsApi>(create: (_) => ReferralsApi(httpClient)),
    Provider<CartApi>(create: (_) => CartApi(httpClient)),
    Provider<AdminNoticeApi>(create: (_) => AdminNoticeApi(httpClient)),
    Provider<AdminOrderApi>(create: (_) => AdminOrderApi(httpClient)),
    Provider<AdminReferralsApi>(create: (_) => AdminReferralsApi(httpClient)),
    Provider<AdminUserApi>(create: (_) => AdminUserApi(httpClient)),

    // Repositories - Lazy initialization using ProxyProvider
    ProxyProvider<AuthApi, AuthRepository>(
      update: (_, authApi, __) => AuthRepositoryImpl(authApi, tokenProvider),
    ),
    ProxyProvider<UserApi, UserRepository>(
      update: (_, userApi, __) => UserRepositoryImpl(userApi),
    ),
    ProxyProvider<ProductApi, ProductRepository>(
      update: (_, productApi, __) => ProductRepositoryImpl(productApi),
    ),
    ProxyProvider<NoticeApi, NoticeRepository>(
      update: (_, noticeApi, __) => NoticeRepositoryImpl(noticeApi),
    ),
    ProxyProvider<PointsApi, PointsRepository>(
      update: (_, pointsApi, __) => PointsRepositoryImpl(pointsApi),
    ),
    ProxyProvider<OrderApi, OrderRepository>(
      update: (_, orderApi, __) => OrderRepositoryImpl(orderApi),
    ),
    ProxyProvider<ReferralsApi, ReferralRepository>(
      update: (_, referralsApi, __) => ReferralRepositoryImpl(referralsApi),
    ),
    ProxyProvider<CartApi, CartRepository>(
      update: (_, cartApi, __) => CartRepositoryImpl(cartApi),
    ),
    ProxyProvider<AdminNoticeApi, AdminNoticeRepository>(
      update: (_, adminNoticeApi, __) =>
          AdminNoticeRepositoryImpl(adminNoticeApi),
    ),
    ProxyProvider<AdminOrderApi, AdminOrderRepository>(
      update: (_, adminOrderApi, __) => AdminOrderRepositoryImpl(adminOrderApi),
    ),
    ProxyProvider<AdminReferralsApi, AdminReferralRepository>(
      update: (_, adminReferralsApi, __) =>
          AdminReferralRepositoryImpl(adminReferralsApi),
    ),
    ProxyProvider<AdminUserApi, AdminUserRepository>(
      update: (_, adminUserApi, __) => AdminUserRepositoryImpl(adminUserApi),
    ),

    // License Repository - needs special handling
    ProxyProvider<LicenseApi, LicenseRepository>(
      update: (_, licenseApi, __) => LicenseRepositoryImpl(licenseApi),
    ),

    // Use Cases (Auth) - Lazy initialization
    ProxyProvider<AuthRepository, LoginUseCase>(
      update: (_, authRepo, __) => LoginUseCase(authRepo),
    ),
    ProxyProvider<AuthRepository, SignupUseCase>(
      update: (_, authRepo, __) => SignupUseCase(authRepo),
    ),
    ProxyProvider<LicenseRepository, SendCodeUseCase>(
      update: (_, licenseRepo, __) => SendCodeUseCase(licenseRepo),
    ),
    ProxyProvider<LicenseRepository, VerifyCodeUseCase>(
      update: (_, licenseRepo, __) => VerifyCodeUseCase(licenseRepo),
    ),
    ProxyProvider<AuthRepository, RefreshTokenUseCase>(
      update: (_, authRepo, __) => RefreshTokenUseCase(authRepo),
    ),
    ProxyProvider<AuthRepository, ChangePasswordUseCase>(
      update: (_, authRepo, __) => ChangePasswordUseCase(authRepo),
    ),
    ProxyProvider<AuthRepository, LogoutUseCase>(
      update: (_, authRepo, __) => LogoutUseCase(authRepo),
    ),

    // Use Cases (User)
    ProxyProvider<UserRepository, GetMeUseCase>(
      update: (_, userRepo, __) => GetMeUseCase(userRepo),
    ),
    ProxyProvider<UserRepository, UpdateMeUseCase>(
      update: (_, userRepo, __) => UpdateMeUseCase(userRepo),
    ),

    // Use Cases (Product)
    ProxyProvider<ProductRepository, GetProductsUseCase>(
      update: (_, productRepo, __) => GetProductsUseCase(productRepo),
    ),
    ProxyProvider<ProductRepository, GetProductDetailUseCase>(
      update: (_, productRepo, __) => GetProductDetailUseCase(productRepo),
    ),
    ProxyProvider<ProductRepository, CreateProductUseCase>(
      update: (_, productRepo, __) => CreateProductUseCase(productRepo),
    ),
    ProxyProvider<ProductRepository, UpdateProductUseCase>(
      update: (_, productRepo, __) => UpdateProductUseCase(productRepo),
    ),
    ProxyProvider<ProductRepository, DeleteProductUseCase>(
      update: (_, productRepo, __) => DeleteProductUseCase(productRepo),
    ),

    // Use Cases (Order)
    ProxyProvider<OrderRepository, GetMyOrdersUseCase>(
      update: (_, orderRepo, __) => GetMyOrdersUseCase(orderRepo),
    ),
    ProxyProvider<OrderRepository, CreateOrderUseCase>(
      update: (_, orderRepo, __) => CreateOrderUseCase(orderRepo),
    ),

    // Use Cases (Notice)
    ProxyProvider<NoticeRepository, GetNoticesUseCase>(
      update: (_, noticeRepo, __) => GetNoticesUseCase(noticeRepo),
    ),
    ProxyProvider<NoticeRepository, GetNoticeDetailUseCase>(
      update: (_, noticeRepo, __) => GetNoticeDetailUseCase(noticeRepo),
    ),

    // Use Cases (Points)
    ProxyProvider<PointsRepository, RechargePointsUseCase>(
      update: (_, pointsRepo, __) => RechargePointsUseCase(pointsRepo),
    ),
    ProxyProvider<PointsRepository, RechargePointsSuccessUseCase>(
      update: (_, pointsRepo, __) => RechargePointsSuccessUseCase(pointsRepo),
    ),
    ProxyProvider<PointsRepository, RechargePointsFailUseCase>(
      update: (_, pointsRepo, __) => RechargePointsFailUseCase(pointsRepo),
    ),
    ProxyProvider<PointsRepository, GetRechargeHistoryUseCase>(
      update: (_, pointsRepo, __) => GetRechargeHistoryUseCase(pointsRepo),
    ),
    ProxyProvider<PointsRepository, GetPointsHistoryUseCase>(
      update: (_, pointsRepo, __) => GetPointsHistoryUseCase(pointsRepo),
    ),

    // Use Cases (Referrals)
    ProxyProvider<ReferralRepository, GetReferralTreeUseCase>(
      update: (_, referralRepo, __) => GetReferralTreeUseCase(referralRepo),
    ),
    ProxyProvider<ReferralRepository, GetReferralSummaryUseCase>(
      update: (_, referralRepo, __) => GetReferralSummaryUseCase(referralRepo),
    ),

    // Use Cases (Cart)
    ProxyProvider<CartRepository, AddCartItemUseCase>(
      update: (_, cartRepo, __) => AddCartItemUseCase(cartRepo),
    ),
    ProxyProvider<CartRepository, GetCartUseCase>(
      update: (_, cartRepo, __) => GetCartUseCase(cartRepo),
    ),
    ProxyProvider<CartRepository, UpdateCartItemUseCase>(
      update: (_, cartRepo, __) => UpdateCartItemUseCase(cartRepo),
    ),
    ProxyProvider<CartRepository, DeleteCartItemUseCase>(
      update: (_, cartRepo, __) => DeleteCartItemUseCase(cartRepo),
    ),

    // Use Cases (Admin)
    ProxyProvider<AdminNoticeRepository, CreateAdminNoticeUseCase>(
      update: (_, adminNoticeRepo, __) =>
          CreateAdminNoticeUseCase(adminNoticeRepo),
    ),
    ProxyProvider<AdminNoticeRepository, UpdateAdminNoticeUseCase>(
      update: (_, adminNoticeRepo, __) =>
          UpdateAdminNoticeUseCase(adminNoticeRepo),
    ),
    ProxyProvider<AdminNoticeRepository, DeleteAdminNoticeUseCase>(
      update: (_, adminNoticeRepo, __) =>
          DeleteAdminNoticeUseCase(adminNoticeRepo),
    ),
    ProxyProvider<AdminOrderRepository, GetAdminOrdersUseCase>(
      update: (_, adminOrderRepo, __) => GetAdminOrdersUseCase(adminOrderRepo),
    ),
    ProxyProvider<AdminReferralRepository, GetAdminUserReferralTreeUseCase>(
      update: (_, adminReferralRepo, __) =>
          GetAdminUserReferralTreeUseCase(adminReferralRepo),
    ),
    ProxyProvider<AdminUserRepository, GetAdminUsersUseCase>(
      update: (_, adminUserRepo, __) => GetAdminUsersUseCase(adminUserRepo),
    ),

    // ViewModels - Lazy initialization with ProxyProvider
    // UserViewModel must be defined first because LoginViewModel depends on it
    ChangeNotifierProxyProvider2<GetMeUseCase, UpdateMeUseCase, UserViewModel>(
      create: (context) => UserViewModel(
        Provider.of<GetMeUseCase>(context, listen: false),
        Provider.of<UpdateMeUseCase>(context, listen: false),
      ),
      update: (_, getMeUseCase, updateMeUseCase, previous) =>
          previous ?? UserViewModel(getMeUseCase, updateMeUseCase),
    ),
    ChangeNotifierProxyProvider3<
      LoginUseCase,
      TokenProvider,
      UserViewModel,
      LoginViewModel
    >(
      create: (context) => LoginViewModel(
        Provider.of<LoginUseCase>(context, listen: false),
        tokenProvider,
        Provider.of<UserViewModel>(context, listen: false),
      ),
      update: (_, loginUseCase, tokenProvider, userViewModel, previous) =>
          previous ??
          LoginViewModel(loginUseCase, tokenProvider, userViewModel),
    ),
    ChangeNotifierProxyProvider<SignupUseCase, SignUpViewModel>(
      create: (context) =>
          SignUpViewModel(Provider.of<SignupUseCase>(context, listen: false)),
      update: (_, signupUseCase, previous) =>
          previous ?? SignUpViewModel(signupUseCase),
    ),
    ChangeNotifierProxyProvider5<
      GetProductsUseCase,
      GetProductDetailUseCase,
      CreateProductUseCase,
      UpdateProductUseCase,
      DeleteProductUseCase,
      ProductViewModel
    >(
      create: (context) => ProductViewModel(
        Provider.of<GetProductsUseCase>(context, listen: false),
        Provider.of<GetProductDetailUseCase>(context, listen: false),
        Provider.of<CreateProductUseCase>(context, listen: false),
        Provider.of<UpdateProductUseCase>(context, listen: false),
        Provider.of<DeleteProductUseCase>(context, listen: false),
      ),
      update:
          (
            _,
            getProducts,
            getProductDetail,
            createProduct,
            updateProduct,
            deleteProduct,
            previous,
          ) =>
              previous ??
              ProductViewModel(
                getProducts,
                getProductDetail,
                createProduct,
                updateProduct,
                deleteProduct,
              ),
    ),
    ChangeNotifierProxyProvider<GetMyOrdersUseCase, OrderViewModel>(
      create: (context) => OrderViewModel(
        Provider.of<GetMyOrdersUseCase>(context, listen: false),
      ),
      update: (_, getMyOrders, previous) =>
          previous ?? OrderViewModel(getMyOrders),
    ),
    ChangeNotifierProxyProvider2<
      GetNoticesUseCase,
      GetNoticeDetailUseCase,
      NoticeViewModel
    >(
      create: (context) => NoticeViewModel(
        Provider.of<GetNoticesUseCase>(context, listen: false),
        Provider.of<GetNoticeDetailUseCase>(context, listen: false),
      ),
      update: (_, getNotices, getNoticeDetail, previous) =>
          previous ?? NoticeViewModel(getNotices, getNoticeDetail),
    ),
    ChangeNotifierProxyProvider5<
      RechargePointsUseCase,
      RechargePointsSuccessUseCase,
      RechargePointsFailUseCase,
      GetRechargeHistoryUseCase,
      GetPointsHistoryUseCase,
      PointsViewModel
    >(
      create: (context) => PointsViewModel(
        Provider.of<RechargePointsUseCase>(context, listen: false),
        Provider.of<RechargePointsSuccessUseCase>(context, listen: false),
        Provider.of<RechargePointsFailUseCase>(context, listen: false),
        Provider.of<GetRechargeHistoryUseCase>(context, listen: false),
        Provider.of<GetPointsHistoryUseCase>(context, listen: false),
      ),
      update:
          (
            _,
            rechargePoints,
            rechargeSuccess,
            rechargeFail,
            getRechargeHistory,
            getPointsHistory,
            previous,
          ) =>
              previous ??
              PointsViewModel(
                rechargePoints,
                rechargeSuccess,
                rechargeFail,
                getRechargeHistory,
                getPointsHistory,
              ),
    ),
    ChangeNotifierProxyProvider2<
      GetReferralTreeUseCase,
      GetReferralSummaryUseCase,
      ReferralViewModel
    >(
      create: (context) => ReferralViewModel(
        Provider.of<GetReferralTreeUseCase>(context, listen: false),
        Provider.of<GetReferralSummaryUseCase>(context, listen: false),
      ),
      update: (_, getReferralTree, getReferralSummary, previous) =>
          previous ?? ReferralViewModel(getReferralTree, getReferralSummary),
    ),
    ChangeNotifierProxyProvider4<
      AddCartItemUseCase,
      GetCartUseCase,
      UpdateCartItemUseCase,
      DeleteCartItemUseCase,
      CartViewModel
    >(
      create: (context) => CartViewModel(
        Provider.of<AddCartItemUseCase>(context, listen: false),
        Provider.of<GetCartUseCase>(context, listen: false),
        Provider.of<UpdateCartItemUseCase>(context, listen: false),
        Provider.of<DeleteCartItemUseCase>(context, listen: false),
      ),
      update: (_, addCart, getCart, updateCart, deleteCart, previous) =>
          previous ?? CartViewModel(addCart, getCart, updateCart, deleteCart),
    ),
    ChangeNotifierProxyProvider5<
      CreateAdminNoticeUseCase,
      UpdateAdminNoticeUseCase,
      DeleteAdminNoticeUseCase,
      GetNoticesUseCase,
      GetNoticeDetailUseCase,
      AdminNoticeViewModel
    >(
      create: (context) => AdminNoticeViewModel(
        Provider.of<CreateAdminNoticeUseCase>(context, listen: false),
        Provider.of<UpdateAdminNoticeUseCase>(context, listen: false),
        Provider.of<DeleteAdminNoticeUseCase>(context, listen: false),
        Provider.of<GetNoticesUseCase>(context, listen: false),
        Provider.of<GetNoticeDetailUseCase>(context, listen: false),
      ),
      update:
          (
            _,
            createNotice,
            updateNotice,
            deleteNotice,
            getNotices,
            getNoticeDetail,
            previous,
          ) =>
              previous ??
              AdminNoticeViewModel(
                createNotice,
                updateNotice,
                deleteNotice,
                getNotices,
                getNoticeDetail,
              ),
    ),
    ChangeNotifierProxyProvider<GetAdminOrdersUseCase, AdminOrderViewModel>(
      create: (context) => AdminOrderViewModel(
        Provider.of<GetAdminOrdersUseCase>(context, listen: false),
      ),
      update: (_, getAdminOrders, previous) =>
          previous ?? AdminOrderViewModel(getAdminOrders),
    ),
    ChangeNotifierProxyProvider<
      GetAdminUserReferralTreeUseCase,
      AdminReferralViewModel
    >(
      create: (context) => AdminReferralViewModel(
        Provider.of<GetAdminUserReferralTreeUseCase>(context, listen: false),
      ),
      update: (_, getAdminUserReferralTree, previous) =>
          previous ?? AdminReferralViewModel(getAdminUserReferralTree),
    ),
    ChangeNotifierProxyProvider<GetAdminUsersUseCase, AdminUserViewModel>(
      create: (context) => AdminUserViewModel(
        Provider.of<GetAdminUsersUseCase>(context, listen: false),
      ),
      update: (_, getAdminUsers, previous) =>
          previous ?? AdminUserViewModel(getAdminUsers),
    ),
    ChangeNotifierProxyProvider4<
      GetProductsUseCase,
      CreateProductUseCase,
      UpdateProductUseCase,
      DeleteProductUseCase,
      AdminProductViewModel
    >(
      create: (context) => AdminProductViewModel(
        Provider.of<GetProductsUseCase>(context, listen: false),
        Provider.of<CreateProductUseCase>(context, listen: false),
        Provider.of<UpdateProductUseCase>(context, listen: false),
        Provider.of<DeleteProductUseCase>(context, listen: false),
      ),
      update:
          (
            _,
            getProducts,
            createProduct,
            updateProduct,
            deleteProduct,
            previous,
          ) =>
              previous ??
              AdminProductViewModel(
                getProducts,
                createProduct,
                updateProduct,
                deleteProduct,
              ),
    ),
  ];
}
