import 'package:get/get.dart'
    show Get, GetNavigation, GetxService, Inst, Rx, ever;
import 'package:monito/app/core/routes/pages.dart';

import '../models/user.dart';
import '../services/auth.dart';

class AuthRepository extends GetxService {
  static AuthRepository get instance => Get.find();

  final AuthService _authService = AuthService.instance;

  late final Rx<User> user;

  @override
  void onReady() async {
    super.onReady();
    await _authService.init();

    // Check user auth state and navigate accordingly
    _navigateToInitScreen(await _authService.currentUser);

    // Listen to user authentication changes only
    user = Rx<User>(await _authService.currentUser);
    user.bindStream(_authService.userChanges);

    // Use a condition to check when to navigate
    ever(user, (User updatedUser) => _navigateToInitScreen(updatedUser));
  }

  void _navigateToInitScreen(User updatedUser) async =>
      updatedUser != User.empty
          ? Get.offAllNamed(AppRoutes.main)
          : Get.offAllNamed(AppRoutes.login);

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await _authService.login(email, password);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      await _authService.register(fullName, email, password);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> edit(
    String id,
    Map<String, dynamic> body,
  ) async {
    try {
      await _authService.edit(id, body);
    } catch (_) {
      rethrow;
    }
  }

  void logout() => _authService.logout();
}
