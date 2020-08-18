import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NpTest extends StatefulWidget {
  @override
  _NpTestState createState() => _NpTestState();
}

class _NpTestState extends State<NpTest> {
  TextEditingController longUrl = TextEditingController();
  TextEditingController alias = TextEditingController();

  List<dynamic> urlData;
  String helperBox = "CUSTOM_TEXT";
  bool loaded = false;
  bool showProgressBar = false;
  Future makeRequest(String url) async {
    print(url);
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    if (this.mounted) {
      setState(() {
        var parsedData = json.decode(utf8.decode(response.bodyBytes));
        urlData = [parsedData];
      });
      loaded = true;
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("URL shortner"),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 5.0,
              ),
              TextField(
                controller: longUrl,
                decoration: InputDecoration(
                  labelText: "Long URL",
                  enabled: true,
                  border: OutlineInputBorder(),
                  hintText: "Enter your long URL here",
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              TextField(
                onChanged: (alias) {
                  helperBox = alias.toString().toUpperCase();
                },
                controller: alias,
                decoration: InputDecoration(
                  labelText: "Custom Text",
                  enabled: true,
                  border: OutlineInputBorder(),
                  hintText: "https://shoturl.co/CUSTOM_TEXT",
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              showProgressBar == true ? LinearProgressIndicator() : Container(),
              Container(
                height: 45.0,
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    if (longUrl.text.length < 8) {
                      print("Please Enter a Valid ULL");
                    } else {
                      setState(() {
                        showProgressBar = true;
                        loaded = false;
                        if (urlData != null) {
                          urlData.clear();
                        }
                        this
                            .makeRequest(
                          "https://shoturl.co/api/?key=KoXM28SB92NG&url=${longUrl.text}&custom=${alias.text}",
                        )
                            .whenComplete(() {
                          showProgressBar = false;
                        });
                      });
                    }
                  },
                  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.content_cut,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        "Shorten",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              loaded == true
                  ? urlData[0]['error'] == 1
                      ? ResultBox(
                          textColor: Colors.red[800],
                          backgroundColor: Colors.red[100],
                          message: urlData[0]['msg'].toString(),
                        )
                      : ResultBox(
                          textColor: Colors.green[800],
                          backgroundColor: Colors.green[100],
                          message: urlData[0]['short'].toString(),
                        )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultBox extends StatelessWidget {
  final Color textColor;
  final Color backgroundColor;
  final String message;
  ResultBox({
    this.textColor,
    this.backgroundColor,
    this.message,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 100.0,
        width: double.infinity,
        color: backgroundColor,
        // child: Center(child: Text("https://shoturl.co/$helperBox")),
        child: Center(
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      onLongPress: () {
        Clipboard.setData(ClipboardData(
          text: message,
        )).whenComplete(() {
          final snackBar = SnackBar(
            backgroundColor: Colors.green[700],
            content: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.content_copy,
                  size: 20.0,
                ),
                Text(
                  "Copied to Clipboard!",
                ),
              ],
            ),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        });
      },
    );
  }
}
