import 'dart:convert';
import 'package:corona_app_nepal/Myths.dart';
import 'package:corona_app_nepal/News.dart';
import 'package:corona_app_nepal/World.dart';
import 'package:corona_app_nepal/np_test/text.dart';
import 'package:corona_app_nepal/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:corona_app_nepal/NepalData.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corona Nepal',
      color: Colors.red,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        focusColor: Colors.red,
        primarySwatch: Colors.red,
        primaryColor: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //For Nepal Data fetch
  List<dynamic> data;
  bool loaded = false;
  String url = "https://nepalcorona.info/api/v1/data/nepal";
  Future get makeRequest async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    if (this.mounted) {
      setState(() {
        print("Please Wait for data!");
        var parsedData = json.decode(utf8.decode(response.bodyBytes));
        // var parsedData = json.decode(response.body);
        data = [parsedData];
        print("Data Fetched from server Successfully.");
      });
      loaded = true;
    } else {}
  }

  //For world Data
  List<dynamic> worldData;
  bool worldLoaded = false;
  String worldUrl = "https://data.nepalcorona.info/api/v1/world";
  Future get worldRequest async {
    var response = await http
        .get(Uri.encodeFull(worldUrl), headers: {"Accept": "application/json"});
    if (this.mounted) {
      setState(() {
        print("Please Wait for data!");
        var parsedData = json.decode(utf8.decode(response.bodyBytes));
        // var parsedData = json.decode(response.body);
        worldData = [parsedData];
        print("Data Fetched from server Successfully.");
      });
      worldLoaded = true;
    } else {}
  }

  @override
  void initState() {
    this.makeRequest;
    this.worldRequest;
    super.initState();
    print("Data Fecthing Started..");
    print("This app is made by Nirdesh Pokharel.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              Container(
                height: 24.0,
                color: Colors.redAccent,
              ),
              Container(
                height: 200,
                color: Colors.red[400],
                child: Center(
                  child: Text(
                    "घरै बसौं\nसुरक्षित रहौं",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.new_releases,
                        size: 30.0,
                        color: Colors.redAccent,
                      ),
                      title: Text("कोरोना सम्बन्धित समाचार",
                          style: GoogleFonts.mukta(
                            textStyle: TextStyle(
                              fontSize: 20.0,
                            ),
                          )),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CovidNepalNews();
                        }));
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.security,
                        size: 30.0,
                        color: Colors.redAccent,
                      ),
                      title: Text(
                        "कोरोना बारे फैलिएका भ्रम",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CoronaMyths();
                        }));
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.developer_mode,
                        size: 30.0,
                        color: Colors.redAccent,
                      ),
                      title: Text(
                        "यो एप्लिकेशन बनाउने",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) {
                              return CustomUser(
                                name: "Nirdesh Pokharel",
                                post: "Student, App Developer",
                                content: "Making Technology FUN!",
                                facebook: "https://fb.com/nirdeshpokhrel11",
                                instagram:
                                    "https://instagram.com/pokhrel_nirdesh",
                                twitter: "https://twitter.com/pokhrel_nirdesh",
                                phone: "9824930501",
                                image: Image.asset("images/Developer.jpg"),
                                buttonText: "Okay!",
                              );
                            });
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.security,
                        size: 30.0,
                        color: Colors.redAccent,
                      ),
                      title: Text(
                        "URL shortner",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return NpTest();
                        }));
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("Covid-19 Nepal"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  setState(() {
                    loaded = false;
                    worldLoaded = false;
                    data.clear();
                    worldData.clear();
                    this.makeRequest; //Calling function
                    this.worldRequest; // Calling Function
                  });
                })
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              loaded
                  ? NepalData(
                      data: data,
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[CircularProgressIndicator()],
                      ),
                    ),
              worldLoaded == true
                  ? World(
                      data: worldData,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[CircularProgressIndicator()],
                        ),
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    elevation: 0.0,
                    hoverElevation: 5.0,
                    child: Text("कोरोना सम्बन्धि समाचार"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return CovidNepalNews();
                        }),
                      );
                    },
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  RaisedButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    elevation: 0.0,
                    hoverElevation: 5.0,
                    child: Text("Covid19 Myths"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return CoronaMyths();
                        }),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
