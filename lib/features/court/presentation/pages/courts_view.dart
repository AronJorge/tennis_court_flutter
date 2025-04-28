import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nolatech_tenis/core/constants/assets_constants.dart';
import 'package:nolatech_tenis/core/data/local_storage_service.dart';
import 'package:nolatech_tenis/features/court/presentation/bloc/court_bloc.dart';
import 'package:nolatech_tenis/features/court/presentation/bloc/court_event.dart';
import 'package:nolatech_tenis/features/court/presentation/bloc/court_state.dart';
import 'package:nolatech_tenis/features/common/domain/entities/court_entity.dart';
import 'package:nolatech_tenis/features/reservation/presentation/bloc/reservation_bloc.dart';
import 'package:nolatech_tenis/features/reservation/presentation/bloc/reservation_event.dart';
import 'package:nolatech_tenis/features/reservation/presentation/bloc/reservation_state.dart';
import 'package:nolatech_tenis/features/common/domain/entities/reservation_entity.dart';
import 'package:nolatech_tenis/features/reservation/presentation/pages/new_reservation_page.dart';

class CourtsView extends StatelessWidget {
  const CourtsView({super.key});

  Future<void> _refresh(BuildContext context) async {
    context.read<CourtBloc>().add(LoadCourtsEvent());
    context.read<ReservationBloc>().add(LoadReservationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () => _refresh(context),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.helloUser(LocalStorageService().getCurrentUserName()),
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                l10n.courts,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              BlocBuilder<CourtBloc, CourtState>(
                builder: (context, state) {
                  if (state is CourtLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CourtLoaded) {
                    final courts = state.courts;
                    return SizedBox(
                      height: 330,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: courts.length,
                        itemBuilder: (context, index) {
                          final court = courts[index];
                          return _CourtCard(court: court);
                        },
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                      ),
                    );
                  } else {
                    return Center(child: Text(l10n.noCourtsAvailable));
                  }
                },
              ),
              const SizedBox(height: 30),
              Text(
                l10n.scheduledReservations,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              BlocBuilder<ReservationBloc, ReservationState>(
                builder: (context, state) {
                  if (state is ReservationLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ReservationLoaded) {
                    final reservations = state.reservations;
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: reservations.length,
                      itemBuilder: (context, index) {
                        final reservation = reservations[index];
                        return _ReservationCard(reservation: reservation);
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                    );
                  } else {
                    return Center(child: Text(l10n.noReservationsAvailable));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CourtCard extends StatelessWidget {
  final CourtEntity court;

  const _CourtCard({required this.court});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              court.imageUrl,
              height: 130,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleRow(court),
                const SizedBox(height: 6),
                Text(
                  l10n.courtType(court.type),
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                _buildDateRow(court),
                const SizedBox(height: 6),
                _buildAvailabilityRow(court, l10n),
                const SizedBox(height: 12),
                _buildReserveButton(context, court, l10n),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleRow(CourtEntity court) {
    return Row(
      children: [
        Expanded(
          child: Text(
            court.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Row(
          children: [
            const Icon(Icons.cloud, size: 16, color: Colors.blueGrey),
            const SizedBox(width: 2),
            Text(
              '${court.rainProbability.toInt()}%',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateRow(CourtEntity court) {
    return Row(
      children: [
        const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          '${court.availableDate.day}/${court.availableDate.month}/${court.availableDate.year}',
          style: const TextStyle(fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildAvailabilityRow(CourtEntity court, AppLocalizations l10n) {
    return Row(
      children: [
        Icon(
          court.isAvailable ? Icons.circle : Icons.cancel,
          size: 10,
          color: court.isAvailable ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 6),
        Text(
          court.isAvailable
              ? '${court.availableStartTime} - ${court.availableEndTime}'
              : l10n.notAvailable,
          style: const TextStyle(fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildReserveButton(
    BuildContext context,
    CourtEntity court,
    AppLocalizations l10n,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => NewReservationPage(court: court)),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightGreen[600],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(
          l10n.reserveButton,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
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
        color: Colors.lightGreen[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            Assets.court1,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(reservation.courtName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 14),
                const SizedBox(width: 4),
                Text(
                  '${reservation.dateTime.day}/${reservation.dateTime.month}/${reservation.dateTime.year}',
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.access_time, size: 14),
                const SizedBox(width: 4),
                Text(l10n.twoHours),
              ],
            ),
          ],
        ),
        trailing: Text(l10n.pricePlaceholder),
      ),
    );
  }
}
