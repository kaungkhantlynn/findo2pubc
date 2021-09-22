import 'package:flutter/cupertino.dart';
import 'package:o2findermyanmar/ui/pages/about.dart';
import 'package:o2findermyanmar/ui/pages/detail.dart';
import 'package:o2findermyanmar/ui/pages/home.dart';
import 'package:o2findermyanmar/ui/pages/location_picker.dart';
import 'package:o2findermyanmar/ui/pages/oxygen_duration.dart';
import 'package:o2findermyanmar/ui/splash_screen.dart';

class AppRoutes {
  AppRoutes._();
  static final routes = <String, WidgetBuilder>{
    SplashScreen.route: (BuildContext context) => SplashScreen(),
    LocationPicker.route: (BuildContext context) => LocationPicker(),
    Home.route: (BuildContext context) => Home(),
    Detail.route: (BuildContext context) => Detail(),
    About.route: (BuildContext context) => About(),
    OxygenDuration.route: (BuildContext context) => OxygenDuration()
    // Login.route: (BuildContext context) => Login(),
    // Home.route: (BuildContext context) => Home(),
    // Profile.route: (BuildContext context) => Profile()
  };
}
