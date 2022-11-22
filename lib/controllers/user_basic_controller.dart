// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/user.dart';
import '../models/user_basic.dart';

import '../providers/user_repository.dart' as userRepo;

class UserBasicController extends ControllerMVC {
  GlobalKey<ScaffoldState>? scaffoldKey;
    // SIGN UP FORM KEY
  GlobalKey<FormState>? signupFormKey;

  UserBasicController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    this.signupFormKey = new GlobalKey<FormState>();
  }

  UserBasic? userBasic;
  User? user;

  @override
  void initState() {

    super.initState();

    userBasic = new UserBasic();
    user = new User();
  }

  // void login() async {
  //   if (loginFormKey.currentState.validate()) {
  //     loginFormKey.currentState.save();
  //     repository.login(user).then((value) {
  //       if (value != null && value.apiToken != null) {
  //         settingsRepo.showFlushbar(S.current.welcome + value.name, context, duration: 3, type: 'info');
  //         if(repository.redirectPage != "" && repository.redirectPage != null)//in case of use redirect
  //         {
  //           Navigator.of(scaffoldKey.currentContext).pushNamedAndRemoveUntil(repository.redirectPage, (Route<dynamic> route) => false,
  //               arguments: repository.redirectRouteArgument);
  //         }else{
  //           Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 2);
  //         }

  //       } else {
  //         settingsRepo.showFlushbar(S.current.wrong_email_or_password, context, duration: 3, type: 'error');
  //       }
  //     });
  //   }
  // }

  /// SERVICE TO REGISTER NEW USER
  Future<bool> register() async {
    bool result = false;
    if (signupFormKey!.currentState!.validate()) {
      //TODO criar validaçoes do form
      signupFormKey!.currentState!.save();
      await userRepo.register(user!, userBasic!).then((value) {

                    print(value);
                    print(value.toMap());
                    
        if (value.apiToken != null) {
          // settingsRepo.showFlushbar(S.current.welcome + value.name, context, duration: 3, type: 'info');
          // Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 2);
          result = true;
        } else {
          print("error2");
          // settingsRepo.showFlushbar(S.current.wrong_email_or_password, context, duration: 3, type: 'error');
        }
      });
    }

    return result;
  }


}
