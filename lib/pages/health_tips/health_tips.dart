import 'package:protennisfitness/constant/constants.dart';
import 'package:protennisfitness/screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class HealthTips extends StatefulWidget {
  final String? title, image, heroTag;

  const HealthTips(
      {Key? key,
      @required this.title,
      @required this.image,
      @required this.heroTag})
      : super(key: key);
  @override
  _HealthTipsState createState() => _HealthTipsState();
}

class _HealthTipsState extends State<HealthTips> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool favorite = false;

  final recommendedList = [
    {
      'title': 'Core Reformer',
      'image': 'assets/popular_workout/popular_workout_1.jpg',
      'time': '20 min',
      'heroTag': 'popular_workout_1'
    },
    {
      'title': 'Basic Building',
      'image': 'assets/popular_workout/popular_workout_2.jpg',
      'time': '20 min',
      'heroTag': 'popular_workout_2'
    },
    {
      'title': 'Rope Jump',
      'image': 'assets/popular_workout/popular_workout_3.jpg',
      'time': '20 min',
      'heroTag': 'popular_workout_3'
    },
    {
      'title': 'Push Ups',
      'image': 'assets/popular_workout/popular_workout_4.jpg',
      'time': '20 min',
      'heroTag': 'popular_workout_4'
    },
    {
      'title': 'Laterale Jump',
      'image': 'assets/popular_workout/popular_workout_5.jpg',
      'time': '20 min',
      'heroTag': 'popular_workout_5'
    },
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 350.0,
                pinned: true,
                forceElevated: true,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                elevation: 0.0,
                leading: IconButton(
                  color: whiteColor.withOpacity(0.7),
                  icon: Icon(
                    Icons.arrow_back,
                    color: blackColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                centerTitle: true,
                title: Text(
                  widget.title!,
                  style: appBarTextStyle,
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: widget.heroTag!,
                    child: Container(
                      width: width,
                      // height: 350.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(widget.image!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: ListView(
            children: [
              titleData(),
              aboutTrainer(),
              heightSpace,
              heightSpace,
              divider(),
              decscripiton(),
              recommended(),
              heightSpace,
              heightSpace,
            ],
          ),
        ),
      ),
    );
  }

  divider() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      height: 1.0,
      color: greyColor,
    );
  }

  titleData() {
    return Container(
      padding: EdgeInsets.fromLTRB(fixPadding * 2.0, fixPadding * 2.0,
          fixPadding * 2.0, fixPadding * 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              widget.title!,
              style: black22SemiBoldTextStyle,
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                favorite = !favorite;
              });
              if (favorite) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Added to favorite')));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Remove from favorite')));
              }
            },
            child: Icon(
              (favorite) ? Icons.favorite : Icons.favorite_border,
              color: primaryColor,
              size: 26.0,
            ),
          ),
        ],
      ),
    );
  }

  aboutTrainer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: 'trainer',
                child: Container(
                  width: 90.0,
                  height: 90.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45.0),
                    image: DecorationImage(
                      image: AssetImage('assets/trainer/trainer_5.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              widthSpace,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Olivier Hayden',
                    style: black18MediumTextStyle,
                  ),
                  height5Space,
                  Text(
                    'Fitness Trainer',
                    style: grey14RegularTextStyle,
                  ),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 600),
                  child: Trainer(
                    name: 'Olivier Hayden',
                    imagePath: 'assets/trainer/trainer_5.jpg',
                    type: 'Fitness Trainer',
                    heroTag: 'trainer',
                  ),
                ),
              );
            },
            child: Text(
              'View More'.toUpperCase(),
              style: grey14RegularTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  decscripiton() {
    return Container(
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: black18SemiBoldTextStyle,
          ),
          heightSpace,
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
            style: black14RegularTextStyle,
            textAlign: TextAlign.justify,
          ),
          heightSpace,
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
            style: black14RegularTextStyle,
            textAlign: TextAlign.justify,
          ),
          heightSpace,
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
            style: black14RegularTextStyle,
            textAlign: TextAlign.justify,
          ),
          heightSpace,
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
            style: black14RegularTextStyle,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  recommended() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              fixPadding * 2.0, 0.0, fixPadding * 2.0, fixPadding * 2.0),
          child: Text(
            'Recommended',
            style: primaryColor16MediumTextStyle,
          ),
        ),
        Container(
          height: 220.0,
          width: double.infinity,
          child: ListView.builder(
            itemCount: recommendedList.length,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final item = recommendedList[index];
              return Padding(
                padding: (index == 0)
                    ? EdgeInsets.only(
                        left: fixPadding * 2.0,
                        right: fixPadding * 1.5,
                        top: 2.0,
                        bottom: 2.0)
                    : (index == recommendedList.length - 1)
                        ? EdgeInsets.only(
                            right: fixPadding * 2.0, top: 2.0, bottom: 2.0)
                        : EdgeInsets.only(
                            right: fixPadding * 1.5, top: 2.0, bottom: 2.0),
                child: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   PageTransition(
                    //     type: PageTransitionType.fade,
                    //     duration: Duration(milliseconds: 600),
                    //     child: WorkoutDetail(
                    //       title: item['title'],
                    //       image: item['image'],
                    //       heroTag: item['heroTag'],
                    //     ),
                    //   ),
                    // );
                  },
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    width: 170.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: whiteColor,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          blurRadius: 1.0,
                          spreadRadius: 1.0,
                          color: lightGreyColor!,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Hero(
                            tag: item['heroTag']!,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20.0)),
                                image: DecorationImage(
                                  image: AssetImage(item['image']!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(fixPadding * 1),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title']!,
                                style: primaryColor16MediumTextStyle,
                              ),
                              height5Space,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.timer,
                                    color: greyColor,
                                    size: 18.0,
                                  ),
                                  width5Space,
                                  Text(
                                    item['time']!,
                                    style: grey14MediumTextStyle,
                                  ),
                                ],
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
        ),
      ],
    );
  }
}
