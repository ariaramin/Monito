part of 'pages.dart';

abstract class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  // Auth
  static const register = '/register';
  static const login = '/login';
  static const profile = '/profile';
  static const editProfile = '/profile/edit';
  static const changePassword = '/profile/password-change';

  // Main
  static const main = '/main';

  // Card
  static const addCard = '/card/add';
  static const cardDetail = '/card/detail';
  static const editCard = '/card/edit';

  // Category
  static const addCategory = '/category/add';
  static const categoryDetail = '/category/detail';
  static const editCategory = '/category/edit';

  // Transaction
  static const addTransaction = '/transaction/add';
  static const transactionDetail = '/transaction/detail';
  static const transactionList = '/transaction/list';
  static const editTransaction = '/transaction/edit';
}
