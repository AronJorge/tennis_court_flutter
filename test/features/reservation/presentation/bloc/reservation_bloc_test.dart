import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nolatech_tenis/features/common/domain/entities/reservation_entity.dart';
import 'package:nolatech_tenis/features/reservation/domain/usecases/create_reservation_usecase.dart';
import 'package:nolatech_tenis/features/reservation/domain/usecases/delete_reservation_usecase.dart';
import 'package:nolatech_tenis/features/reservation/domain/usecases/list_reservations_usecase.dart';
import 'package:nolatech_tenis/features/reservation/presentation/bloc/reservation_bloc.dart';
import 'package:nolatech_tenis/features/reservation/presentation/bloc/reservation_event.dart';
import 'package:nolatech_tenis/features/reservation/presentation/bloc/reservation_state.dart';

class MockCreateReservationUseCase extends Mock
    implements CreateReservationUseCase {}

class MockDeleteReservationUseCase extends Mock
    implements DeleteReservationUseCase {}

class MockListReservationsUseCase extends Mock
    implements ListReservationsUseCase {}

class FakeReservationEntity extends Fake implements ReservationEntity {}

void main() {
  late MockCreateReservationUseCase mockCreateReservationUseCase;
  late MockDeleteReservationUseCase mockDeleteReservationUseCase;
  late MockListReservationsUseCase mockListReservationsUseCase;
  late ReservationBloc reservationBloc;

  final tReservations = [
    ReservationEntity(
      id: '1',
      userId: 'user1',
      courtId: 'court1',
      dateTime: DateTime.now(),
      isFavorite: false,
      courtName: 'Court A',
      courtImageUrl: 'court_1.jpg',
      instructor: 'Instructor A',
      comment: 'Some comment',
      rainProbability: 20.0,
      userName: 'Andrea',
    ),
  ];

  final ReservationEntity tReservation = tReservations.first;

  setUpAll(() {
    registerFallbackValue(FakeReservationEntity());
  });

  setUp(() {
    mockCreateReservationUseCase = MockCreateReservationUseCase();
    mockDeleteReservationUseCase = MockDeleteReservationUseCase();
    mockListReservationsUseCase = MockListReservationsUseCase();

    reservationBloc = ReservationBloc(
      createReservationUseCase: mockCreateReservationUseCase,
      listReservationsUseCase: mockListReservationsUseCase,
      deleteReservationUseCase: mockDeleteReservationUseCase,
    );
  });

  group('ReservationBloc Tests', () {
    test('initial state should be ReservationInitial', () {
      expect(reservationBloc.state, ReservationInitial());
    });

    blocTest<ReservationBloc, ReservationState>(
      'emits [ReservationLoading, ReservationLoaded] when LoadReservationsEvent succeeds',
      build: () {
        when(
          () => mockListReservationsUseCase(),
        ).thenAnswer((_) async => tReservations);
        return reservationBloc;
      },
      act: (bloc) => bloc.add(LoadReservationsEvent()),
      expect: () => [ReservationLoading(), ReservationLoaded(tReservations)],
      verify: (_) {
        verify(() => mockListReservationsUseCase()).called(1);
      },
    );

    blocTest<ReservationBloc, ReservationState>(
      'emits [ReservationLoading, ReservationFailure] when LoadReservationsEvent fails',
      build: () {
        when(() => mockListReservationsUseCase()).thenThrow(Exception());
        return reservationBloc;
      },
      act: (bloc) => bloc.add(LoadReservationsEvent()),
      expect:
          () => [
            ReservationLoading(),
            const ReservationFailure('Failed to load reservations'),
          ],
      verify: (_) {
        verify(() => mockListReservationsUseCase()).called(1);
      },
    );

    blocTest<ReservationBloc, ReservationState>(
      'calls CreateReservationUseCase and refreshes reservations after CreateReservationEvent',
      build: () {
        when(
          () => mockCreateReservationUseCase(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockListReservationsUseCase(),
        ).thenAnswer((_) async => tReservations);
        return reservationBloc;
      },
      act: (bloc) => bloc.add(CreateReservationEvent(tReservation)),
      expect: () => [ReservationLoading(), ReservationLoaded(tReservations)],
      verify: (_) {
        verify(() => mockCreateReservationUseCase(tReservation)).called(1);
        verify(() => mockListReservationsUseCase()).called(1);
      },
    );

    blocTest<ReservationBloc, ReservationState>(
      'calls DeleteReservationUseCase and refreshes reservations after DeleteReservationEvent',
      build: () {
        when(
          () => mockDeleteReservationUseCase(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockListReservationsUseCase(),
        ).thenAnswer((_) async => tReservations);
        return reservationBloc;
      },
      act: (bloc) => bloc.add(DeleteReservationEvent('1')),
      expect: () => [ReservationLoading(), ReservationLoaded(tReservations)],
      verify: (_) {
        verify(() => mockDeleteReservationUseCase('1')).called(1);
        verify(() => mockListReservationsUseCase()).called(1);
      },
    );
  });
}
