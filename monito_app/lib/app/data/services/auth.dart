import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart'
    show BoolExtension, Get, GetxService, Inst, RxBool, Trans;
import 'package:monito/app/core/error/api_exception.dart';
import 'package:pocketbase/pocketbase.dart'
    show AsyncAuthStore, ClientException, PocketBase, RecordAuth, RecordModel;

import '../models/user.dart';
import 'pocketbase.dart';

class AuthService extends GetxService {
  static AuthService get instance => Get.find();

  static final PocketBase _pocketBase = PocketBaseService.pocketBase;
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static const String userKey = 'user';
  static const String tokenKey = 'token';

  RxBool isLoggedIn = false.obs;

  Future<void> init() async {
    final token = await userToken;
    final customAuthStore = AsyncAuthStore(
      initial: token,
      save: setUserToken,
      clear: deleteUserToken,
    );

    PocketBaseService.setPocketBase = PocketBase(
      dotenv.env['API_URL']!,
      authStore: customAuthStore,
    );

    if (_pocketBase.authStore.isValid) {
      isLoggedIn.value = true;
      await _pocketBase.collection('users').authRefresh();
    } else {
      isLoggedIn.value = false;
    }
  }

  Future<RecordAuth> login(
    String usernameOrEmail,
    String password,
  ) async {
    try {
      return await _pocketBase
          .collection('users')
          .authWithPassword(usernameOrEmail, password);
    } on ClientException catch (error) {
      final invalidFields = error.response['data'] as Map<String, dynamic>;
      if (invalidFields.isNotEmpty) {
        final errorEntry = invalidFields.entries.first;
        throw ApiException.authException(errorEntry.value['code']);
      }
      throw ApiException(message: 'credential_error'.tr);
    } catch (_) {
      throw const ApiException();
    }
  }

  Future<RecordModel> register(
    String fullName,
    String email,
    String password,
  ) async {
    try {
      final recordModel = await _pocketBase.collection('users').create(
        body: {
          'name': fullName,
          'email': email,
          'password': password,
          'passwordConfirm': password,
        },
      );
      await login(email, password);
      return recordModel;
    } on ClientException catch (error) {
      final invalidFields = error.response['data'] as Map<String, dynamic>;
      if (invalidFields.isNotEmpty) {
        final errorEntry = invalidFields.entries.first;
        throw ApiException.authException(errorEntry.value['code']);
      }
      throw ApiException(
        code: error.statusCode,
        message: error.originalError['message'],
      );
    } catch (_) {
      throw const ApiException();
    }
  }

  Future<RecordModel> edit(String id, Map<String, dynamic> body) async {
    try {
      final recordModel =
          await _pocketBase.collection('users').update(id, body: body);
      return recordModel;
    } on ClientException catch (error) {
      final invalidFields = error.response['data'] as Map<String, dynamic>;
      if (invalidFields.isNotEmpty) {
        final errorEntry = invalidFields.entries.first;
        throw ApiException.authException(errorEntry.value['code']);
      }
      throw ApiException(
        code: error.statusCode,
        message: error.originalError['message'],
      );
    } catch (_) {
      throw const ApiException();
    }
  }

  Stream<User> get userChanges => _pocketBase.authStore.onChange.map((event) =>
      event.token.isNotEmpty ? User.fromRecord(event.model) : User.empty);

  Future<User> get currentUser async {
    final userModel = await _pocketBase.authStore.model;
    return userModel != null ? User.fromRecord(userModel) : User.empty;
  }

  Future<String?> get userToken async => _storage.read(key: tokenKey);

  Future<void> setUserToken(String newToken) async => _storage.write(
        key: tokenKey,
        value: newToken,
      );

  Future<void> deleteUserToken() async => _storage.delete(key: tokenKey);

  void logout() => _pocketBase.authStore.clear();
}
