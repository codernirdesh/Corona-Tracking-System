import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class World extends StatelessWidget {
  final List<dynamic> data;
  World({this.data});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.red[100].withOpacity(0.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  "विश्वमा",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("${data[0]['cases']}",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.red[800],
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        Text("जम्मा संक्रमित",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.red[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("${data[0]['recovered']}",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.green[800],
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        Text("निको भएका",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.green[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("${data[0]['deaths']}",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        Text("जम्मा मृत्यु",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
