import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/users/users_response_model.dart';

abstract class UsersApi {
  Future<UsersResponseModel> getShareList({
    final int limit = 10,
    final int offset = 0,
  }) async {
    throw UnimplementedError();
  }

}

class UsersApiMock implements UsersApi {
  @override
  Future<UsersResponseModel> getShareList({
    final int limit = 10,
    final int offset = 0,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    final response =
    await rootBundle.loadString('assets/mock/feed/data/share_list.json');
    final data = jsonDecode(response) as Map<String, dynamic>;
    return UsersResponseModel.fromJson(data);
  }
}
