import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:o2findermyanmar/bloc/service_detail_bloc/service_detail_bloc.dart';
import 'package:o2findermyanmar/ui/pages/home.dart';
import 'package:url_launcher/url_launcher.dart';

class Detail extends StatefulWidget {
  String? id;
  static const String route = '/detail';
  Detail({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  late ServiceDetailBloc serviceDetailBloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<void> _launched;
  void initState() {
    super.initState();

    serviceDetailBloc = BlocProvider.of<ServiceDetailBloc>(context);
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    serviceDetailBloc..add(GetServiceDetail(id: args.serviceId));
    print('PASS ID' + args.serviceId);
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'အသေးစိတ်',
          style: TextStyle(
              fontFamily: 'MyanmarHeadOne',
              color: Colors.pink.shade800,
              fontWeight: FontWeight.w500,
              fontSize: 20),
        ),
        iconTheme: new IconThemeData(color: Colors.pink[800]),
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<ServiceDetailBloc, ServiceDetailState>(
          builder: (context, state) {
        if (state is ServiceDetailLoaded) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.all(30)),
                  Stack(
                    alignment: Alignment.center,
                    textDirection: TextDirection.rtl,
                    fit: StackFit.loose,
                    overflow: Overflow.visible,
                    clipBehavior: Clip.hardEdge,
                    children: [
                      Container(
                        width: mediaQuery.size.width,
                        margin: EdgeInsets.all(20.10),
                        padding: EdgeInsets.all(30.10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 1),
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 30),
                              padding: EdgeInsets.all(10.10),
                              child: Text(
                                state.serviceDetailModel!.data!.name!,
                                style: TextStyle(
                                    fontFamily: 'MyanmarHeadOne',
                                    fontSize: 25,
                                    color: HexColor('#484761')),
                              ),
                            ),
                            // Container(
                            //   child: Text(
                            //     state.serviceDetailModel!.data!.name!,
                            //     style: TextStyle(
                            //         fontFamily: 'MyanmarSansPro',
                            //         fontSize: 20,
                            //         color: Colors.black54),
                            //   ),
                            // ),
                            // Visibility(
                            //     visible:
                            //         state.serviceDetailModel!.data!.types! !=
                            //             "null",
                            //     child: Container(
                            //       margin: EdgeInsets.only(top: 20),
                            //       child: Text(
                            //         state.serviceDetailModel!.data!.types!,
                            //         style: TextStyle(
                            //             fontFamily: 'MyanmarChatu',
                            //             fontSize: 20,
                            //             color: Colors.pink.shade800),
                            //       ),
                            //     )),
                          ],
                        ),
                      ),
                      Positioned(
                          left: 0,
                          right: 0,
                          top: -35,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                shape: BoxShape.circle),
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/oxygen.jpeg'),
                              radius: 50,
                            ),
                            width: 100,
                          )),
                    ],
                  ),

                  // Container(
                  //   margin: EdgeInsets.only(top: 20, left: 20),
                  //   child: Text(
                  //     'Fees',
                  //     style: TextStyle(
                  //         fontFamily: 'RobotoRegular',
                  //         color: Colors.black26,
                  //         fontWeight: FontWeight.w600,
                  //         fontSize: 18),
                  //   ),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 10, left: 20),
                  //   child: Text(
                  //     '၃၀၀၀ ကျပ်',
                  //     style: TextStyle(
                  //         fontFamily: 'Pyidaungsu',
                  //         color: HexColor('#605D73'),
                  //         fontWeight: FontWeight.w900,
                  //         fontSize: 20),
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      'Phone',
                      style: TextStyle(
                          fontFamily: 'RobotoRegular',
                          color: Colors.black26,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 20),
                    child: Column(
                        children: state.serviceDetailModel!.data!.phones!
                            .map((item) => new Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            item,
                                            style: TextStyle(
                                                letterSpacing: 2.1,
                                                fontFamily: 'Pyidaungsu',
                                                color: HexColor('#605D73'),
                                                fontWeight: FontWeight.w900,
                                                fontSize: 20),
                                          ),
                                          Padding(padding: EdgeInsets.all(3.3)),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                _launched = _makePhoneCall(
                                                    'tel:' + item);
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(5.5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.8),
                                                  color: Colors.grey.shade200),
                                              child: Center(
                                                child: Icon(
                                                  Icons.phone,
                                                  color: Colors.green.shade800,
                                                  size: 27,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(padding: EdgeInsets.all(5.5)),
                                    ],
                                  ),
                                ))
                            .toList()),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      'Address',
                      style: TextStyle(
                          fontFamily: 'RobotoRegular',
                          color: Colors.black26,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      state.serviceDetailModel!.data!.address!,
                      style: TextStyle(
                          fontFamily: 'Pyidaungsu',
                          color: HexColor('#605D73'),
                          fontWeight: FontWeight.w900,
                          fontSize: 20),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      'City',
                      style: TextStyle(
                          fontFamily: 'RobotoRegular',
                          color: Colors.black26,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      state.serviceDetailModel!.data!.township != null
                          ? state.serviceDetailModel!.data!.township!.name!
                          : '--',
                      style: TextStyle(
                          fontFamily: 'Pyidaungsu',
                          color: HexColor('#605D73'),
                          fontWeight: FontWeight.w900,
                          fontSize: 20),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      'Region',
                      style: TextStyle(
                          fontFamily: 'RobotoRegular',
                          color: Colors.black26,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      state.serviceDetailModel!.data!.region!.name!,
                      style: TextStyle(
                          fontFamily: 'Pyidaungsu',
                          color: HexColor('#605D73'),
                          fontWeight: FontWeight.w900,
                          fontSize: 20),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      'Remark',
                      style: TextStyle(
                          fontFamily: 'RobotoRegular',
                          color: Colors.black26,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                  Visibility(
                    visible: state.serviceDetailModel!.data!.isActive!,
                    child: Container(
                      margin: EdgeInsets.only(top: 10, left: 20),
                      padding: EdgeInsets.all(5.5),
                      child: Text(
                        state.serviceDetailModel!.data!.updatedAt! +
                            ' က နောက်ဆုံးဆက်သွယ်ထားပါတယ်ရှင့်',
                        style: TextStyle(
                            fontFamily: 'Pyidaungsu',
                            color: HexColor('#605D73'),
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !state.serviceDetailModel!.data!.isActive!,
                    child: Container(
                      margin: EdgeInsets.only(top: 10, left: 20, right: 8),
                      child: Text(
                        state.serviceDetailModel!.data!.updatedAt! +
                            ' က နောက်ဆုံးဆက်သွယ်ထားပါတယ်ရှင့်၊ အရေးကြီးပါကမိမိသဘောအတိုင်းဆက်သွယ်ကြည့်နိုင်ပါတယ်ရှင့်',
                        style: TextStyle(
                            fontFamily: 'Pyidaungsu',
                            color: HexColor('#605D73'),
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }),
    );
  }
}
