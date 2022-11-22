import 'package:protennisfitness/constant/constants.dart';
import 'package:protennisfitness/screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: primaryColor,
                ),
                onPressed: () => Navigator.pop(context),
              ),
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
                            'Register',
                            style: black22SemiBoldTextStyle,
                          ),
                          heightSpace,
                          heightSpace,
                          Text(
                            'Register your account',
                            style: black14MediumTextStyle,
                          ),
                          SizedBox(height: 50.0),
                          Container(
                            child: Theme(
                              data: ThemeData(
                                primaryColor: primaryColor,
                                textSelectionTheme: TextSelectionThemeData(
                                  cursorColor: primaryColor,
                                ),
                              ),
                              child: TextField(
                                keyboardType: TextInputType.text,
                                style: black16RegularTextStyle,
                                decoration: InputDecoration(
                                  labelText: 'Full Name',
                                  labelStyle: black16RegularTextStyle,
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: primaryColor,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 0.7),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          heightSpace,
                          heightSpace,
                          Container(
                            child: Theme(
                              data: ThemeData(
                                primaryColor: primaryColor,
                                textSelectionTheme: TextSelectionThemeData(
                                  cursorColor: primaryColor,
                                ),
                              ),
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                style: black16RegularTextStyle,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: black16RegularTextStyle,
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: primaryColor,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 0.7),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          heightSpace,
                          heightSpace,
                          Container(
                            child: Theme(
                              data: ThemeData(
                                primaryColor: primaryColor,
                                textSelectionTheme: TextSelectionThemeData(
                                  cursorColor: primaryColor,
                                ),
                              ),
                              child: TextField(
                                keyboardType: TextInputType.text,
                                style: black16RegularTextStyle,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: black16RegularTextStyle,
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: primaryColor,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 0.7),
                                  ),
                                ),
                                obscureText: true,
                              ),
                            ),
                          ),
                          heightSpace,
                          heightSpace,
                          Container(
                            child: Theme(
                              data: ThemeData(
                                primaryColor: primaryColor,
                                textSelectionTheme: TextSelectionThemeData(
                                  cursorColor: primaryColor,
                                ),
                              ),
                              child: TextField(
                                keyboardType: TextInputType.text,
                                style: black16RegularTextStyle,
                                decoration: InputDecoration(
                                  labelText: 'Confirm Password',
                                  labelStyle: black16RegularTextStyle,
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: primaryColor,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 0.7),
                                  ),
                                ),
                                obscureText: true,
                              ),
                            ),
                          ),
                          heightSpace,
                          heightSpace,
                          Container(
                            child: Theme(
                              data: ThemeData(
                                primaryColor: primaryColor,
                                textSelectionTheme: TextSelectionThemeData(
                                  cursorColor: primaryColor,
                                ),
                              ),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                style: black16RegularTextStyle,
                                decoration: InputDecoration(
                                  labelText: 'Mobile Number',
                                  labelStyle: black16RegularTextStyle,
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: primaryColor,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 0.7),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(fixPadding * 2.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: OTPScreen()));
                  },
                  borderRadius: BorderRadius.circular(30.0),
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
        ),
      ),
    );
  }
}
