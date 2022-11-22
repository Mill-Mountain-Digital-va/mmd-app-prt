import 'dart:io';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../constant/constants.dart';
import '../../screens.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

import '../../../controllers/user_controller.dart';

class Walkthrough extends StatefulWidget {
  @override
  _WalkthroughState createState() => _WalkthroughState();
}

class _WalkthroughState extends StateMVC<Walkthrough> {

  UserController _con = new UserController();

  _WalkthroughState() : super(UserController()) {
    _con = controller as UserController;
  }

  DateTime? currentBackPressTime;
  bool _obscureText = true;

  final TextEditingController textController = TextEditingController();
  
  /// SET FOCUS TO PAGE 
  void setPageFocus() {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    _con.context = context;

    return Scaffold(
      backgroundColor: primaryColor,
      body: WillPopScope(
        child: SafeArea(
          child: GestureDetector(
            onTap: (){
              setPageFocus();
            },
            child: SingleChildScrollView(
              child: Container(
                width: width,
                height: height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: height * 0.3,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                          // Text(
                          //   'Fit with Me',
                          //   style: darkBlue26BoldTextStyle,
                          // ),
                          // heightSpace,
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //       horizontal: fixPadding * 4.0),
                          //   child: Text(
                          //     'Sign up to get your personalized course and meal plan.',
                          //     style: primaryColor16Height15MediumTextStyle,
                          //     textAlign: TextAlign.center,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      child: Form(
                        key: _con.loginFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              padding: EdgeInsets.only(left: 30, right: 20, bottom: 0),
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: TextFormField(
                                  // style: TextStyle(color: Theme.of(context).accentColor),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: getInputDecoration(hintText: '', labelText: 'Email'),
                                  // initialValue: address.description?.isNotEmpty ?? false ? address.description : null,
                                  validator: (input) => input!.trim().length < 5 ? 'Not valid address description' : null,
                                  onSaved: (input) => _con.authUser!.email = input,
                                  onEditingComplete: () {
                                    setPageFocus();
                                  },
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                              padding: EdgeInsets.only(left: 30, right: 20, bottom: 0),
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: TextFormField(
                                  // style: TextStyle(color: Theme.of(context).accentColor),
                                  obscureText: _obscureText,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: getInputDecoration(hintText: '', labelText: 'Password'),
                                  // initialValue: address.description?.isNotEmpty ?? false ? address.description : null,
                                  validator: (input) => input!.trim().length < 5 ? 'Not valid Password' : null,
                                  onSaved: (input) => _con.authUser!.password = input,
                                  onEditingComplete: () {
                                    setPageFocus();
                                  },
                                  
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // login
                                _con.login();
                              },
                              child: Container(
                                padding: EdgeInsets.all(fixPadding * 1.0),
                                margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 15),
                                // width: 130,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.green,
                                ),
                                child: Text(
                                  'login'.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'OR',
                              style: white16MediumTextStyle,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: UserBasicSteps()));
                              },
                              child: Container(
                                padding: EdgeInsets.all(fixPadding * 1.0),
                                margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
                                // width: 130,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.teal,
                                ),
                                child: Text(
                                  'sign up'.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: fixPadding * 2.0),
                            //   child: InkWell(
                            //     onTap: () {
                            //       Navigator.push(
                            //           context,
                            //           PageTransition(
                            //               type: PageTransitionType.rightToLeft,
                            //               child: Register()));
                            //     },
                            //     borderRadius: BorderRadius.circular(30.0),
                            //     child: Container(
                            //       padding: EdgeInsets.all(fixPadding * 2.0),
                            //       width: double.infinity,
                            //       alignment: Alignment.center,
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(30.0),
                            //         color: primaryColor,
                            //       ),
                            //       child: Text(
                            //         'Continue with phone number',
                            //         style: white18SemiBoldTextStyle,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // heightSpace,
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: fixPadding * 2.0),
                            //   child: InkWell(
                            //     onTap: () {},
                            //     borderRadius: BorderRadius.circular(30.0),
                            //     child: Container(
                            //       padding: EdgeInsets.all(fixPadding * 2.0),
                            //       width: double.infinity,
                            //       alignment: Alignment.center,
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(30.0),
                            //         color: darkBlueColor,
                            //       ),
                            //       child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         children: [
                            //           Image.asset(
                            //             'assets/google-icon.png',
                            //             height: 25.0,
                            //             fit: BoxFit.fitHeight,
                            //           ),
                            //           widthSpace,
                            //           widthSpace,
                            //           widthSpace,
                            //           Text(
                            //             'Continue with Google',
                            //             style: white18SemiBoldTextStyle,
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // heightSpace,
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: fixPadding * 2.0),
                            //   child: InkWell(
                            //     onTap: () {},
                            //     borderRadius: BorderRadius.circular(30.0),
                            //     child: Container(
                            //       padding: EdgeInsets.all(fixPadding * 2.0),
                            //       width: double.infinity,
                            //       alignment: Alignment.center,
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(30.0),
                            //         color: const Color(0xFF0080EC),
                            //       ),
                            //       child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         children: [
                            //           Image.asset(
                            //             'assets/facebook-icon.png',
                            //             height: 25.0,
                            //             fit: BoxFit.fitHeight,
                            //           ),
                            //           widthSpace,
                            //           widthSpace,
                            //           widthSpace,
                            //           Text(
                            //             'Continue with Facebook',
                            //             style: white18SemiBoldTextStyle,
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    // Container(
                    //   padding: EdgeInsets.all(fixPadding * 2.0),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       Text(
                    //         'Continue without login?',
                    //         style: white16MediumTextStyle,
                    //       ),
                    //       heightSpace,
                    //       heightSpace,
                    //       heightSpace,
                    //       InkWell(
                    //         onTap: () {
                    //           Navigator.push(
                    //               context,
                    //               PageTransition(
                    //                   type: PageTransitionType.rightToLeft,
                    //                   child: BottomBar()));
                    //         },
                    //         child: Container(
                    //           padding: EdgeInsets.all(fixPadding * 1.0),
                    //           width: 130,
                    //           alignment: Alignment.center,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(20.0),
                    //             color: const Color(0xFF0080EC),
                    //           ),
                    //           child: Text(
                    //             'free'.toUpperCase(),
                    //             style: TextStyle(
                    //               fontSize: 18.0,
                    //               color: Colors.white,
                    //               fontWeight: FontWeight.w600,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: () async {
          bool backStatus = onWillPop();
          if (backStatus) {
            exit(0);
          }
          return false;
        },
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }

  InputDecoration getInputDecoration({String? hintText, String? labelText}) {
    return new InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: TextStyle(color: Colors.black),
      labelStyle: TextStyle(color: Colors.black),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
      // hasFloatingPlaceholder: true,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      // labelStyle: Theme.of(context).textTheme.bodyText2.merge(
      //       TextStyle(color: Theme.of(context).accentColor),
      //     ),
    );
  }
}
