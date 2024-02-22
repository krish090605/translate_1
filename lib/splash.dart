import 'dart:convert';


import 'package:flutter/material.dart';
import 'home.dart';
import 'package:http/http.dart' as http;


class Splashscreen extends StatefulWidget {

  const Splashscreen({super.key});


  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }


  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
     Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyHomePage()))
    ;

  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Image(
                    image: AssetImage('assets/star6.png'),
                    width: 140.0,
                    height: 140.0,
                  ),
                ),
                SizedBox(height: 30.0),
                Text('TRANSLATE',
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4.0,
                        color: Colors.grey[400],
                        fontFamily: 'fonts/ubuntubold'
                    ))


              ],
            ),
    );
          }
        }
