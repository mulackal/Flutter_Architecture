import 'dart:developer';

import 'package:beautysquare/styles/colors.dart';

import 'package:beautysquare/util/screen_argument.dart';
import 'package:beautysquare/util/screen_text_util.dart';
import 'package:beautysquare/util/shared_Preference_manager.dart';
import 'package:beautysquare/view/login/login_pages.dart';
import 'package:beautysquare/view/passes/passes_pages.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';


import 'dart:async';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(new Duration(seconds: 5), () => Navigator.of(context).pushReplacementNamed(LoginPages.routeName,
        arguments: ScreenArguments(title: "loginPage")));
    //navigate();
    // Timer(new Duration(seconds: 5), () =>  MyNavigator.goToLogin(context));
    //Navigator.of(context).pushReplacementNamed(PassesPages.routeName));
  }


   navigate() async {
try {

 /* SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool(Constant().isLogin, false);*/

  if (SharedPreferenceManager().getLogin() ?? false) {
    Timer(new Duration(seconds: 5), () => Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => PassesPages())));
    print("splash = loades");
  }
  else {
    /** send argument**/
    Timer(new Duration(seconds: 5), () => Navigator.of(context).pushReplacementNamed(LoginPages.routeName,
        arguments: ScreenArguments(title: "loginPage")));

    print("splash = not loades");
  }
}catch(e){
  print(e.toString());
}

   }

  @override
  Widget build(BuildContext context) {

    final screeSize = MediaQuery.of(context).size;
    ScreenSizeTextUtil().updateScreenDimesion(width: screeSize.width, height: screeSize.height);

    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(color: colorStyles['sky_blue']),
        ),
        new Container(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Image.asset(
                        'assets/images/bsqlogo.png',
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ],
        )),
      ],
    ));
  }
}
