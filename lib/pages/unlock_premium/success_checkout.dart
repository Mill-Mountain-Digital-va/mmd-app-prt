import 'package:protennisfitness/screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:protennisfitness/constant/constants.dart';
// ignore: must_be_immutable
class SuccessCheckoutWidget extends StatefulWidget {
  @override

  SuccessCheckoutWidget({Key? key}): super(key: key);

  _SuccessCheckoutWidgetState createState() => _SuccessCheckoutWidgetState();
}

class _SuccessCheckoutWidgetState extends State<SuccessCheckoutWidget> {
  
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green[400],
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            padding: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height - 70,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    size: 150,
                    color: Colors.white,
                  ),
                  SizedBox(height:50),
                  Text(
                    "Subscription created with success",
                    textAlign: TextAlign.center,
                    style: white30SemiBoldTextStyle,
                  ),
                  SizedBox(height:50),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      primary: const Color(0xff1b447b),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'halter',
                          fontSize: 20,
                          package: 'flutter_credit_card',
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft, 
                          child: BottomBar()
                        ),(route) => false
                      );
                    },
                  )

                ],
              ),
          ),
          
        ],
      ),
    );
  }
}
