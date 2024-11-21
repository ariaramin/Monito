import 'package:get/get.dart' show GetPage;
import 'package:monito/app/modules/auth/bindings/change_password_binding.dart';
import 'package:monito/app/modules/auth/bindings/edit_profile_binding.dart';
import 'package:monito/app/modules/auth/views/change_password_screen.dart';
import 'package:monito/app/modules/auth/views/edit_profile_screen.dart';
import 'package:monito/app/modules/auth/views/profile_screen.dart';
import 'package:monito/app/modules/card/bindings/add_card_binding.dart';
import 'package:monito/app/modules/card/bindings/card_detail_binding.dart';
import 'package:monito/app/modules/card/bindings/edit_card_binding.dart';
import 'package:monito/app/modules/card/views/card_detail_screen.dart';
import 'package:monito/app/modules/card/views/edit_card_screen.dart';
import 'package:monito/app/modules/category/bindings/add_category_binding.dart';
import 'package:monito/app/modules/category/bindings/category_detail_binding.dart';
import 'package:monito/app/modules/category/bindings/edit_category_binding.dart';
import 'package:monito/app/modules/category/views/add_category_screen.dart';
import 'package:monito/app/modules/category/views/category_detail_screen.dart';
import 'package:monito/app/modules/category/views/edit_category_screen.dart';
import 'package:monito/app/modules/intro/bindings/onboarding_binding.dart';
import 'package:monito/app/modules/intro/bindings/splash_binding.dart';
import 'package:monito/app/modules/intro/views/splash_screen.dart';
import 'package:monito/app/modules/main/main_binding.dart';
import 'package:monito/app/modules/main/main_screen.dart';
import 'package:monito/app/modules/auth/bindings/login_binding.dart';
import 'package:monito/app/modules/auth/bindings/register_binding.dart';
import 'package:monito/app/modules/auth/views/login_screen.dart';
import 'package:monito/app/modules/auth/views/register_screen.dart';
import 'package:monito/app/modules/card/views/add_card_screen.dart';
import 'package:monito/app/modules/intro/views/onboarding_screen.dart';
import 'package:monito/app/modules/transaction/bindings/add_transaction_binding.dart';
import 'package:monito/app/modules/transaction/bindings/edit_transaction_binding.dart';
import 'package:monito/app/modules/transaction/bindings/transaction_detail_binding.dart';
import 'package:monito/app/modules/transaction/bindings/transaction_list_binding.dart';
import 'package:monito/app/modules/transaction/views/add_transaction_screen.dart';
import 'package:monito/app/modules/transaction/views/edit_transaction_screen.dart';
import 'package:monito/app/modules/transaction/views/transaction_detail_screen.dart';
import 'package:monito/app/modules/transaction/views/transaction_list_screen.dart';

part 'routes.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
      binding: OnBoardingBinding(),
    ),

    // Auth Screens
    GetPage(
      name: AppRoutes.register,
      binding: RegisterBinding(),
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfileScreen(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.changePassword,
      page: () => const ChangePasswordScreen(),
      binding: ChangePasswordBinding(),
    ),

    // Main Screen
    GetPage(
      name: AppRoutes.main,
      page: () => const MainScreen(),
      binding: MainBinding(),
    ),

    // Card Screens
    GetPage(
      name: AppRoutes.addCard,
      page: () => const AddCardScreen(),
      binding: AddCardBinding(),
    ),
    GetPage(
      name: AppRoutes.cardDetail,
      page: () => const CardDetailScreen(),
      binding: CardDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.editCard,
      page: () => const EditCardScreen(),
      binding: EditCardBinding(),
    ),

    // Category Screens
    GetPage(
      name: AppRoutes.addCategory,
      page: () => const AddCategoryScreen(),
      binding: AddCategoryBinding(),
    ),
    GetPage(
      name: AppRoutes.categoryDetail,
      page: () => const CategoryDetailScreen(),
      binding: CategoryDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.editCategory,
      page: () => const EditCategoryScreen(),
      binding: EditCategoryBinding(),
    ),

    // Transaction Screens
    GetPage(
      name: AppRoutes.addTransaction,
      page: () => const AddTransactionScreen(),
      binding: AddTransactionBinding(),
    ),
    GetPage(
      name: AppRoutes.transactionList,
      page: () => const TransactionListScreen(),
      binding: TransactionListBinding(),
    ),
    GetPage(
      name: AppRoutes.transactionDetail,
      page: () => const TransactionDetailScreen(),
      binding: TransactionDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.editTransaction,
      page: () => const EditTransactionScreen(),
      binding: EditTransactionBinding(),
    ),
  ];
}
