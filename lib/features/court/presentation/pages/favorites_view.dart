import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nolatech_tenis/features/reservation/presentation/bloc/reservation_bloc.dart';
import 'package:nolatech_tenis/features/reservation/presentation/bloc/reservation_event.dart';
import 'package:nolatech_tenis/features/reservation/presentation/bloc/reservation_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  Future<void> _refresh(BuildContext context) async {
    context.read<ReservationBloc>().add(LoadReservationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.favoriteReservations)),
      body: BlocBuilder<ReservationBloc, ReservationState>(
        builder: (context, state) {
          if (state is ReservationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ReservationLoaded) {
            final favorites =
                state.reservations.where((r) => r.isFavorite).toList();
            if (favorites.isEmpty) {
              return RefreshIndicator(
                onRefresh: () => _refresh(context),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    const SizedBox(height: 150),
                    Center(child: Text(l10n.noFavoritesYet)),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () => _refresh(context),
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final reservation = favorites[index];
                  return ListTile(
                    title: Text('${l10n.courtId}: ${reservation.courtId}'),
                    subtitle: Text(
                      '${l10n.date}: ${_formatDate(reservation.dateTime)}',
                    ),
                  );
                },
              ),
            );
          } else if (state is ReservationFailure) {
            return Center(child: Text(l10n.errorLoadingFavorites));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
