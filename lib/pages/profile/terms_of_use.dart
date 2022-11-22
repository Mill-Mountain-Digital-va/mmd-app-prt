import 'package:protennisfitness/constant/constants.dart';
import 'package:flutter/material.dart';

class TermsOfUse extends StatefulWidget {
  @override
  _TermsOfUseState createState() => _TermsOfUseState();
}

class _TermsOfUseState extends State<TermsOfUse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.0,
        centerTitle: true,
        title: Text(
          'Terms of Use',
          style: appBarTextStyle,
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: blackColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1. I hereby acknowledge and agree that the types of activities, services, and physical training programs offered by the Pro Tennis Fitness App involve risks of injury to persons and property.',
                  style: black14RegularTextStyle,
                  textAlign: TextAlign.justify,
                ),
                heightSpace,
                Text(
                  '2. I represent that I am in a good physical condition and have no disability, illness, or other diseases that could prevent me from exercising without injury or health impairment. I also represent that I have consulted a physician concerning an exercise and physical training program that will not risk injury to me or impairment of my health.',
                  style: black14RegularTextStyle,
                  textAlign: TextAlign.justify,
                ),
                heightSpace,
                Text(
                  '3. I acknowledge that Pro Tennis Fitness will not be responsible for any injuries, illness, or death while using the Pro Tennis Fitness application.',
                  style: black14RegularTextStyle,
                  textAlign: TextAlign.justify,
                ),
                heightSpace,
                Text(
                  '4. Each user will have the right to cancel the subscription of the Pro Tennis Fitness application at any time by changing their account settings. Cancellation will be confirmed to the user.',
                  style: black14RegularTextStyle,
                  textAlign: TextAlign.justify,
                ),
                heightSpace,
                Text(
                  '5. I have read the Terms and Conditions of the Pro Tennis Fitness application and acknowledge that no oral representations, statements, or inducements have been made apart from this agreement.',
                  style: black14RegularTextStyle,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
