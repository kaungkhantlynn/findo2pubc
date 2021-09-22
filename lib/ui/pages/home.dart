import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:o2findermyanmar/bloc/services/services_bloc.dart';
import 'package:o2findermyanmar/constant/app_setting.dart';
import 'package:o2findermyanmar/constant/svg_constant.dart';
import 'package:o2findermyanmar/ui/pages/about.dart';

import 'package:o2findermyanmar/ui/pages/detail.dart';
import 'package:o2findermyanmar/ui/pages/location_picker.dart';
import 'package:o2findermyanmar/ui/pages/oxygen_duration.dart';
import 'package:o2findermyanmar/ui/widgets/supporter_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/foundation.dart';

class Home extends StatefulWidget {
  static const String route = '/home';

  int? divisionId;
  int? townshipId;

  Home({
    Key? key,
    this.divisionId,
    this.townshipId,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class ScreenArguments {
  final String serviceId;

  ScreenArguments(this.serviceId);
}

class _HomeState extends State<Home> {
  late RefreshController _refreshController;

  String? _divisionId;

  String? _townshipId;

  final _storage = FlutterSecureStorage();
  late ServicesBloc servicesBloc;

  String? _firstTimePopup;

  void initState() {
    super.initState();

    _refreshController = RefreshController();
    servicesBloc = BlocProvider.of<ServicesBloc>(context);
    getInitData();
    servicesBloc..add(ChangeServicesKeyword());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // if (servicesBloc.state is ServicesInitial) {
    servicesBloc
      ..add(GetServices(divisionId: _divisionId, townshipId: _townshipId));
    // }
  }

  Future<Null> getInitData() async {
    _divisionId = await _storage.read(key: AppSetting.initialDivision);
    _townshipId = await _storage.read(key: AppSetting.initialTownship);
    _firstTimePopup = await _storage.read(key: AppSetting.popupFirstTime);
    print('FTP ' + _firstTimePopup.toString());

    if (servicesBloc.state is ServicesInitial) {
      servicesBloc
        ..add(GetServices(divisionId: _divisionId, townshipId: _townshipId));
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      if (_firstTimePopup == null || _firstTimePopup != AppSetting.usedPopup) {
        CoolAlert.show(
            barrierDismissible: false,
            context: context,
            title: 'မေတ္တာရပ်ခံခြင်း',
            text:
                'ပစ္စည်းစာရင်း၊ စျေးနှုန်း စသည့် အချို့အချက်အလက်များသည် မြေပြင်မှအချက်အလက်များနှင့် အနည်းငယ်ကွဲလွဲမှုရှိနိုင်ပါသည်၊',
            type: CoolAlertType.info,
            confirmBtnText: 'လက်ခံပါသည်',
            onConfirmBtnTap: () async {
              await _storage.write(
                  key: AppSetting.popupFirstTime, value: AppSetting.usedPopup);

              Navigator.pop(context);
            });
      }
    });

    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'အောက်စီဂျင် ဝန်ဆောင်မှုများ',
            style: TextStyle(
                fontFamily: 'MyanmarHeadOne',
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w500,
                fontSize: 20),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, About.route);
            },
            icon: Icon(
              LineIcons.infoCircle,
              color: Colors.pink[800],
            ),
          ),
          iconTheme: new IconThemeData(color: Colors.pink[800]),
          backgroundColor: Colors.white,
          actions: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, LocationPicker.route);
              },
              child: Container(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  LineIcons.mapMarker,
                  size: 27,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, OxygenDuration.route);
              },
              child: Container(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  LineIcons.calculator,
                  size: 27,
                ),
              ),
            ),
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: BlocListener<ServicesBloc, ServicesState>(
          listener: (context, state) {
            if (state is ServicesLoading) {}
            if (state is ServicesLoaded) {
              _refreshController
                ..loadComplete()
                ..refreshCompleted();
              if (state.hasReachedMax!) {
                _refreshController.loadNoData();
              }
            }
            if (state is ServicesError) {
              _refreshController
                ..loadFailed()
                ..refreshFailed();
            }
          },
          child: BlocBuilder<ServicesBloc, ServicesState>(
            builder: (context, state) {
              if (state is ServicesLoading) {
                return Container(
                    child: Center(
                  child: CircularProgressIndicator(),
                ));
              }

              if (state is ServicesError) {
                return Container(
                  child: Center(
                    child: Text('Something Went Wrong'),
                  ),
                );
              }
              if (state is ServicesLoaded) {
                return SmartRefresher(
                    controller: _refreshController,
                    enablePullUp: true,
                    enablePullDown: true,
                    header: WaterDropHeader(
                      waterDropColor: Colors.pink.shade800,
                    ),
                    onRefresh: () async {
                      servicesBloc
                        ..add(ShowServicesLoading())
                        ..add(GetServices(
                            divisionId: _divisionId, townshipId: _townshipId));
                    },
                    onLoading: () async {
                      servicesBloc
                        ..add(GetServices(
                            divisionId: _divisionId, townshipId: _townshipId));
                    },
                    child: state.services!.length > 0
                        ? ListView.builder(
                            primary: false,
                            itemCount: state.services!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, Detail.route,
                                      arguments: ScreenArguments(
                                          state.services![index].id!));
                                },
                                child: SupporterCard(
                                    name: state.services![index].name!,
                                    isActive: state.services![index].isActive!,
                                    timeago: state.services![index].timeAgo!,
                                    desc: state.services![index].updatedAt! +
                                        ' က နောက်ဆုံးဆက်ထားပါတယ် ရှင့်'),
                              );
                            })
                        : Container(
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "ဒေတာမရှိသေးပါ",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: "MyanmarSansPro",
                                      fontSize: 17),
                                ),
                              ),
                            ),
                          ));
              } else if (state is ServicesError) {
                _refreshController
                  ..loadFailed()
                  ..refreshFailed();
              }
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ));
  }
}
