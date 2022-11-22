import 'package:protennisfitness/constant/constants.dart';
import 'package:protennisfitness/screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class TrainerList extends StatefulWidget {
  @override
  _TrainerListState createState() => _TrainerListState();
}

class _TrainerListState extends State<TrainerList> {
  final trainerList = [
    {
      'name': 'Amenda Johnson',
      'image': 'assets/trainer/trainer_1.jpg',
      'type': 'Fitness Trainer',
      'heroTag': 'trainer1'
    },
    {
      'name': 'Russeil Taylor',
      'image': 'assets/trainer/trainer_2.jpg',
      'type': 'Muscle Trainer',
      'heroTag': 'trainer2'
    },
    {
      'name': 'Lliana George',
      'image': 'assets/trainer/trainer_3.jpg',
      'type': 'Muscle Trainer',
      'heroTag': 'trainer3'
    },
    {
      'name': 'Suzein Smith',
      'image': 'assets/trainer/trainer_4.jpg',
      'type': 'Yoga Trainer',
      'heroTag': 'trainer4'
    },
    {
      'name': 'Olivier Hayden',
      'image': 'assets/trainer/trainer_5.jpg',
      'type': 'Yoga Trainer',
      'heroTag': 'trainer5'
    },
    {
      'name': 'Amenda Johnson',
      'image': 'assets/trainer/trainer_1.jpg',
      'type': 'Fitness Trainer',
      'heroTag': 'trainer6'
    },
    {
      'name': 'Russeil Taylor',
      'image': 'assets/trainer/trainer_2.jpg',
      'type': 'Muscle Trainer',
      'heroTag': 'trainer7'
    },
    {
      'name': 'Lliana George',
      'image': 'assets/trainer/trainer_3.jpg',
      'type': 'Muscle Trainer',
      'heroTag': 'trainer8'
    },
    {
      'name': 'Suzein Smith',
      'image': 'assets/trainer/trainer_4.jpg',
      'type': 'Yoga Trainer',
      'heroTag': 'trainer9'
    },
    {
      'name': 'Olivier Hayden',
      'image': 'assets/trainer/trainer_5.jpg',
      'type': 'Yoga Trainer',
      'heroTag': 'trainer10'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.0,
        centerTitle: true,
        title: Text(
          'My Trainer',
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
      body: ListView.builder(
        itemCount: trainerList.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = trainerList[index];
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
                    child: Trainer(
                      name: item['name']!,
                      imagePath: item['image']!,
                      type: item['type']!,
                      heroTag: item['heroTag']!,
                    ),
                  ),
                );
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: item['heroTag']!,
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(20.0)),
                          image: DecorationImage(
                            image: AssetImage(item['image']!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    widthSpace,
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name']!,
                            style: black18SemiBoldTextStyle,
                          ),
                          height5Space,
                          Text(
                            item['type']!,
                            style: grey14MediumTextStyle,
                          ),
                        ],
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
