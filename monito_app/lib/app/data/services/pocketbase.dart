import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' show Get, GetxService, Inst;
import 'package:monito/app/core/error/api_exception.dart';
import 'package:pocketbase/pocketbase.dart'
    show ClientException, PocketBase, RecordModel, ResultList;

class PocketBaseService extends GetxService {
  static PocketBaseService get instance => Get.find();

  static PocketBase _pocketBase = PocketBase(dotenv.env['API_URL']!);

  static PocketBase get pocketBase => _pocketBase;

  static set setPocketBase(PocketBase newPocketBase) =>
      _pocketBase = newPocketBase;

  Future<ResultList<RecordModel>> getList(
    String collectionName, {
    int page = 1,
    int perPage = 30,
    String? expand,
    String? filter,
    String? sort,
  }) async {
    try {
      return await _pocketBase.collection(collectionName).getList(
            page: page,
            perPage: perPage,
            expand: expand,
            filter: filter,
            sort: sort,
          );
    } on ClientException catch (error) {
      throw ApiException(
        code: error.statusCode,
        message: error.response['message'],
      );
    } catch (_) {
      throw const ApiException();
    }
  }

  Future<RecordModel> getOne(
    String collectionName, {
    required String id,
    String? expand,
  }) async {
    try {
      return await _pocketBase.collection(collectionName).getOne(
            id,
            expand: expand,
          );
    } on ClientException catch (error) {
      throw ApiException(
        code: error.statusCode,
        message: error.response['message'],
      );
    } catch (_) {
      throw const ApiException();
    }
  }

  Future<RecordModel> create(
    String collectionName, {
    required Map<String, dynamic> data,
    String? expand,
  }) async {
    try {
      return await _pocketBase.collection(collectionName).create(
            body: data,
            expand: expand,
          );
    } on ClientException catch (error) {
      throw ApiException(
        code: error.statusCode,
        message: error.response['message'],
      );
    } catch (_) {
      throw const ApiException();
    }
  }

  Future<RecordModel> update(
    String collectionName, {
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      return await _pocketBase.collection(collectionName).update(
            id,
            body: data,
          );
    } on ClientException catch (error) {
      throw ApiException(
        code: error.statusCode,
        message: error.response['message'],
      );
    } catch (_) {
      throw const ApiException();
    }
  }

  Future<void> delete(
    String collectionName, {
    required String id,
  }) async {
    try {
      return await _pocketBase.collection(collectionName).delete(id);
    } on ClientException catch (error) {
      throw ApiException(
        code: error.statusCode,
        message: error.response['message'],
      );
    } catch (_) {
      throw const ApiException();
    }
  }
}
