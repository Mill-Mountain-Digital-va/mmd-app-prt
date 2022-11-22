import 'package:protennisfitness/constant/constants.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.0,
        centerTitle: true,
        title: Text(
          'Privacy Policy',
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
                  'This data protection declaration provides information on using and protecting your data on the Pro Tennis Fitness app. Using the Pro Tennis Fitness app implies that you accept the terms outlined in this data protection declaration. If you do not agree with these terms, please do not use our app. This data protection declaration applies to all members from the time they first log in at Pro Tennis Fitness App, thereby acknowledging acceptance of this data protection declaration.',
                  style: black14RegularTextStyle,
                  textAlign: TextAlign.justify,
                ),
                heightSpace,
                heightSpace,
                Text(
                  'Types of personally identifiable information collected by Pro Tennis Fitness',
                  style: black14RegularTextStyle,
                  textAlign: TextAlign.justify,
                ),
                heightSpace,
                Text(
                  '1. Users can freely enter profile information, change, and delete via settings such as first name and last name, Tennis level, weight, height, or gender.\n2. Training information will be stored when users save workouts.\n3. Email addresses, Personal identifiable information shall be saved and used in particular to offer new applications to the members, improve such applications and adapt them to the users\' needs.\n4. When you choose to purchase the subscription to the Pro Tennis fitness application, we may collect information from you including Personal Information, such as your name, email address, mailing address, phone number, payment information, such as a credit card number and/or other related information that may be required from you to complete your purchase (such payment information, "Financial Information"). Unless we tell you otherwise at the time of your purchase or application for financing, your Financial Information is processed by our third-party processors, and we do not collect, store or maintain your Financial Information.\n5. We will also collect a username and password in connection with any account created.',
                  style: black14RegularTextStyle,
                  textAlign: TextAlign.justify,
                ),
                heightSpace,
                heightSpace,
                Text(
                  'Use and sharing of personally identifiable and non-personally identifiable information with third parties',
                  style: black14RegularTextStyle,
                  textAlign: TextAlign.justify,
                ),
                heightSpace,
                Text(
                  '1. By registering, the user explicitly agrees that Pro Tennis Fitness shall have the right to use all automatically collected personally identifiable information for purposes of the Pro Tennis Fitness application. Pro Tennis Fitness does not sell, trade, or otherwise transfer personally identifiable information to outside parties. This does not include trusted third parties who assist us in operating our application and conducting our business, so long as those parties agree to keep this information confidential. Pro Tennis Fitness may also release users\' information when we believe release is appropriate to comply with the law, enforce our site policies, or protect ours or others\' rights, property, or safety.\n2. Pro Tennis Fitness implements all reasonable measures to prevent unauthorized access by third parties to saved details.\n3. The user explicitly consents that Pro Tennis Fitness may provide non-personally identifiable information to other parties for marketing, advertising, or other uses.',
                  style: black14RegularTextStyle,
                  textAlign: TextAlign.justify,
                ),
                heightSpace,
                heightSpace,
                Text(
                  'Cookies',
                  style: black14RegularTextStyle,
                  textAlign: TextAlign.justify,
                ),
                heightSpace,
                Text(
                  '1. Pro Tennis Fitness may place cookies or web beacons onto your computer when you visit Pro Tennis Fitness. We use cookies; cookies are small files that are stored on your hard drive. They make navigation easier. Cookies also help us with identification. We use these cookies and web beacons to monitor your preferences and present Pro Tennis Fitness in the best possible way, recognize returning users, measure user traffic and activities during visits to Pro Tennis Fitness, monitor and improve our service, and guard against fraud. We also use cookies to individualize our service, content, advertising, and product line. You can block cookies at any time by changing your browser settings.',
                  style: black14RegularTextStyle,
                  textAlign: TextAlign.justify,
                ),
                heightSpace,
                heightSpace,
                Text(
                  'Changes to the privacy policy',
                  style: black14RegularTextStyle,
                  textAlign: TextAlign.justify,
                ),
                heightSpace,
                Text(
                  '1. Pro Tennis Fitness reserves the right to change this privacy policy from time to time. If Pro Tennis Fitness decides to do so, it will post those changes within the Pro Tennis Fitness application settings section. Users are advised to check the privacy policy of Pro Tennis Fitness regularly. ',
                  style: black14RegularTextStyle,
                  textAlign: TextAlign.justify,
                ),
                heightSpace,
                heightSpace,
                Text(
                  'Your consent',
                  style: black14RegularTextStyle,
                  textAlign: TextAlign.justify,
                ),
                heightSpace,
                Text(
                  '1. By using our application, you consent to our privacy policy.',
                  style: black14RegularTextStyle,
                  textAlign: TextAlign.justify,
                ),
                heightSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
