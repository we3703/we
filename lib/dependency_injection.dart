import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:we/core/auth/token_provider.dart';
import 'package:we/core/config/http_client.dart';
import 'package:we/data/api/auth/auth_api.dart';
import 'package:we/data/api/auth/license_api.dart';
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
import 'package:we/presentation/screens/admin/referral/admin_referral_view_model.dart';
import 'package:we/presentation/screens/admin/user/admin_user_view_model.dart';
import 'package:we/presentation/screens/auth/login_view_model.dart';
import 'package:we/presentation/screens/auth/signup_view_model.dart';
import 'package:we/presentation/screens/cart/cart_view_model.dart';
import 'package:we/presentation/screens/notice/notice_view_model.dart';
import 'package:we/presentation/screens/points/points_view_model.dart';
import 'package:we/presentation/screens/product/product_view_model.dart';
import 'package:we/presentation/screens/referral/referral_view_model.dart';
import 'package:we/presentation/screens/user/user_view_model.dart';

List<SingleChildWidget> setupProviders() {
  // Core Dependencies
  final tokenProvider = TokenProvider();
  final httpClient = HttpClient(
    baseUrl: "http://192.168.1.3:8000",
    tokenProvider: tokenProvider,
  );

  // API Implementations
  final authApi = AuthApi(httpClient);
  final licenseApi = LicenseApi(httpClient);
  final userApi = UserApi(httpClient);
  final productApi = ProductApi(httpClient);
  final noticeApi = NoticeApi(httpClient);
  final pointsApi = PointsApi(httpClient);
  final referralsApi = ReferralsApi(httpClient);
  final cartApi = CartApi(httpClient);
  final adminNoticeApi = AdminNoticeApi(httpClient);
  final adminOrderApi = AdminOrderApi(httpClient);
  final adminReferralsApi = AdminReferralsApi(httpClient);
  final adminUserApi = AdminUserApi(httpClient);

  // Repository Implementations
  final AuthRepository authRepository = AuthRepositoryImpl(authApi);
  final LicenseRepository licenseRepository = LicenseRepositoryImpl(licenseApi);
  final UserRepository userRepository = UserRepositoryImpl(userApi);
  final ProductRepository productRepository = ProductRepositoryImpl(productApi);
  final NoticeRepository noticeRepository = NoticeRepositoryImpl(noticeApi);
  final PointsRepository pointsRepository = PointsRepositoryImpl(pointsApi);
  final ReferralRepository referralRepository = ReferralRepositoryImpl(
    referralsApi,
  );
  final CartRepository cartRepository = CartRepositoryImpl(cartApi);
  final AdminNoticeRepository adminNoticeRepository = AdminNoticeRepositoryImpl(
    adminNoticeApi,
  );
  final AdminOrderRepository adminOrderRepository = AdminOrderRepositoryImpl(
    adminOrderApi,
  );
  final AdminReferralRepository adminReferralRepository =
      AdminReferralRepositoryImpl(adminReferralsApi);
  final AdminUserRepository adminUserRepository = AdminUserRepositoryImpl(
    adminUserApi,
  );

  // Use Cases
  final LoginUseCase loginUseCase = LoginUseCase(authRepository);
  final SignupUseCase signupUseCase = SignupUseCase(authRepository);
  final SendCodeUseCase sendCodeUseCase = SendCodeUseCase(licenseRepository);
  final VerifyCodeUseCase verifyCodeUseCase = VerifyCodeUseCase(licenseRepository);
  final RefreshTokenUseCase refreshTokenUseCase = RefreshTokenUseCase(
    authRepository,
  );
  final ChangePasswordUseCase changePasswordUseCase = ChangePasswordUseCase(
    authRepository,
  );
  final LogoutUseCase logoutUseCase = LogoutUseCase(authRepository);

  final GetMeUseCase getMeUseCase = GetMeUseCase(userRepository);
  final UpdateMeUseCase updateMeUseCase = UpdateMeUseCase(userRepository);

  final GetProductsUseCase getProductsUseCase = GetProductsUseCase(
    productRepository,
  );
  final GetProductDetailUseCase getProductDetailUseCase =
      GetProductDetailUseCase(productRepository);
  final CreateProductUseCase createProductUseCase = CreateProductUseCase(
    productRepository,
  );
  final UpdateProductUseCase updateProductUseCase = UpdateProductUseCase(
    productRepository,
  );
  final DeleteProductUseCase deleteProductUseCase = DeleteProductUseCase(
    productRepository,
  );

  final GetNoticesUseCase getNoticesUseCase = GetNoticesUseCase(
    noticeRepository,
  );
  final GetNoticeDetailUseCase getNoticeDetailUseCase = GetNoticeDetailUseCase(
    noticeRepository,
  );

  final RechargePointsUseCase rechargePointsUseCase = RechargePointsUseCase(
    pointsRepository,
  );
  final RechargePointsSuccessUseCase rechargePointsSuccessUseCase =
      RechargePointsSuccessUseCase(pointsRepository);
  final RechargePointsFailUseCase rechargePointsFailUseCase =
      RechargePointsFailUseCase(pointsRepository);
  final GetRechargeHistoryUseCase getRechargeHistoryUseCase =
      GetRechargeHistoryUseCase(pointsRepository);
  final GetPointsHistoryUseCase getPointsHistoryUseCase =
      GetPointsHistoryUseCase(pointsRepository);

  final GetReferralTreeUseCase getReferralTreeUseCase = GetReferralTreeUseCase(
    referralRepository,
  );
  final GetReferralSummaryUseCase getReferralSummaryUseCase =
      GetReferralSummaryUseCase(referralRepository);

  final AddCartItemUseCase addCartItemUseCase = AddCartItemUseCase(
    cartRepository,
  );
  final GetCartUseCase getCartUseCase = GetCartUseCase(cartRepository);
  final UpdateCartItemUseCase updateCartItemUseCase = UpdateCartItemUseCase(
    cartRepository,
  );
  final DeleteCartItemUseCase deleteCartItemUseCase = DeleteCartItemUseCase(
    cartRepository,
  );

  final CreateAdminNoticeUseCase createAdminNoticeUseCase =
      CreateAdminNoticeUseCase(adminNoticeRepository);
  final UpdateAdminNoticeUseCase updateAdminNoticeUseCase =
      UpdateAdminNoticeUseCase(adminNoticeRepository);
  final DeleteAdminNoticeUseCase deleteAdminNoticeUseCase =
      DeleteAdminNoticeUseCase(adminNoticeRepository);

  final GetAdminOrdersUseCase getAdminOrdersUseCase = GetAdminOrdersUseCase(
    adminOrderRepository,
  );

  final GetAdminUserReferralTreeUseCase getAdminUserReferralTreeUseCase =
      GetAdminUserReferralTreeUseCase(adminReferralRepository);

  final GetAdminUsersUseCase getAdminUsersUseCase = GetAdminUsersUseCase(
    adminUserRepository,
  );

  return [
    ChangeNotifierProvider<TokenProvider>.value(value: tokenProvider),
    Provider<HttpClient>.value(value: httpClient),

    // Repositories
    Provider<AuthRepository>.value(value: authRepository),
    Provider<UserRepository>.value(value: userRepository),
    Provider<ProductRepository>.value(value: productRepository),
    Provider<NoticeRepository>.value(value: noticeRepository),
    Provider<PointsRepository>.value(value: pointsRepository),
    Provider<ReferralRepository>.value(value: referralRepository),
    Provider<CartRepository>.value(value: cartRepository),
    Provider<AdminNoticeRepository>.value(value: adminNoticeRepository),
    Provider<AdminOrderRepository>.value(value: adminOrderRepository),
    Provider<AdminReferralRepository>.value(value: adminReferralRepository),
    Provider<AdminUserRepository>.value(value: adminUserRepository),

    // Use Cases (Auth)
    Provider<LoginUseCase>.value(value: loginUseCase),
    Provider<SignupUseCase>.value(value: signupUseCase),
    Provider<SendCodeUseCase>.value(value: sendCodeUseCase),
    Provider<VerifyCodeUseCase>.value(value: verifyCodeUseCase),
    Provider<RefreshTokenUseCase>.value(value: refreshTokenUseCase),
    Provider<ChangePasswordUseCase>.value(value: changePasswordUseCase),
    Provider<LogoutUseCase>.value(value: logoutUseCase),

    // Use Cases (User)
    Provider<GetMeUseCase>.value(value: getMeUseCase),
    Provider<UpdateMeUseCase>.value(value: updateMeUseCase),

    // Use Cases (Product)
    Provider<GetProductsUseCase>.value(value: getProductsUseCase),
    Provider<GetProductDetailUseCase>.value(value: getProductDetailUseCase),
    Provider<CreateProductUseCase>.value(value: createProductUseCase),
    Provider<UpdateProductUseCase>.value(value: updateProductUseCase),
    Provider<DeleteProductUseCase>.value(value: deleteProductUseCase),

    // Use Cases (Notice)
    Provider<GetNoticesUseCase>.value(value: getNoticesUseCase),
    Provider<GetNoticeDetailUseCase>.value(value: getNoticeDetailUseCase),

    // Use Cases (Points)
    Provider<RechargePointsUseCase>.value(value: rechargePointsUseCase),
    Provider<RechargePointsSuccessUseCase>.value(
      value: rechargePointsSuccessUseCase,
    ),
    Provider<RechargePointsFailUseCase>.value(value: rechargePointsFailUseCase),
    Provider<GetRechargeHistoryUseCase>.value(value: getRechargeHistoryUseCase),
    Provider<GetPointsHistoryUseCase>.value(value: getPointsHistoryUseCase),

    // Use Cases (Referrals)
    Provider<GetReferralTreeUseCase>.value(value: getReferralTreeUseCase),
    Provider<GetReferralSummaryUseCase>.value(value: getReferralSummaryUseCase),

    // Use Cases (Cart)
    Provider<AddCartItemUseCase>.value(value: addCartItemUseCase),
    Provider<GetCartUseCase>.value(value: getCartUseCase),
    Provider<UpdateCartItemUseCase>.value(value: updateCartItemUseCase),
    Provider<DeleteCartItemUseCase>.value(value: deleteCartItemUseCase),

    // Use Cases (Admin)
    Provider<CreateAdminNoticeUseCase>.value(value: createAdminNoticeUseCase),
    Provider<UpdateAdminNoticeUseCase>.value(value: updateAdminNoticeUseCase),
    Provider<DeleteAdminNoticeUseCase>.value(value: deleteAdminNoticeUseCase),
    Provider<GetAdminOrdersUseCase>.value(value: getAdminOrdersUseCase),
    Provider<GetAdminUserReferralTreeUseCase>.value(
      value: getAdminUserReferralTreeUseCase,
    ),
    Provider<GetAdminUsersUseCase>.value(value: getAdminUsersUseCase),

    // ViewModels
    ChangeNotifierProvider(create: (_) => LoginViewModel(loginUseCase)),
    ChangeNotifierProvider(
        create: (_) => SignUpViewModel(
            signupUseCase, sendCodeUseCase, verifyCodeUseCase)),
    ChangeNotifierProvider(
      create: (_) => UserViewModel(getMeUseCase, updateMeUseCase),
    ),
    ChangeNotifierProvider(
      create: (_) => ProductViewModel(
        getProductsUseCase,
        getProductDetailUseCase,
        createProductUseCase,
        updateProductUseCase,
        deleteProductUseCase,
      ),
    ),
    ChangeNotifierProvider(
      create: (_) => NoticeViewModel(getNoticesUseCase, getNoticeDetailUseCase),
    ),
    ChangeNotifierProvider(
      create: (_) => PointsViewModel(
        rechargePointsUseCase,
        rechargePointsSuccessUseCase,
        rechargePointsFailUseCase,
        getRechargeHistoryUseCase,
        getPointsHistoryUseCase,
      ),
    ),
    ChangeNotifierProvider(
      create: (_) =>
          ReferralViewModel(getReferralTreeUseCase, getReferralSummaryUseCase),
    ),
    ChangeNotifierProvider(
      create: (_) => CartViewModel(
        addCartItemUseCase,
        getCartUseCase,
        updateCartItemUseCase,
        deleteCartItemUseCase,
      ),
    ),
    ChangeNotifierProvider(
      create: (_) => AdminNoticeViewModel(
        createAdminNoticeUseCase,
        updateAdminNoticeUseCase,
        deleteAdminNoticeUseCase,
        getNoticesUseCase,
        getNoticeDetailUseCase,
      ),
    ),
    ChangeNotifierProvider(
      create: (_) => AdminOrderViewModel(getAdminOrdersUseCase),
    ),
    ChangeNotifierProvider(
      create: (_) => AdminReferralViewModel(getAdminUserReferralTreeUseCase),
    ),
    ChangeNotifierProvider(
      create: (_) => AdminUserViewModel(getAdminUsersUseCase),
    ),
  ];
}
