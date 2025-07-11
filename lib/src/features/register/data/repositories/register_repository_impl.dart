import 'package:dio/dio.dart';
import 'package:flutter_base/src/core/network/dio_client.dart';
import 'package:flutter_base/src/features/register/data/models/register_request_model.dart';
import 'package:flutter_base/src/features/register/data/models/register_response_model.dart';
import 'package:flutter_base/src/features/register/domain/entities/register_response.dart';
import 'package:flutter_base/src/features/register/domain/entities/register_user.dart';
import 'package:flutter_base/src/features/register/domain/repositories/register_repository.dart';
import 'package:flutter_base/src/injector.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final DioClient dioClient = injector<DioClient>();

  @override
  Future<RegisterResponse> register({
    required String email,
    required String name,
    required String password,
  }) async {
    final requestModel =
        RegisterRequestModel(email: email, name: name, password: password);
    final response = await dioClient.post(
      '/user/register',
      data: requestModel.toJson(),
    );
    final responseModel =
        RegisterResponseModel.fromJson(response.data as Map<String, dynamic>);
    return RegisterResponse(
      token: responseModel.token,
      user: RegisterUser(
        id: responseModel.id,
        name: responseModel.name,
        email: responseModel.email,
      ),
    );
  }
}
