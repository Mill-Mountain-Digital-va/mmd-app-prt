import 'package:protennisfitness/constant/constants.dart';
import 'package:protennisfitness/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:page_transition/page_transition.dart';

import '../../elements/ListWorkoutWidget.dart';
import '../../elements/PermissionDeniedWidget.dart';

import '../../providers/user_repository.dart' as userRepo;
import '../../providers/workout_repository.dart' as workoutRepo;

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final favoriteWorkoutList = [
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
    }
  ];

  final favoriteHealthTipsList = [
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
    }
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1.0,
          centerTitle: true,
          title: Text(
            'Favorite',
            style: appBarTextStyle,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: blackColor,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          // bottom: TabBar(
          //   labelStyle: black14MediumTextStyle,
          //   labelColor: blackColor,
          //   tabs: [
          //     Tab(text: 'Workout'),
          //     Tab(text: 'Health Tips'),
          //   ],
          // ),
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: workoutRepo.favoriteWorkouts.value.isEmpty ?
                  Center(
                    child:Text(
                      "Empty",
                      style: black26MediumTextStyle,
                    ),
                  ) :
                  ListView.separated(
                    padding: EdgeInsets.all(20),
                    itemCount: workoutRepo.favoriteWorkouts.value.length,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    separatorBuilder: (context, index){
                      return SizedBox(height:10);
                    },
                    itemBuilder: (context, index) {
              
                      return ListWorkoutWidget(
                        workout: workoutRepo.favoriteWorkouts.value.elementAt(index),
                      );
              
                    }
                  ),
                ),
              ),
            ],
          )
        )
        // TabBarView(
        //   children: [
        //     workout(),
        //     healthTips(),
        //   ],
        // ),
      ),
    );
  }

  workout() {
    return 
    userRepo.currentUser.value.apiToken == null || userRepo.currentUser.value.apiToken == '' ? 
    PermissionDeniedWidget() : 
    (favoriteWorkoutList.length == 0)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100.0,
                width: 100.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: greyColor.withOpacity(0.2),
                ),
                child: Icon(
                  Icons.favorite_border,
                  color: greyColor,
                  size: 55.0,
                ),
              ),
              heightSpace,
              heightSpace,
              Text(
                'Favorite workout is empty!',
                style: grey20MediumTextStyle,
              ),
            ],
          )
        : ListView.builder(
            itemCount: favoriteWorkoutList.length,
            itemBuilder: (context, index) {
              final item = favoriteWorkoutList[index];
              return Padding(
                padding: (index == 0)
                    ? EdgeInsets.all(fixPadding * 2.0)
                    : EdgeInsets.fromLTRB(fixPadding * 2.0, 0.0,
                        fixPadding * 2.0, fixPadding * 2.0),
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
                  child: Slidable(
                    // actionPane: SlidableDrawerActionPane(),
                    // actionExtentRatio: 0.25,
                    // secondaryActions: <Widget>[
                    //   Container(
                    //     margin: EdgeInsets.only(left: 5.0),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.only(
                    //         topRight:
                    //             Radius.circular((index == 0) ? 10.0 : 0.0),
                    //       ),
                    //     ),
                    //     child: IconSlideAction(
                    //       caption: 'Delete',
                    //       color: Colors.red,
                    //       icon: Icons.delete,
                    //       onTap: () {
                    //         setState(() {
                    //           favoriteWorkoutList.removeAt(index);
                    //         });

                    //         // Then show a snackbar.
                    //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //           content: Text('Workout remove from favorite'),
                    //         ));
                    //       },
                    //     ),
                    //   ),
                    // ],
                    // startActionPane: ActionPane(
                    //   motion: const DrawerMotion(),
                    //   extentRatio: 0.25,
                    //   children: [
                    //     SlidableAction(
                    //       label: 'Archive',
                    //       backgroundColor: Colors.blue,
                    //       icon: Icons.archive,
                    //       onPressed: (context) {},
                    //     ),
                    //   ],
                    // ),
                    endActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      extentRatio: 0.25,
                      children: [
                        SlidableAction(
                          label: 'Delete',
                          backgroundColor: Colors.red,
                          icon: Icons.delete,
                          onPressed: (context) {
                            setState(() {
                              favoriteWorkoutList.removeAt(index);
                            });

                            // Then show a snackbar.
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Workout remove from favorite'),
                            ));
                          },
                        ),
                      ],
                    ),
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
                                    top: Radius.circular(20.0)),
                                image: DecorationImage(
                                  image: AssetImage(item['image']!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(fixPadding * 1.3),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title']!,
                                  style: black16SemiBoldTextStyle,
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
                ),
              );
            },
          );
  }

  healthTips() {
    return userRepo.currentUser.value.apiToken == null || userRepo.currentUser.value.apiToken == '' ? 
    PermissionDeniedWidget() : (favoriteHealthTipsList.length == 0)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100.0,
                width: 100.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: greyColor.withOpacity(0.2),
                ),
                child: Icon(
                  Icons.favorite_border,
                  color: greyColor,
                  size: 55.0,
                ),
              ),
              heightSpace,
              heightSpace,
              Text(
                'Favorite health tips is empty!',
                style: grey20MediumTextStyle,
              ),
            ],
          )
        : ListView.builder(
            itemCount: favoriteHealthTipsList.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final item = favoriteHealthTipsList[index];
              return Padding(
                padding: (index == 0)
                    ? EdgeInsets.all(fixPadding * 2.0)
                    : EdgeInsets.fromLTRB(fixPadding * 2.0, 0.0,
                        fixPadding * 2.0, fixPadding * 2.0),
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
                  child: Slidable(
                    // actionPane: SlidableDrawerActionPane(),
                    // actionExtentRatio: 0.25,
                    // secondaryActions: <Widget>[
                    //   Container(
                    //     margin: EdgeInsets.only(left: 5.0),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.only(
                    //         topRight:
                    //             Radius.circular((index == 0) ? 10.0 : 0.0),
                    //       ),
                    //     ),
                    //     child: IconSlideAction(
                    //       caption: 'Delete',
                    //       color: Colors.red,
                    //       icon: Icons.delete,
                    //       onTap: () {
                    //         setState(() {
                    //           favoriteHealthTipsList.removeAt(index);
                    //         });

                    //         // Then show a snackbar.
                    //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //           content: Text('Health tip remove from favorite'),
                    //         ));
                    //       },
                    //     ),
                    //   ),
                    // ],
                    endActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      extentRatio: 0.25,
                      children: [
                        SlidableAction(
                          label: 'Delete',
                          backgroundColor: Colors.red,
                          icon: Icons.delete,
                          onPressed: (context) {
                            setState(() {
                              favoriteHealthTipsList.removeAt(index);
                            });

                            // Then show a snackbar.
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Health tip remove from favorite'),
                            ));
                          },
                        ),
                      ],
                    ),
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
                ),
              );
            },
          );
  }
}
