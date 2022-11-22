import 'package:protennisfitness/constant/constants.dart';
import 'package:protennisfitness/elements/CircularLoadingWidget.dart';
import 'package:protennisfitness/elements/ListWorkoutWidget.dart';
import 'package:protennisfitness/screens.dart';
import 'package:protennisfitness/widget/column_builder.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:page_transition/page_transition.dart';

import '../../controllers/workouts_controller.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends StateMVC<Search> {

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  WorkoutsController _con = new WorkoutsController();
  
  final searchController = TextEditingController();

  _SearchState() : super(WorkoutsController()) {
    _con = controller as WorkoutsController;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    searchController.dispose();
    super.dispose();
  }

  final recentSearchList = [
    {'title': 'Power'},
    {'title': 'Core'},
  ];

  final popularWorkoutList = [
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
    }
  ];

  void setPageFocus() {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: GestureDetector(
        onTap: () {
          print("focus");
          setPageFocus();
        },
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60.0,
                margin: EdgeInsets.fromLTRB(
                    fixPadding * 2.0, fixPadding * 2.0, fixPadding * 2.0, 0.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for workout',
                    hintStyle: grey14MediumTextStyle,
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                  controller: searchController,
                  onEditingComplete: () {
                    print(searchController.text);
      
                    if(searchController.text != null && searchController.text != '')
                      _con.searchForWorkoutsCategories(searchController.text);
                  },
                  onSubmitted: (String txt) {
                    if(txt != null && txt != '')
                      _con.searchForWorkoutsCategories(txt);
      
                  },
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    recentSearches(),
                    
                    _con.listenForWorkoutsDone == false ? 
                    CircularLoadingWidget( height: 100,) :
                    resultWorkouts(),
                    //popularTrainer(),
                    heightSpace,
                    heightSpace,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  recentSearches() {
    return Container(
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent searches',
            style: grey16SemiBoldTextStyle,
          ),
          heightSpace,
          heightSpace,
          ColumnBuilder(
            itemCount: recentSearchList.length,
            itemBuilder: (context, index) {
              final item = recentSearchList[index];
              return Padding(
                padding: (index != recentSearchList.length - 1)
                    ? EdgeInsets.only(bottom: fixPadding * 2.0)
                    : EdgeInsets.all(0.0),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.history,
                        color: greyColor,
                        size: 18.0,
                      ),
                      width5Space,
                      Text(
                        item['title']!,
                        style: primaryColor14MediumTextStyle,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  resultWorkouts() {
    print("_con.workouts.length");
    print(_con.workouts!.length);
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              fixPadding * 2.0, 0.0, fixPadding * 2.0, fixPadding * 2.0),
          child: Text(
            'Workouts',
            style: primaryColor16MediumTextStyle,
          ),
        ),
        Container(
          height: 500,
          child: ListView.separated(
            padding: EdgeInsets.all(20),
            itemCount: _con.workouts!.length,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            separatorBuilder: (context, index){
              return SizedBox(height:10);
            },
            itemBuilder: (context, index) {
        
              //return SizedBox(height: 10,);
            
              return ListWorkoutWidget(
                workout: _con.workouts!.elementAt(index),
              );
            
            }
          ),
        ),
        
        /* Container(
          height: 220.0,
          width: double.infinity,
          child: ListView.builder(
            itemCount: popularWorkoutList.length,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final item = popularWorkoutList[index];
              return Padding(
                padding: (index == 0)
                    ? EdgeInsets.only(
                        left: fixPadding * 2.0,
                        right: fixPadding * 1.5,
                        top: 2.0,
                        bottom: 2.0)
                    : (index == popularWorkoutList.length - 1)
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
                            tag: item['heroTag'],
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20.0)),
                                image: DecorationImage(
                                  image: AssetImage(item['image']),
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
                                item['title'],
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
                                    item['time'],
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
        ), */
      ],
    );
  }

  popularTrainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(fixPadding * 2.0),
          child: Text(
            'Popular trainer',
            style: primaryColor16MediumTextStyle,
          ),
        ),
        Container(
          height: 220.0,
          width: double.infinity,
          child: ListView.builder(
            itemCount: trainerList.length,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final item = trainerList[index];
              return Padding(
                padding: (index == 0)
                    ? EdgeInsets.only(
                        left: fixPadding * 2.0,
                        right: fixPadding * 1.5,
                        top: 2.0,
                        bottom: 2.0)
                    : (index == trainerList.length - 1)
                        ? EdgeInsets.only(
                            right: fixPadding * 2.0, top: 2.0, bottom: 2.0)
                        : EdgeInsets.only(
                            right: fixPadding * 1.5, top: 2.0, bottom: 2.0),
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
                          padding: EdgeInsets.all(fixPadding),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name']!,
                                style: primaryColor16MediumTextStyle,
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
        ),
      ],
    );
  }
}
