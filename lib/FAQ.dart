import 'package:flutter/material.dart';

class Faq extends StatelessWidget {
  const Faq({Key key, this.faqData}) : super(key: key);
  final List faqData;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        color: Colors.red,
        height: 250.0,
        child: Text("${faqData[0]}"),
      ),
    );
  }
}