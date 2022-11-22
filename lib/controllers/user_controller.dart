// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:page_transition/page_transition.dart';
import 'package:protennisfitness/models/payment_method.dart';

import '../pages/bottom_bar.dart';
import '../models/user.dart';

import '../providers/user_repository.dart' as userRepo;

import '../../../generated/l10n.dart';

class UserController extends ControllerMVC {
  GlobalKey<ScaffoldState>? scaffoldKey;
  BuildContext? context;
  User? authUser;

    // SIGN UP FORM KEY
  GlobalKey<FormState>? loginFormKey;

  bool listenForUserPaymentMethodsDone = true;

  PaymentMethod? selectedMethod;
  List<PaymentMethod> methods = [];

  UserController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    this.loginFormKey = new GlobalKey<FormState>();
    this.authUser = new User();
  }

  void login() async {
    if (loginFormKey!.currentState!.validate()) {
      // TODO ADD OVERLAY WHEN IS DOING SERVICE, dá a impressao que nao acontece nada quando se carrega no botao


      loginFormKey!.currentState!.save();
      userRepo.login(authUser!).then((value) {

        if (value != null && value is User) {// && value.apiToken != null

          ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
            content: Text(S.current.welcome + " " + value.username!),
          ));

          
          //Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 2);
          Navigator.push(
            context!,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: BottomBar()));

        } else {
          // settingsRepo.showFlushbar(S.current.wrong_email_or_password, context, duration: 3, type: 'error');
          ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
            content: Text(S.current.wrong_email_or_password),
          ));
        }
      }).onError((error, stackTrace) {
      //   print("fail");
          ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
            content: Text(S.current.wrong_email_or_password),
          ));
      });
    }
  }

  /// CREATE NEW PAYMENT METHOD ON TRIPE TO CUSTOMER
  Future<bool> addNewPaymentMethod(PaymentMethod method) async {

    bool result = false;
    await userRepo.addUserPaymentMethod(method).then((value) {
      print(value);
      result = value;
    });

    return result;
  }

  /// CREATE NEW SUBSCRIPTION TO USER
  Future<bool> createUserSubscription(String plan) async {
    bool result = false;

    await userRepo.createSubscription(selectedMethod!.id!, plan).then((value) {
      print(value);
      result = value;
    });

    return result;
  }

  /// GET LIST OF CATEGORIES OF WORKOUTS
  Future<void> listenForUserPaymentMethods() async {

    setState((){
      methods.clear();
      listenForUserPaymentMethodsDone = false;
    });

    final Stream<PaymentMethod> stream = await userRepo.getPaymentMethods( );

    stream.listen((PaymentMethod _method) {
      print(_method);
      setState(() => methods.add(_method));
    }, 
    onError: (a) {
      print("onError");
      setState(() {
        listenForUserPaymentMethodsDone = true;
      });
    }, 
    onDone: (){
      print("onDone");
      setState(() {
        selectedMethod = methods.isNotEmpty ? methods.first : null;
        listenForUserPaymentMethodsDone = true;
      });
    });
  }


/*
  void register() async {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      repository.register(user).then((value) {
        if (value != null && value.apiToken != null) {
          settingsRepo.showFlushbar(S.current.welcome + value.name, context, duration: 3, type: 'info');
          Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 2);
        } else {
          settingsRepo.showFlushbar(S.current.wrong_email_or_password, context, duration: 3, type: 'error');
        }
      });
    }
  }

  void resetPassword() {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      repository.resetPassword(user).then((value) {
        if (value != null && value == true) {
          
          // scaffoldKey.currentState.showSnackBar(SnackBar(
          //   content: Text(S.current.your_reset_link_has_been_sent_to_your_email),
          //   action: SnackBarAction(
          //     label: S.current.login,
          //     onPressed: () {
          //       Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Login');
          //     },
          //   ),
          //   duration: Duration(seconds: 10),
          // ));
          settingsRepo.showFlushbar(S.current.your_reset_link_has_been_sent_to_your_email, context, duration: 3, type: 'info');

          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Login');
          });

        } else {
          settingsRepo.showFlushbar(S.current.error_verify_email_settings, context, duration: 3, type: 'error');
        }
      });
    }
  }*/


}