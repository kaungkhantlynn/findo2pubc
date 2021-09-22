import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:o2findermyanmar/bloc/service_detail_bloc/service_detail_bloc.dart';
import 'package:o2findermyanmar/bloc/services/services_bloc.dart';
import 'package:o2findermyanmar/bloc/township/township_bloc.dart';
import 'package:o2findermyanmar/bloc/volunteer/volunteer_bloc.dart';
import 'package:o2findermyanmar/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'bloc/division/division_bloc.dart';
import 'ui/splash_screen.dart';

/// Custom [BlocObserver] which observes all bloc and cubit instances.
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<DivisionBloc>(
          create: (context) => DivisionBloc()..add(GetDivision()),
        ),
        BlocProvider<TownshipBloc>(create: (context) => TownshipBloc()),
        BlocProvider<ServicesBloc>(create: (context) => ServicesBloc()),
        BlocProvider<ServiceDetailBloc>(
            create: (context) => ServiceDetailBloc()),
        BlocProvider<VolunteerBloc>(
            create: (context) => VolunteerBloc()..add(GetVolunteer()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink.shade800,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
        ),
        routes: AppRoutes.routes,
        initialRoute: SplashScreen.route,
      ),
    );
  }
}
