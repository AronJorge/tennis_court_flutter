import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nolatech_tenis/core/data/local_storage_service.dart';
import 'package:nolatech_tenis/features/auth/domain/usecases/login_usecase.dart';
import 'package:nolatech_tenis/features/auth/domain/usecases/register_usecase.dart';
import 'package:nolatech_tenis/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nolatech_tenis/features/auth/presentation/bloc/auth_event.dart';
import 'package:nolatech_tenis/features/auth/presentation/bloc/auth_state.dart';
import 'package:nolatech_tenis/features/common/domain/entities/user_entity.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class MockLocalStorageService extends Mock implements LocalStorageService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockLoginUseCase mockLoginUseCase;
  late MockRegisterUseCase mockRegisterUseCase;
  late MockLocalStorageService mockLocalStorageService;
  late AuthBloc authBloc;

  const tUser = UserEntity(
    id: '1',
    name: 'John Doe',
    email: 'john@example.com',
    phone: '1234567890',
  );

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockRegisterUseCase = MockRegisterUseCase();
    mockLocalStorageService = MockLocalStorageService();

    authBloc = AuthBloc(
      loginUseCase: mockLoginUseCase,
      registerUseCase: mockRegisterUseCase,
      storageService: mockLocalStorageService,
    );
  });

  tearDown(() {
    authBloc.close();
  });

  test('should have initial state AuthInitial', () {
    expect(authBloc.state, equals(AuthInitial()));
  });

  group('Login', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] when login is successful',
      build: () {
        when(
          () => mockLoginUseCase(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => tUser);

        when(
          () => mockLocalStorageService.saveUser(any()),
        ).thenAnswer((_) async {});

        return authBloc;
      },
      act:
          (bloc) => bloc.add(
            const LoginEvent(email: 'john@example.com', password: 'password'),
          ),
      expect: () => [AuthLoading(), const AuthSuccess(tUser)],
      verify: (_) {
        verify(
          () =>
              mockLoginUseCase(email: 'john@example.com', password: 'password'),
        ).called(1);
        verify(() => mockLocalStorageService.saveUser(any())).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] when login fails',
      build: () {
        when(
          () => mockLoginUseCase(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(Exception());
        return authBloc;
      },
      act:
          (bloc) => bloc.add(
            const LoginEvent(email: 'wrong@example.com', password: 'wrong'),
          ),
      expect:
          () => [AuthLoading(), const AuthFailure('Error al iniciar sesión.')],
    );
  });

  group('Register', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] when registration is successful',
      build: () {
        when(
          () => mockRegisterUseCase(
            name: any(named: 'name'),
            email: any(named: 'email'),
            phone: any(named: 'phone'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => tUser);

        when(
          () => mockLocalStorageService.saveUser(any()),
        ).thenAnswer((_) async {});

        return authBloc;
      },
      act:
          (bloc) => bloc.add(
            const RegisterEvent(
              name: 'John Doe',
              email: 'john@example.com',
              phone: '1234567890',
              password: 'password',
              confirmPassword: 'password',
            ),
          ),
      expect: () => [AuthLoading(), const AuthSuccess(tUser)],
      verify: (_) {
        verify(
          () => mockRegisterUseCase(
            name: 'John Doe',
            email: 'john@example.com',
            phone: '1234567890',
            password: 'password',
          ),
        ).called(1);
        verify(() => mockLocalStorageService.saveUser(any())).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] when registration fails',
      build: () {
        when(
          () => mockRegisterUseCase(
            name: any(named: 'name'),
            email: any(named: 'email'),
            phone: any(named: 'phone'),
            password: any(named: 'password'),
          ),
        ).thenThrow(Exception());
        return authBloc;
      },
      act:
          (bloc) => bloc.add(
            const RegisterEvent(
              name: 'Jane',
              email: 'jane@example.com',
              phone: '9876543210',
              password: 'wrongpass',
              confirmPassword: 'wrongpass',
            ),
          ),
      expect:
          () => [
            AuthLoading(),
            const AuthFailure('Error al registrar la cuenta.'),
          ],
    );
  });
}
