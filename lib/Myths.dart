import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class CoronaMyths extends StatefulWidget {
  @override
  _CoronaMythsState createState() => _CoronaMythsState();
}

class _CoronaMythsState extends State<CoronaMyths> {
  List<dynamic> myths;
  bool mythLoaded = false;
  String url = "https://nepalcorona.info/api/v1/myths";
  Future get makeRequest async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    if (this.mounted) {
      setState(() {
        print("Please Wait for data!");
        var parsedData = json.decode(utf8.decode(response.bodyBytes));
        // var parsedData = json.decode(response.body);
        myths = [parsedData];
        print("Data Fetched from server Successfully.");
      });
      mythLoaded = true;
    } else {}
  }

  @override
  void initState() {
    this.makeRequest;
    super.initState();
    print("Data Fecthing Started..");
    print("This app is made by Nirdesh Pokharel.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid-19 Myths"),
      ),
      body: mythLoaded == false
          ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            )
          : ListView.builder(
              itemCount: myths[0]['data'].length - 1,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(17.0),
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 4.0, bottom: 8.0, right: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(17.0),
                        child: ExpansionTile(
                          trailing: Icon(Icons.ac_unit),
                          leading: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            radius: 20.0,
                          ),
                          title: Text(
                            "${myths[0]['data'][index]['myth_np'].toString().trim()}",
                            style: GoogleFonts.mukta(
                              height: 1.4,
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 10.0),
                              child: Text(
                                "${myths[0]['data'][index]['reality_np'].toString().trim()}",
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.mukta(
                                    textStyle: TextStyle(fontSize: 20.0)),
                              ),
                            ),
                            Image.network(
                                "${myths[0]['data'][index]['image_url']}"),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
