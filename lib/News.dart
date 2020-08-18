import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:nepali_utils/nepali_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class CovidNepalNews extends StatefulWidget {
  @override
  _CovidNepalNewsState createState() => _CovidNepalNewsState();
}

class _CovidNepalNewsState extends State<CovidNepalNews> {
  List<dynamic> news;
  bool newsLoaded = false;
  String url = "https://nepalcorona.info/api/v1/news";
  Future get getNews async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    if (this.mounted) {
      setState(() {
        print("Please Wait for data!");
        var parsedData = json.decode(utf8.decode(response.bodyBytes));
        // var parsedData = json.decode(response.body);
        news = [parsedData];
        print("Data Fetched from server Successfully.");
      });
      newsLoaded = true;
    } else {}
  }

  @override
  void initState() {
    this.getNews;
    super.initState();
    print("News Fecthing Started..");
    print("This app is made by Nirdesh Pokharel.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  newsLoaded = false;
                  news.clear();
                  this.getNews;
                });
              }),
        ],
        title: Text("Covid19 News (Nepal)"),
      ),
      body: newsLoaded == false
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: news[0]['data'][0]['_id'].length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 8.0),
                  child: InkWell(
                    child: Material(
                      borderRadius: BorderRadius.circular(17.0),
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${news[0]['data'][index]['title']}",
                              style: GoogleFonts.khand(
                                height: 1.4,
                                textStyle: TextStyle(
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.grey[300].withOpacity(0.7),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 2.0),
                                      child: Text(
                                        "${index + 1}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.grey[300].withOpacity(0.7),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 2.0),
                                      child: Text(
                                        npDate(news[0]['data'][index]
                                            ['updated_at']),
                                        // "${news[0]['data'][index]['updated_at'].toString().split('T')[0].split('-')}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.grey[300].withOpacity(0.7),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 2.0),
                                      child: Text(
                                        "${news[0]['data'][index]['source']}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "${news[0]['data'][index]['summary']}",
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.mukta(
                                height: 1.3,
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: FadeInImage(
                                placeholder:
                                    AssetImage("images/placeholder.gif"),
                                image: NetworkImage(
                                    "${news[0]['data'][index]['image_url']}"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: (){
                      launch("${news[0]['data'][index]['url']}");
                    },
                  ),
                );
              }),
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: <Widget>[
      //     Text("${news[0]['data'][0]['title']}"),
      //     Text("${news[0]['data'][0]['url']}"),
      //     Text("${news[0]['data'][0]['source']}"),
      //     Text("${news[0]['data'][0]['summary']}"),
      // FadeInImage(
      //   placeholder: AssetImage("images/placeholder.png"),
      //   image: NetworkImage("${news[0]['data'][0]['image_url']}"),
      // ),
      //   ],
      // ),
    );
  }

  String npDate(npDate) {
    String date = NepaliMoment.fromAD(
      DateTime.parse('$npDate'),
      referenceDate: DateTime.now(),
    );
    return date;
  }
}
