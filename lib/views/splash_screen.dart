import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yaffet/views/general_chart.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => GeneralChartScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset('assets/images/logo.png'),
    );
  }
}
