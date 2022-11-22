import 'package:flutter/material.dart';
import 'package:protennisfitness/constant/constants.dart';
import 'package:page_transition/page_transition.dart';

import '../../screens.dart';

import '../../generated/l10n.dart';

class PermissionDeniedWidget extends StatefulWidget {
  PermissionDeniedWidget({
    Key? key,
  }) : super(key: key);

  @override
  _PermissionDeniedWidgetState createState() => _PermissionDeniedWidgetState();
}

class _PermissionDeniedWidgetState extends State<PermissionDeniedWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      padding: EdgeInsets.symmetric(horizontal: 30),
      // height: config.App(context).appHeight(70),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
                      primaryColor.withOpacity(0.7),
                      primaryColor.withOpacity(0.05),
                    ])),
                child: Icon(
                  Icons.https,
                  color: Colors.white,
                  size: 70,
                ),
              ),
              Positioned(
                right: -30,
                bottom: -50,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              ),
              Positioned(
                left: -20,
                top: -50,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 15),
          Opacity(
            opacity: 0.4,
            child: Text(
              S.of(context).you_must_signin_to_access_to_this_section,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6!.merge(TextStyle(fontWeight: FontWeight.w300)),
            ),
          ),
          SizedBox(height: 50),
          InkWell(
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: Walkthrough()));
            },
            child: Container(
              padding: EdgeInsets.all(fixPadding * 1.0),
              margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 15),
              // width: 130,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: primaryColor,
              ),
              child: Text(
                S.of(context).login.toUpperCase(),
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: UserBasicSteps()));
            },
            child: Text(
              S.of(context).i_dont_have_an_account,
              style: TextStyle(color: primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
