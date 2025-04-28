import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nolatech_tenis/core/di/service_locator.dart';
import 'package:nolatech_tenis/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nolatech_tenis/features/court/presentation/bloc/court_bloc.dart';
import 'package:nolatech_tenis/features/court/presentation/bloc/court_event.dart';
import 'package:nolatech_tenis/features/reservation/presentation/bloc/reservation_bloc.dart';
import 'package:nolatech_tenis/features/reservation/presentation/bloc/reservation_event.dart';
import 'package:nolatech_tenis/features/auth/presentation/pages/login_page.dart';
import 'package:nolatech_tenis/features/auth/presentation/pages/register_page.dart';
import 'package:nolatech_tenis/features/auth/presentation/pages/welcome_page.dart';
import 'package:nolatech_tenis/features/court/presentation/pages/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<CourtBloc>()..add(LoadCourtsEvent())),
        BlocProvider(
          create: (_) => sl<ReservationBloc>()..add(LoadReservationsEvent()),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('es')],
        title: 'Tennis Scheduler',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        initialRoute: '/',
        routes: {
          '/': (_) => const WelcomePage(),
          '/login': (_) => const LoginPage(),
          '/register': (_) => const RegisterPage(),
          '/home': (_) => const HomePage(),
        },
      ),
    );
  }
}
