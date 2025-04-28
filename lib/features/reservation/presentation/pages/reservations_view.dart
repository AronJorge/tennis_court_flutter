import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nolatech_tenis/features/common/domain/entities/reservation_entity.dart';
import 'package:nolatech_tenis/features/reservation/presentation/bloc/reservation_bloc.dart';
import 'package:nolatech_tenis/features/reservation/presentation/bloc/reservation_state.dart';

class ReservationsView extends StatelessWidget {
  const ReservationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.scheduledReservations,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            BlocBuilder<ReservationBloc, ReservationState>(
              builder: (context, state) {
                if (state is ReservationFailure) {
                  final message = _mapReservationErrorToMessage(
                    l10n,
                    state.message,
                  );
                  return Center(child: Text(message));
                }

                if (state is ReservationLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ReservationLoaded) {
                  final reservations = state.reservations;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reservations.length,
                    itemBuilder: (context, index) {
                      final reservation = reservations[index];
                      return _ReservationCard(reservation: reservation);
                    },
                  );
                } else {
                  return Center(child: Text(l10n.noReservationsAvailable));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  String _mapReservationErrorToMessage(AppLocalizations l10n, String key) {
    switch (key) {
      case 'failed_load_reservations':
        return l10n.failedLoadReservations;
      case 'failed_create_reservation':
        return l10n.failedCreateReservation;
      case 'failed_delete_reservation':
        return l10n.failedDeleteReservation;
      default:
        return l10n.unknownError;
    }
  }
}

class _ReservationCard extends StatelessWidget {
  final ReservationEntity reservation;

  const _ReservationCard({required this.reservation});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50], // Color más similar al fondo en la imagen
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              reservation.courtImageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reservation.courtName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatDate(reservation.dateTime),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.person, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 10,
                            backgroundImage: AssetImage(
                              'assets/profile_placeholder.png',
                            ),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              reservation.userName,
                              style: const TextStyle(fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      '${l10n.twoHours}  |  ${l10n.pricePlaceholder}',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      '',
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre',
    ];
    return '${date.day} de ${months[date.month]} ${date.year}';
  }
}
