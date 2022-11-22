// import 'dart:async';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import '../models/route_argument.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../providers/settings_repository.dart' as settingsRepo;
// import '../helpers/helper.dart';
//import '../../generated/l10n.dart';


class SplashScreenController extends ControllerMVC {
  ValueNotifier<Map<String, double>> progress = new ValueNotifier(new Map());
  GlobalKey<ScaffoldState>? scaffoldKey;

  SplashScreenController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    // // Should define these variable before the app loaded
    progress.value = {"Setting": 100};
  }
  @override
  void initState() {

    // settingsRepo.setting.addListener(() {
    //   print(settingsRepo.setting.value.toMap());
    //   if (settingsRepo.setting.value.appVersion != null && settingsRepo.setting.value.urlWebView1 != '' && settingsRepo.setting.value.urlWebView2 != null && settingsRepo.setting.value.appEnabled == "true") {
    //     progress.value["Setting"] = 100;
    //     progress.notifyListeners();
    //   }else if(settingsRepo.setting.value.appEnabled == "false"){
    //     scaffoldKey?.currentState?.showSnackBar(SnackBar(
    //       content: Text(S.current.app_disabled),
    //     ));
    //   }
    // });
    // // settingsRepo.deliveryAddress.addListener(() {
    // //   if (settingsRepo.deliveryAddress.value.address != null) {
    // //     progress.value["DeliveryAddress"] = 29;
    // //     progress?.notifyListeners();
    // //   }
    // // });
    // // userRepo.currentUser.addListener(() {
    // //   if (userRepo.currentUser.value.auth != null) {
    // //     progress.value["User"] = 30;
    // //     progress.notifyListeners();
    // //   }
    // // });
    
    // Timer(Duration(seconds: 20), () {
    //   scaffoldKey?.currentState?.showSnackBar(SnackBar(
    //     content: Text(S.current.app_disabled),
    //   ));
    // });

    super.initState();
  }

  // CHECK IF INFO RELATED TO USER IS SAVED ON LOACAL STORAGE
  Future<bool> checkUserInfo() async {
    
    return settingsRepo.loadUserBasicInfo();
  }

}
