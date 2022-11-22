import 'package:protennisfitness/constant/constants.dart';
import 'package:protennisfitness/screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class HealthTipsList extends StatefulWidget {
  @override
  _HealthTipsListState createState() => _HealthTipsListState();
}

class _HealthTipsListState extends State<HealthTipsList> {
  final healthTipsList = [
    {
      'title': 'Maintain a healthy weight',
      'image': 'assets/health_tips/health_tips_2.jpg',
      'heroTag': 'healthTip2'
    },
    {
      'title': 'Working out too much can mess with your period',
      'image': 'assets/health_tips/health_tips_3.jpg',
      'heroTag': 'healthTip3'
    },
    {
      'title': 'Your nipples speak volumes about your health',
      'image': 'assets/health_tips/health_tips_4.jpg',
      'heroTag': 'healthTip4'
    },
    {
      'title': 'Your eye twitches means... Something',
      'image': 'assets/health_tips/health_tips_5.jpg',
      'heroTag': 'healthTip5'
    },
    {
      'title': 'Stretching exercises for better flexibility',
      'image': 'assets/health_tips/health_tips_1.jpg',
      'heroTag': 'healthTip1'
    },
    {
      'title': 'Maintain a healthy weight',
      'image': 'assets/health_tips/health_tips_2.jpg',
      'heroTag': 'healthTip6'
    },
    {
      'title': 'Working out too much can mess with your period',
      'image': 'assets/health_tips/health_tips_3.jpg',
      'heroTag': 'healthTip7'
    },
    {
      'title': 'Your nipples speak volumes about your health',
      'image': 'assets/health_tips/health_tips_4.jpg',
      'heroTag': 'healthTip8'
    },
    {
      'title': 'Your eye twitches means... Something',
      'image': 'assets/health_tips/health_tips_5.jpg',
      'heroTag': 'healthTip9'
    },
    {
      'title': 'Stretching exercises for better flexibility',
      'image': 'assets/health_tips/health_tips_1.jpg',
      'heroTag': 'healthTip10'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1.0,
        centerTitle: true,
        title: Text(
          'Health Tips',
          style: appBarTextStyle,
        ),
      ),
      body: ListView.builder(
        itemCount: healthTipsList.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = healthTipsList[index];
          return Padding(
            padding: (index == 0)
                ? EdgeInsets.all(fixPadding * 2.0)
                : EdgeInsets.fromLTRB(
                    fixPadding * 2.0, 0.0, fixPadding * 2.0, fixPadding * 2.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        duration: Duration(milliseconds: 600),
                        child: HealthTips(
                          title: item['title']!,
                          image: item['image']!,
                          heroTag: item['heroTag']!,
                        )));
              },
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: whiteColor,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      blurRadius: 5.0,
                      spreadRadius: 5.0,
                      color: lightGreyColor!,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: item['heroTag']!,
                      child: Container(
                        width: double.infinity,
                        height: 180.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.0),
                          ),
                          image: DecorationImage(
                              image: AssetImage(item['image']!),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(fixPadding * 1.3),
                      child: Text(
                        item['title']!,
                        style: black16SemiBoldTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
