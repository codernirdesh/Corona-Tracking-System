import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomUser extends StatelessWidget {
  final String name, content, buttonText, post;
  final String facebook, twitter, instagram, phone;
  final Image image;
  CustomUser({
    this.name,
    this.post,
    this.content,
    this.buttonText,
    this.image,
    this.facebook,
    this.instagram,
    this.twitter,
    this.phone,
  });
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContext(context),
    );
  }

  dialogContext(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding:
              EdgeInsets.only(top: 16.0, bottom: 12.0, left: 16.0, right: 16.0),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(17),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0))
              ]),
          child: ListView(
            shrinkWrap: true,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(17.0),
                child: Container(
                  height: 250.0,
                  child: image,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.4,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                post,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                content,
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(17.0),
                child: Container(
                  decoration: BoxDecoration(
                      // color: Colors.green[50],
                      ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(FontAwesomeIcons.facebook),
                          color: Colors.blue,
                          onPressed: () {
                            launch(facebook);
                          },
                        ),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.twitter),
                          color: Colors.blue[300],
                          onPressed: () {
                            launch(twitter);
                          },
                        ),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.instagram),
                          color: Colors.red,
                          onPressed: () {
                            launch(instagram);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.call),
                          color: Colors.green,
                          onPressed: () {
                            launch("tel:$phone");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.red[100].withOpacity(0.4),
                      clipBehavior: Clip.antiAlias,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.red[600],
                            size: 14.0,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            buttonText,
                            style: TextStyle(
                                color: Colors.red[600],
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Positioned(
        //   top: 50,
        //   left: 16.0,
        //   right: 16.0,
        //   child: CircleAvatar(
        //     backgroundColor: Colors.red[500],
        //     // backgroundImage: Image.asset("assets/icon.jpg"),
        //     child: image,
        //     radius: 32.0,
        //   ),
        // ),
      ],
    );
  }
}
