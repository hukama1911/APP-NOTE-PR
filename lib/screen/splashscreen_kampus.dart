import 'package:crud_rumah_sakit/screen/list_kampus.dart';
import 'package:flutter/material.dart';


class SplashScreenKampus extends StatefulWidget {
  @override
  _SplashScreenKampusState createState() => _SplashScreenKampusState();
}

class _SplashScreenKampusState extends State<SplashScreenKampus> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 400), () {
      setState(() => _opacity = 1.0);
    });

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ListKampus()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(seconds: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.school, size: 90, color: Colors.deepPurple),
              SizedBox(height: 16),
              Text(
                "Selamat Datang di Data Kampus",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue.shade800,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 30),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
              )
            ],
          ),
        ),
      ),
    );
  }
}
