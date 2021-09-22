import 'dart:async';

import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:o2findermyanmar/constant/app_setting.dart';
import 'package:o2findermyanmar/constant/svg_constant.dart';
import 'package:o2findermyanmar/ui/pages/home.dart';
import 'package:o2findermyanmar/ui/pages/location_picker.dart';

class SplashScreen extends StatefulWidget {
  static const String route = '/splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;
  final _timerDuration = Duration(milliseconds: 0);

  String? _firstTimeUse;

  final _storage = FlutterSecureStorage();

  @override
  void initState() {
    delayTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: Colors.pink.shade800,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(35),
              decoration: BoxDecoration(
                color: Colors.pink.shade700,
                shape: BoxShape.circle,
              ),
              child: Container(
                  padding: EdgeInsets.all(35),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade600,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                      padding: EdgeInsets.all(35),
                      decoration: BoxDecoration(
                        color: Colors.pink.shade500,
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                          padding: EdgeInsets.all(60),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            'Oxygen',
                            style: TextStyle(
                                fontFamily: 'ZenLoopRegular',
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.pink.shade800),
                          )))),
            ),
            Padding(padding: EdgeInsets.all(10.10)),
            EasyRichText(
              "O 2 Finder",
              patternList: [
                EasyRichTextPattern(
                    targetString: '2',
                    subScript: true,
                    style: TextStyle(
                        fontFamily: 'RobotoCondensed',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 22)),
              ],
              defaultStyle: TextStyle(
                  fontFamily: 'ZenLoopRegular',
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 38),
            ),
            Padding(padding: EdgeInsets.all(2.10)),
            Text(
              'Myanmar',
              style: TextStyle(
                  fontFamily: 'OdibeeSans',
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            )
          ],
        )));
  }

  delayTime() async {
    await _getStorageData();
    await Future.delayed(Duration(seconds: 2));
    return new Timer(_timerDuration, navigateToPage);
  }

  Future<Null> _getStorageData() async {
    _firstTimeUse = await _storage.read(key: AppSetting.firstTimeAppUse);
  }

  void navigateToPage() {
    if (_firstTimeUse == null || _firstTimeUse != AppSetting.usedApp) {
      Navigator.pushReplacementNamed(context, LocationPicker.route);
    } else {
      Navigator.pushReplacementNamed(context, Home.route);
    }
  }
}
