import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nolatech_tenis/core/data/local_storage_service.dart';
import 'package:nolatech_tenis/features/auth/domain/usecases/login_usecase.dart';
import 'package:nolatech_tenis/features/auth/domain/usecases/register_usecase.dart';
import 'package:nolatech_tenis/core/constants/regex_constants.dart';
import 'package:nolatech_tenis/core/constants/fields_contants.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LocalStorageService storageService;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    LocalStorageService? storageService,
  }) : storageService = storageService ?? LocalStorageService(),
       super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    final email = event.email.trim();
    final password = event.password.trim();

    if (email.isEmpty || password.isEmpty) {
      emit(const AuthFailure('empty_fields'));
      return;
    }

    if (!RegexConstants.email.hasMatch(email)) {
      emit(const AuthFailure('invalid_email'));
      return;
    }

    emit(AuthLoading());

    try {
      final user = await loginUseCase(email: email, password: password);

      await storageService.saveUser({
        UserFields.id: user.id,
        UserFields.name: user.name,
        UserFields.email: user.email,
      });

      emit(AuthSuccess(user));
    } catch (e) {
      emit(const AuthFailure('error_login'));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    final name = event.name.trim();
    final email = event.email.trim();
    final phone = event.phone.trim();
    final password = event.password.trim();
    final confirmPassword = event.confirmPassword.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      emit(const AuthFailure('empty_fields'));
      return;
    }

    if (!RegexConstants.email.hasMatch(email)) {
      emit(const AuthFailure('invalid_email'));
      return;
    }

    if (password != confirmPassword) {
      emit(const AuthFailure('passwords_do_not_match'));
      return;
    }

    emit(AuthLoading());

    try {
      final user = await registerUseCase(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );

      await storageService.saveUser({
        UserFields.id: user.id,
        UserFields.name: user.name,
        UserFields.email: user.email,
      });

      emit(AuthSuccess(user));
    } catch (e) {
      emit(const AuthFailure('error_register'));
    }
  }
}
