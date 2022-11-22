import 'dart:async';

import 'package:protennisfitness/constant/constants.dart';
import 'package:protennisfitness/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  var firstController = TextEditingController();
  var secondController = TextEditingController();
  var thirdController = TextEditingController();
  var fourthController = TextEditingController();
  FocusNode secondFocusNode = FocusNode();
  FocusNode thirdFocusNode = FocusNode();
  FocusNode fourthFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    loadingDialog() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return Dialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Wrap(
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SpinKitRing(
                        color: primaryColor,
                        lineWidth: 1.5,
                        size: 35.0,
                      ),
                      heightSpace,
                      heightSpace,
                      Text('Please Wait..', style: grey14MediumTextStyle),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BottomBar()),
              ));
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: blackColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(fixPadding * 2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Verify details',
                        style: black22SemiBoldTextStyle,
                      ),
                      heightSpace,
                      heightSpace,
                      Text(
                        'Enter the OTP sent to your mobile number',
                        style: grey14MediumTextStyle,
                      ),
                      SizedBox(height: 50.0),
                      // OTP Box Start
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // 1 Start
                          Container(
                            width: 50.0,
                            height: 50.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(5.0),
                              border:
                                  Border.all(width: 0.2, color: primaryColor),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  blurRadius: 1.5,
                                  spreadRadius: 1.5,
                                  color: Colors.grey[200]!,
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: firstController,
                              style: black14MediumTextStyle,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(18.0),
                                border: InputBorder.none,
                              ),
                              onChanged: (v) {
                                FocusScope.of(context)
                                    .requestFocus(secondFocusNode);
                              },
                            ),
                          ),
                          // 1 End
                          // 2 Start
                          Container(
                            width: 50.0,
                            height: 50.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(5.0),
                              border:
                                  Border.all(width: 0.2, color: primaryColor),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  blurRadius: 1.5,
                                  spreadRadius: 1.5,
                                  color: Colors.grey[200]!,
                                ),
                              ],
                            ),
                            child: TextField(
                              focusNode: secondFocusNode,
                              controller: secondController,
                              style: black14MediumTextStyle,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(18.0),
                                border: InputBorder.none,
                              ),
                              onChanged: (v) {
                                FocusScope.of(context)
                                    .requestFocus(thirdFocusNode);
                              },
                            ),
                          ),
                          // 2 End
                          // 3 Start
                          Container(
                            width: 50.0,
                            height: 50.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(5.0),
                              border:
                                  Border.all(width: 0.2, color: primaryColor),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  blurRadius: 1.5,
                                  spreadRadius: 1.5,
                                  color: Colors.grey[200]!,
                                ),
                              ],
                            ),
                            child: TextField(
                              focusNode: thirdFocusNode,
                              controller: thirdController,
                              style: black14MediumTextStyle,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(18.0),
                                border: InputBorder.none,
                              ),
                              onChanged: (v) {
                                FocusScope.of(context)
                                    .requestFocus(fourthFocusNode);
                              },
                            ),
                          ),
                          // 3 End
                          // 4 Start
                          Container(
                            width: 50.0,
                            height: 50.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(5.0),
                              border:
                                  Border.all(width: 0.2, color: primaryColor),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  blurRadius: 1.5,
                                  spreadRadius: 1.5,
                                  color: Colors.grey[200]!,
                                ),
                              ],
                            ),
                            child: TextField(
                              focusNode: fourthFocusNode,
                              controller: fourthController,
                              style: black14MediumTextStyle,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(18.0),
                                border: InputBorder.none,
                              ),
                              onChanged: (v) {
                                loadingDialog();
                              },
                            ),
                          ),
                          // 4 End
                        ],
                      ),
                      // OTP Box End
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(fixPadding * 2.0),
            child: InkWell(
              onTap: () => loadingDialog(),
              child: Container(
                width: width - fixPadding * 2.0,
                padding: EdgeInsets.all(fixPadding * 2.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: primaryColor,
                ),
                child: Text(
                  'Continue',
                  style: white16MediumTextStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
