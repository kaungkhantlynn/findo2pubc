import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:o2findermyanmar/bloc/services/services_bloc.dart';
import 'package:o2findermyanmar/constant/app_setting.dart';
import 'package:o2findermyanmar/network/model/oxygen_duration_model.dart';

import 'package:o2findermyanmar/ui/pages/detail.dart';
import 'package:o2findermyanmar/ui/pages/location_picker.dart';
import 'package:o2findermyanmar/ui/widgets/supporter_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';

class OxygenDuration extends StatefulWidget {
  static const String route = '/oxygen_duration';

  int? divisionId;
  int? townshipId;

  OxygenDuration({
    Key? key,
    this.divisionId,
    this.townshipId,
  }) : super(key: key);

  @override
  _OxygenDurationState createState() => _OxygenDurationState();
}

class ScreenArguments {
  final String serviceId;

  ScreenArguments(this.serviceId);
}

class _OxygenDurationState extends State<OxygenDuration> {
  String? _psiValue = " ";
  String? _cylinderSizeValue = " ";
  String? _flowRateValue = " ";

  static const List<String> _psiSelections = [
    "600 psi",
    "800 psi",
    "1000 psi",
    "1200 psi",
    "1400 psi",
    "1500 psi",
    "1800 psi",
    "2000 psi"
  ];
  static const List<String> _cylinderSizes = [
    "5 L",
    "10 L",
    "15 L",
    "20 L",
    "25 L",
    "30 L",
    "35 L",
    "40 L"
  ];
  static const List<String> _flowRates = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];

  TextEditingController _pressureController = TextEditingController();
  TextEditingController _cylinderController = TextEditingController();
  TextEditingController _amountArrayController = TextEditingController();

  late String selectedPsi = '';
  late String selectedCylinder = '';
  late String selectedAmountArray = '';

  late String dayText = '00';
  late String hourText = '00';
  late String minuteText = '00';

  late OxygenDurationModel oxygenDurationModel = new OxygenDurationModel();

  Future loadJsonData() async {
    var jsonData =
        await rootBundle.loadString('assets/json/oxygen_duration.json');
    final jsonResponse = json.decode(jsonData);
    setState(() {
      oxygenDurationModel = OxygenDurationModel.fromJson(jsonResponse);
    });

    print(oxygenDurationModel.p600si!.l10L);
  }

  @override
  void initState() {
    super.initState();
    this.loadJsonData();
  }

  @override
  Widget build(BuildContext contex) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Oxygen Duration',
          style:
              TextStyle(color: Colors.pink[800], fontFamily: 'RobotoRegular'),
        ),
        iconTheme: new IconThemeData(color: Colors.pink[800]),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: mediaQuery.size.width,
                margin: EdgeInsets.all(10),
                padding:
                    EdgeInsets.only(left: 15, right: 15, bottom: 30, top: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.10),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5.5),
                      margin: EdgeInsets.only(bottom: 8),
                      child: Text(
                        'ကြာချိန်',
                        style: TextStyle(
                            fontFamily: 'MyanmarHeadOne',
                            color: HexColor('#605D73'),
                            fontWeight: FontWeight.w700,
                            fontSize: 22),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(padding: EdgeInsets.all(5.10)),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5.5),
                                    child: Text(
                                      'ရက်',
                                      style: TextStyle(
                                          fontFamily: 'MyanmarSansPro',
                                          color: Colors.pink.shade800,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 21),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5.5),
                                    child: Text(
                                      dayText,
                                      style: TextStyle(
                                        fontFamily: 'Digital',
                                        color: Colors.grey.shade600,
                                        fontSize: 30,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5.5),
                                    child: Text(
                                      'နာရီ',
                                      style: TextStyle(
                                          fontFamily: 'MyanmarSansPro',
                                          color: Colors.pink.shade800,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 21),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5.5),
                                    child: Text(
                                      hourText,
                                      style: TextStyle(
                                        fontFamily: 'Digital',
                                        color: Colors.grey.shade600,
                                        fontSize: 30,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5.5),
                                    child: Text(
                                      'မိနစ်',
                                      style: TextStyle(
                                          fontFamily: 'MyanmarSansPro',
                                          color: Colors.pink.shade800,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 21),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5.5),
                                    child: Text(
                                      minuteText,
                                      style: TextStyle(
                                        fontFamily: 'Digital',
                                        color: Colors.grey.shade600,
                                        fontSize: 30,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(padding: EdgeInsets.all(5.10)),
                            ],
                          ),
                        ),
                        Container(
                          child: Image.asset(
                            'assets/images/time.png',
                            width: mediaQuery.size.width / 2.4,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),

              //pressure
              InkWell(
                onTap: () {
                  SelectDialog.showModal<String>(context,
                      showSearchBox: false,
                      items: _psiSelections,
                      label: 'Select PSI',
                      selectedValue: selectedPsi, itemBuilder:
                          (BuildContext context, String item, bool isSelected) {
                    return Container(
                      decoration: !isSelected
                          ? null
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                      child: ListTile(
                        selected: isSelected,
                        title: Text(item),
                      ),
                    );
                  }, onChange: (String selected) {
                    setState(() {
                      selectedPsi = selected;
                      _pressureController.text = selectedPsi;
                      if (selectedAmountArray != '') {
                        calculateDuration(selectedPsi, selectedCylinder,
                            int.parse(selectedAmountArray));
                      }
                    });
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  width: double.infinity,
                  padding:
                      EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.10),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5.5),
                        child: Text(
                          'ဖိအား',
                          style: TextStyle(
                              fontFamily: 'MyanmarHeadOne',
                              color: HexColor('#605D73'),
                              fontWeight: FontWeight.w500,
                              fontSize: 22),
                        ),
                      ),
                      TextFormField(
                        enabled: false,
                        autofocus: false,
                        controller: _pressureController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "ဖိအား ရွေးချယ်ရန်";
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.arrow_drop_down_circle,
                              color: HexColor('#9692AE'),
                              size: 30,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent, //this has no effect
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            errorBorder: OutlineInputBorder(
                                gapPadding: 10,
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            hintText: "Select PSI",
                            errorStyle: TextStyle(height: 0, fontSize: 15),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            hintStyle: TextStyle(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w500)),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ),

              //cylinder
              InkWell(
                onTap: () {
                  SelectDialog.showModal<String>(context,
                      showSearchBox: false,
                      items: _cylinderSizes,
                      label: 'Select Cylinder',
                      selectedValue: selectedCylinder, itemBuilder:
                          (BuildContext context, String item, bool isSelected) {
                    return Container(
                      decoration: !isSelected
                          ? null
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                      child: ListTile(
                        selected: isSelected,
                        title: Text(item),
                      ),
                    );
                  }, onChange: (String selected) {
                    setState(() {
                      selectedCylinder = selected;
                      _cylinderController.text = selectedCylinder;
                      if (selectedAmountArray != '') {
                        calculateDuration(selectedPsi, selectedCylinder,
                            int.parse(selectedAmountArray));
                      }
                    });
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  width: double.infinity,
                  padding:
                      EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.10),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5.5),
                        child: Text(
                          'အိုးအရွယ်အစား',
                          style: TextStyle(
                              fontFamily: 'MyanmarHeadOne',
                              color: HexColor('#605D73'),
                              fontWeight: FontWeight.w500,
                              fontSize: 22),
                        ),
                      ),
                      TextFormField(
                        enabled: false,
                        autofocus: false,
                        controller: _cylinderController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "အိုးအရွယ်အစား ရွေးချယ်ရန်";
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.arrow_drop_down_circle,
                              color: HexColor('#9692AE'),
                              size: 30,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent, //this has no effect
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            errorBorder: OutlineInputBorder(
                                gapPadding: 10,
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            hintText: "Select Cylinder Size (L)",
                            errorStyle: TextStyle(height: 0, fontSize: 15),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            hintStyle: TextStyle(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w500)),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ),

              //
              InkWell(
                onTap: () {
                  SelectDialog.showModal<String>(context,
                      showSearchBox: false,
                      items: _flowRates,
                      label: 'Select Amount For Patient',
                      selectedValue: selectedAmountArray, itemBuilder:
                          (BuildContext context, String item, bool isSelected) {
                    return Container(
                      decoration: !isSelected
                          ? null
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                      child: ListTile(
                        selected: isSelected,
                        title: Text(item),
                      ),
                    );
                  }, onChange: (String selected) {
                    setState(() {
                      selectedAmountArray = selected;
                      _amountArrayController.text =
                          selectedAmountArray + ' L/min';

                      if (selectedAmountArray != '') {
                        calculateDuration(selectedPsi, selectedCylinder,
                            int.parse(selectedAmountArray));
                      }
                    });
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  width: double.infinity,
                  padding:
                      EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.10),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5.5),
                        child: Text(
                          'လူနာကိုပေးရသောပမာဏ',
                          style: TextStyle(
                              fontFamily: 'MyanmarHeadOne',
                              color: HexColor('#605D73'),
                              fontWeight: FontWeight.w500,
                              fontSize: 22),
                        ),
                      ),
                      TextFormField(
                        enabled: false,
                        autofocus: false,
                        controller: _amountArrayController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "လူနာကိုပေးရသောပမာဏ ရွေးချယ်ရန်";
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.arrow_drop_down_circle,
                              color: HexColor('#9692AE'),
                              size: 30,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent, //this has no effect
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            errorBorder: OutlineInputBorder(
                                gapPadding: 10,
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            hintText: "Select Flow Rate (L/min)",
                            errorStyle: TextStyle(height: 0, fontSize: 15),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            hintStyle: TextStyle(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w500)),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void calculateDuration(String psi, String cylinder, int flowrates) {
    if (psi != " " && cylinder != " " && flowrates != " ") {
      if (psi == '600 psi') {
        if (cylinder == '5 L') {
          // print('MYPSI' + psi + 'MYCYLIN' + cylinder);
          splitByColon(oxygenDurationModel.p600si!.l5L![flowrates - 1]);
        }
        if (cylinder == '10 L') {
          splitByColon(oxygenDurationModel.p600si!.l10L![flowrates - 1]);
        }
        if (cylinder == '15 L') {
          splitByColon(oxygenDurationModel.p600si!.l15L![flowrates - 1]);
        }
        if (cylinder == '20 L') {
          splitByColon(oxygenDurationModel.p600si!.l20L![flowrates - 1]);
        }
        if (cylinder == '25 L') {
          splitByColon(oxygenDurationModel.p600si!.l25L![flowrates - 1]);
        }
        if (cylinder == '30 L') {
          splitByColon(oxygenDurationModel.p600si!.l30L![flowrates - 1]);
        }
        if (cylinder == '35 L') {
          splitByColon(oxygenDurationModel.p600si!.l35L![flowrates - 1]);
        }
        if (cylinder == '40 L') {
          splitByColon(oxygenDurationModel.p600si!.l40L![flowrates - 1]);
        }
      }

      if (psi == '800 psi') {
        if (cylinder == '5 L') {
          // print('MYPSI' + psi + 'MYCYLIN' + cylinder);
          splitByColon(oxygenDurationModel.p800Psi!.l5L![flowrates - 1]);
        }
        if (cylinder == '10 L') {
          splitByColon(oxygenDurationModel.p800Psi!.l10L![flowrates - 1]);
        }
        if (cylinder == '15 L') {
          splitByColon(oxygenDurationModel.p800Psi!.l15L![flowrates - 1]);
        }
        if (cylinder == '20 L') {
          splitByColon(oxygenDurationModel.p800Psi!.l20L![flowrates - 1]);
        }
        if (cylinder == '25 L') {
          splitByColon(oxygenDurationModel.p800Psi!.l25L![flowrates - 1]);
        }
        if (cylinder == '30 L') {
          splitByColon(oxygenDurationModel.p800Psi!.l30L![flowrates - 1]);
        }
        if (cylinder == '35 L') {
          splitByColon(oxygenDurationModel.p800Psi!.l35L![flowrates - 1]);
        }
        if (cylinder == '40 L') {
          splitByColon(oxygenDurationModel.p800Psi!.l40L![flowrates - 1]);
        }
      }

      if (psi == '1000 psi') {
        if (cylinder == '5 L') {
          // print('MYPSI' + psi + 'MYCYLIN' + cylinder);
          splitByColon(oxygenDurationModel.p1000Psi!.l5L![flowrates - 1]);
        }
        if (cylinder == '10 L') {
          splitByColon(oxygenDurationModel.p1000Psi!.l10L![flowrates - 1]);
        }
        if (cylinder == '15 L') {
          splitByColon(oxygenDurationModel.p1000Psi!.l15L![flowrates - 1]);
        }
        if (cylinder == '20 L') {
          splitByColon(oxygenDurationModel.p1000Psi!.l20L![flowrates - 1]);
        }
        if (cylinder == '25 L') {
          splitByColon(oxygenDurationModel.p1000Psi!.l25L![flowrates - 1]);
        }
        if (cylinder == '30 L') {
          splitByColon(oxygenDurationModel.p1000Psi!.l30L![flowrates - 1]);
        }
        if (cylinder == '35 L') {
          splitByColon(oxygenDurationModel.p1000Psi!.l35L![flowrates - 1]);
        }
        if (cylinder == '40 L') {
          splitByColon(oxygenDurationModel.p1000Psi!.l40L![flowrates - 1]);
        }
      }

      if (psi == '1200 psi') {
        if (cylinder == '5 L') {
          // print('MYPSI' + psi + 'MYCYLIN' + cylinder);
          splitByColon(oxygenDurationModel.p1200Psi!.l5L![flowrates - 1]);
        }
        if (cylinder == '10 L') {
          splitByColon(oxygenDurationModel.p1200Psi!.l10L![flowrates - 1]);
        }
        if (cylinder == '15 L') {
          splitByColon(oxygenDurationModel.p1200Psi!.l15L![flowrates - 1]);
        }
        if (cylinder == '20 L') {
          splitByColon(oxygenDurationModel.p1200Psi!.l20L![flowrates - 1]);
        }
        if (cylinder == '25 L') {
          splitByColon(oxygenDurationModel.p1200Psi!.l25L![flowrates - 1]);
        }
        if (cylinder == '30 L') {
          splitByColon(oxygenDurationModel.p1200Psi!.l30L![flowrates - 1]);
        }
        if (cylinder == '35 L') {
          splitByColon(oxygenDurationModel.p1200Psi!.l35L![flowrates - 1]);
        }
        if (cylinder == '40 L') {
          splitByColon(oxygenDurationModel.p1200Psi!.l40L![flowrates - 1]);
        }
      }

      if (psi == '1400 psi') {
        if (cylinder == '5 L') {
          // print('MYPSI' + psi + 'MYCYLIN' + cylinder);
          splitByColon(oxygenDurationModel.p1400Psi!.l5L![flowrates - 1]);
        }
        if (cylinder == '10 L') {
          splitByColon(oxygenDurationModel.p1400Psi!.l10L![flowrates - 1]);
        }
        if (cylinder == '15 L') {
          splitByColon(oxygenDurationModel.p1400Psi!.l15L![flowrates - 1]);
        }
        if (cylinder == '20 L') {
          splitByColon(oxygenDurationModel.p1400Psi!.l20L![flowrates - 1]);
        }
        if (cylinder == '25 L') {
          splitByColon(oxygenDurationModel.p1400Psi!.l25L![flowrates - 1]);
        }
        if (cylinder == '30 L') {
          splitByColon(oxygenDurationModel.p1400Psi!.l30L![flowrates - 1]);
        }
        if (cylinder == '35 L') {
          splitByColon(oxygenDurationModel.p1400Psi!.l35L![flowrates - 1]);
        }
        if (cylinder == '40 L') {
          splitByColon(oxygenDurationModel.p1400Psi!.l40L![flowrates - 1]);
        }
      }

      if (psi == '1500 psi') {
        if (cylinder == '5 L') {
          // print('MYPSI' + psi + 'MYCYLIN' + cylinder);
          splitByColon(oxygenDurationModel.p1500Psi!.l5L![flowrates - 1]);
        }
        if (cylinder == '10 L') {
          splitByColon(oxygenDurationModel.p1500Psi!.l10L![flowrates - 1]);
        }
        if (cylinder == '15 L') {
          splitByColon(oxygenDurationModel.p1500Psi!.l15L![flowrates - 1]);
        }
        if (cylinder == '20 L') {
          splitByColon(oxygenDurationModel.p1500Psi!.l20L![flowrates - 1]);
        }
        if (cylinder == '25 L') {
          splitByColon(oxygenDurationModel.p1500Psi!.l25L![flowrates - 1]);
        }
        if (cylinder == '30 L') {
          splitByColon(oxygenDurationModel.p1500Psi!.l30L![flowrates - 1]);
        }
        if (cylinder == '35 L') {
          splitByColon(oxygenDurationModel.p1500Psi!.l35L![flowrates - 1]);
        }
        if (cylinder == '40 L') {
          splitByColon(oxygenDurationModel.p1500Psi!.l40L![flowrates - 1]);
        }
      }

      if (psi == '1800 psi') {
        if (cylinder == '5 L') {
          // print('MYPSI' + psi + 'MYCYLIN' + cylinder);
          splitByColon(oxygenDurationModel.p1800Psi!.l5L![flowrates - 1]);
        }
        if (cylinder == '10 L') {
          splitByColon(oxygenDurationModel.p1800Psi!.l10L![flowrates - 1]);
        }
        if (cylinder == '15 L') {
          splitByColon(oxygenDurationModel.p1800Psi!.l15L![flowrates - 1]);
        }
        if (cylinder == '20 L') {
          splitByColon(oxygenDurationModel.p1800Psi!.l20L![flowrates - 1]);
        }
        if (cylinder == '25 L') {
          splitByColon(oxygenDurationModel.p1800Psi!.l25L![flowrates - 1]);
        }
        if (cylinder == '30 L') {
          splitByColon(oxygenDurationModel.p1800Psi!.l30L![flowrates - 1]);
        }
        if (cylinder == '35 L') {
          splitByColon(oxygenDurationModel.p1800Psi!.l35L![flowrates - 1]);
        }
        if (cylinder == '40 L') {
          splitByColon(oxygenDurationModel.p1800Psi!.l40L![flowrates - 1]);
        }
      }

      if (psi == '2000 psi') {
        if (cylinder == '5 L') {
          // print('MYPSI' + psi + 'MYCYLIN' + cylinder);
          splitByColon(oxygenDurationModel.p2000Psi!.l5L![flowrates - 1]);
        }
        if (cylinder == '10 L') {
          splitByColon(oxygenDurationModel.p2000Psi!.l10L![flowrates - 1]);
        }
        if (cylinder == '15 L') {
          splitByColon(oxygenDurationModel.p2000Psi!.l15L![flowrates - 1]);
        }
        if (cylinder == '20 L') {
          splitByColon(oxygenDurationModel.p2000Psi!.l20L![flowrates - 1]);
        }
        if (cylinder == '25 L') {
          splitByColon(oxygenDurationModel.p2000Psi!.l25L![flowrates - 1]);
        }
        if (cylinder == '30 L') {
          splitByColon(oxygenDurationModel.p2000Psi!.l30L![flowrates - 1]);
        }
        if (cylinder == '35 L') {
          splitByColon(oxygenDurationModel.p2000Psi!.l35L![flowrates - 1]);
        }
        if (cylinder == '40 L') {
          splitByColon(oxygenDurationModel.p2000Psi!.l40L![flowrates - 1]);
        }
      }
    }
  }

  void splitByColon(String result) {
    print('MYRESULT' + result);
    var splitted = result.split(':');
    if (splitted.length <= 2) {
      setState(() {
        hourText = splitted[0];
        minuteText = splitted[1];
      });
    } else {
      setState(() {
        dayText = splitted[0];
        hourText = splitted[1];
        minuteText = splitted[2];
      });
    }
    // print("MYSPLITTED" + splitted.toString());
  }
}
