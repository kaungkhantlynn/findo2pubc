import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:o2findermyanmar/constant/svg_constant.dart';

class SupporterCard extends StatelessWidget {
  String name;
  String timeago;
  bool isActive;
  String desc;

  SupporterCard({
    Key? key,
    required this.name,
    required this.isActive,
    required this.timeago,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.10),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(
                          left: 23.5, right: 17.5, bottom: 25.5, top: 25.5),
                      decoration: BoxDecoration(
                          color: Colors.pink.shade800,
                          borderRadius: BorderRadius.circular(14.3)),
                      child: Center(
                        child: Text(
                          name.substring(0, 1),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'MyanmarChatu',
                              fontSize: 18),
                        ),
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: mediaQuery.size.width - 206,
                        padding: EdgeInsets.all(3.3),
                        child: Text(
                          name,
                          style: TextStyle(
                              fontFamily: 'Pyidaungsu',
                              fontWeight: FontWeight.w500,
                              fontSize: 19,
                              color: Colors.black87),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.string(
                            SvgConstant.time,
                            width: 20,
                            height: 20,
                            color: HexColor('#FFA900'),
                          ),
                          Padding(padding: EdgeInsets.all(2.2)),
                          Text(
                            timeago,
                            style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: 16,
                                color: Colors.amber.shade800),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(right: 18.10),
                padding:
                    EdgeInsets.only(left: 4, right: 4, top: 3.4, bottom: 3.5),
                decoration: BoxDecoration(
                    color: isActive ? Colors.green[50] : Colors.amber[50],
                    borderRadius: BorderRadius.circular(10.10)),
                child: Text(
                  isActive ? 'Active' : 'Inactive',
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: 18,
                    color: isActive ? Colors.green[800] : Colors.amber[800],
                  ),
                ),
              )
            ],
          ),
          Padding(padding: EdgeInsets.all(5.5)),
          Container(
            padding: EdgeInsets.only(left: 25.5, right: 25.5, bottom: 25.5),
            child: Text(
              desc,
              style: TextStyle(
                  fontFamily: 'MyanmarSansPro',
                  color: Colors.black54,
                  fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
