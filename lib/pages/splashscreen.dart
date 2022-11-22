import 'dart:async';
import 'dart:io';

import '../constant/constants.dart';
// import 'package:protennisfitness/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

import 'package:mvc_pattern/mvc_pattern.dart';

import 'auth/walkthrough.dart';
import 'bottom_bar.dart';

import '../controllers/splash_screen_controller.dart';
import '../../providers/settings_repository.dart' as settingsRepo;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends StateMVC<SplashScreen> {

  SplashScreenController _con = new SplashScreenController();

  _SplashScreenState() : super(SplashScreenController()) {
    _con = controller as SplashScreenController;
  }


  @override
  void initState() {
    super.initState();

    if( Platform.isIOS ){
      _loadAppleSubscriptions();
    }

    loadData();
  }

  /// LOAD SUBSCRIPTIONS FORM APPLE, CHECK USER SUBSCRIPTION STATUS
  void _loadAppleSubscriptions() {
    settingsRepo.loadAppleSubscriptions();
  }


  void loadData() async {

    // TODO - SERVICE TO LOAD APP SETTINGS
     
    // _con.progress.addListener(() async {
    //   double progress = 0;
    //   _con.progress.value.values.forEach((_progress) {
    //     progress += _progress;
    //   });
    //   if (progress == 100) {
    //     try {
        
    //       Future.delayed(Duration(seconds: 2),() {
    //         Navigator.of(context).pushReplacementNamed('/Pages');
    //       });
    //     } catch (e) {}
    //   }
    // });

    try {

      // if dont have user and is first time

      // CHECK IF APP HAVE INFORMATION SAVED ABOUT USER OR IF IT IS THE FIRST TIME
      if(await _con.checkUserInfo()){
        // Future.delayed(Duration(seconds: 2),() {
        //   // Navigator.of(context).pushReplacementNamed('/Pages');
        // });
        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft,
              child: BottomBar()));
      }else{
        Timer(
          Duration(seconds: 4),
          () => Navigator.push(
              context,
              PageTransition(
                  duration: Duration(milliseconds: 600),
                  type: PageTransitionType.fade,
                  child: Walkthrough()
                )
              )
        );
      }
    } catch (e) {}
      
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.0),
            Expanded(
              child: Container(
                height: 40.0,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage("assets/logo_white.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Welcome',
                  style: white50SemiBoldTextStyle,
                ),
              ),
            ),
            SizedBox(height: 50.0),
            Padding(
              padding: const EdgeInsets.all(fixPadding * 4.0),
              child: SpinKitRing(
                color: whiteColor,
                size: 40.0,
                lineWidth: 2.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
