import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:o2findermyanmar/bloc/volunteer/volunteer_bloc.dart';

class About extends StatefulWidget {
  static const String route = '/about';
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'ကျွန်ုပ်တို့အကြောင်း',
          style: TextStyle(
              fontFamily: 'MyanmarHeadOne',
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w500,
              fontSize: 20),
        ),
        iconTheme: new IconThemeData(color: Colors.pink[800]),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.all(10.10),
                  padding: EdgeInsets.all(10.10),
                  child: Image.asset('assets/images/team.png')),
              Container(
                margin: EdgeInsets.only(left: 20, bottom: 10),
                child: Text(
                  'Version',
                  style: TextStyle(
                      fontFamily: 'MyanmarChatu',
                      color: HexColor('#605D73'),
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Text(
                  '1.0.1',
                  style: TextStyle(
                      fontFamily: 'MyanmarSansPro',
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, bottom: 10),
                child: Text(
                  'Application အကြောင်း',
                  style: TextStyle(
                      fontFamily: 'MyanmarChatu',
                      color: HexColor('#605D73'),
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'Covid 19 ကြောင့် အသက်အန္တရာယ်ရင်ဆိုင်နေရသော မိဘပြည်သူများအတွက်၊ အောက်စီဂျင် ရှာဖွေရာတွင် အထောက်အကူဖြစ်စေရန် ရည်ရွယ်ရေးသားထားပါသည်၊ အောက်စီဂျင် Service အချက်အလက်များကို ကျွန်ုပ်တို့ စေတနာ့ ဝန်ထမ်းများက တတ်နိုင်သလောက် မြေပြင်နှင့် ချိတ်ဆက်၍ အတည်ပြုထားပါသည်၊ သို့သော် ပစ္စည်းစာရင်း၊ စျေးနှုန်း စသည့် အချို့အချက်အလက်များသည် မြေပြင်မှအချက်အလက်များနှင့် အနည်းငယ်ကွဲလွဲမှုရှိနိုင်ပါသည်၊',
                  style: TextStyle(
                      fontFamily: 'MyanmarSansPro',
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, bottom: 10, top: 40),
                child: Text(
                  'စေတနာ့ဝန်ထမ်းများ',
                  style: TextStyle(
                      fontFamily: 'MyanmarChatu',
                      color: HexColor('#605D73'),
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
              Padding(padding: EdgeInsets.all(5.20)),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: BlocBuilder<VolunteerBloc, VolunteerState>(
                    builder: (context, state) {
                  if (state is VolunteersLoaded) {
                    return Column(
                        children: state.volunteers!
                            .map((item) => new Container(
                                  child: ListTile(
                                    dense: true,
                                    leading: Icon(
                                      Icons.account_circle,
                                      color: Colors.pink.shade50,
                                    ),
                                    contentPadding: EdgeInsets.all(3.3),
                                    title: Text(
                                      item.name!,
                                      style: TextStyle(
                                          fontFamily: 'MyanmarHeadOne',
                                          fontSize: 17,
                                          color: Colors.grey.shade700),
                                    ),
                                  ),
                                ))
                            .toList());
                  }
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
