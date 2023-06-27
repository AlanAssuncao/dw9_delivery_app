import 'dart:developer';

import 'package:dw9_delivery_app/app/core/extensions/unauthorized_exceptions.dart';
import 'package:dw9_delivery_app/app/pages/auth/login/login_state.dart';
import 'package:dw9_delivery_app/app/repositories/auth/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginController(this._authRepository) : super(const LoginState.initial());

  Future<void> login(String email, String password) async {
    try {
      emit(state.copyWith(status: LoginStatus.login));
      final authModel = await _authRepository.login(email, password);
      final sp = await SharedPreferences.getInstance();
      sp.setString('accessToken', authModel.accessToken);
      sp.setString('refreshToken', authModel.refreshToken);
      emit(state.copyWith(status: LoginStatus.success));
    } on UnauthorizedExceptions catch (e, s) {
      log('Login e senha inválidos', error: e, stackTrace: s);
      emit(
        state.copyWith(
            status: LoginStatus.loginError,
            errorMessage: 'Login ou senha inválidos'),
      );
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      emit(
        state.copyWith(
            status: LoginStatus.error, errorMessage: 'Erro ao realizar login'),
      );
    }
  }
}
