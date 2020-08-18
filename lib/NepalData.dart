import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nepali_utils/nepali_utils.dart';

class NepalData extends StatelessWidget {
  final List<dynamic> data;
  NepalData({this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red[100].withOpacity(0.4),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 0.0, top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                //Infected
                TemplateBox(
                  label: "जम्मा संक्रमित",
                  color: Colors.red,
                  value: "${data[0]['tested_positive']}",
                ),
                //Recovered
                TemplateBox(
                  label: "निको भएका",
                  color: Colors.green[800],
                  value: "${data[0]['recovered']}",
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                //Deaths
                TemplateBox(
                  label: "जम्मा मृत्यु",
                  color: Colors.blue,
                  value: "${data[0]['deaths']}",
                ),
                TemplateBox(
                  label: "जम्मा अईसोलेशनमा",
                  color: Colors.grey,
                  value: "${data[0]['in_isolation']}",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TemplateBox extends StatelessWidget {
  const TemplateBox({
    Key key,
    @required this.value,
    @required this.color,
    @required this.label,
  }) : super(key: key);

  final String value;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          toNepali("$value"),
          style: GoogleFonts.mukta(
            height: 1.4,
            textStyle: TextStyle(
              color: color,
              fontSize: 40.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Text(
          label,
          style: GoogleFonts.mukta(
            height: 1.2,
            textStyle: TextStyle(
              color: color,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

//@WORK function : convert Nepali Unicode Text to NEPALI
String toNepali(String englishText) {
  return NepaliUnicode.convert(englishText);
}
