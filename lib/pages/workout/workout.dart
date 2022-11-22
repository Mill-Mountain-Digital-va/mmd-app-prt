// import 'package:carousel_pro/carousel_pro.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../elements/DrawerWidget.dart';
import '../../elements/GridCategoryWorkoutWidget.dart';
import '../../models/workout.dart';

import '../../elements/CircularLoadingWidget.dart';

import '../../providers/user_repository.dart' as userRepo;
import '../../constant/constants.dart';
import '../../models/user.dart';
import '../../screens.dart';
import '../../controllers/workouts_controller.dart';

class WorkOutWidget extends StatefulWidget {
  @override
  _WorkOutState createState() => _WorkOutState();
}

class _WorkOutState extends StateMVC<WorkOutWidget> {


  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  WorkoutsController _con = new WorkoutsController();

  _WorkOutState() : super(WorkoutsController()) {
    _con = controller as WorkoutsController;
  }

  @override
  void initState() {
    _con.listenForWorkouts();
    _con.listenForCategories();

    print(userRepo.currentUser.value.toMap());

    super.initState();
  }

/*
  appBar: PreferredSize(
          preferredSize: Size.fromHeight(110.0), // here the desired height
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          toolbarHeight: 100,
          elevation: 5.0,
          leadingWidth: 100,
          centerTitle: true,
          leading: Container(
            margin: EdgeInsets.only(left: 30, top: 30),
            color: Colors.red,
            child: IconButton(
              icon: Icon(
                Icons.menu,
                color: primaryColor,
              ),
              onPressed: () {
                scaffoldKey.currentState.openDrawer();
              },
            )
          ),
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: primaryColor,
          ),
          onPressed: () {
            if(userRepo.currentUser.value.apiToken == null || userRepo.currentUser.value.apiToken == ''){
              Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.scale,
                    alignment: Alignment.bottomCenter,
                    child: Walkthrough()));
            }else
              scaffoldKey.currentState!.openDrawer();
          },
        ),
        title: Container(
          width: double.infinity,
          height: 40.0,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: AssetImage("assets/banner_color.png"),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        
        // Text(
        //   'Workout',
        //   style: appBarTextStyle,
        // ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: primaryColor,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft, child: Favorite()));
            },
          ),
        ],
      ),
      drawer: userRepo.currentUser.value.apiToken == null || userRepo.currentUser.value.apiToken == '' ? SizedBox.shrink() : DrawerWidget(),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          _con.listenForWorkoutsDone == false ? 
          CircularLoadingWidget( height: 100,) :
          slider(),
          //homeWorkoutPlan(),
          //heightSpace,
          //heightSpace,
          // flatAbsWorkoutPlan(),
          userRepo.currentUser.value is User && userRepo.currentUser.value.premium == true ?
          SizedBox.shrink() : unlockPremium(),
          workoutCategories(),
          // popularTrainer(),
          heightSpace,
          heightSpace,
        ],
      ),
    );
  }

  slider() {
    return Container(
      margin: EdgeInsets.all(fixPadding * 2.0),
      height: 200.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 5.0,
            spreadRadius: 5.0,
            color: lightGreyColor!,
          ),
        ],
      ),
      child: Carousel(
        images: List.generate(
          _con.workouts!.length, 
          (index) {

            Workout item = _con.workouts![index];

            return InkWell(
              onTap: () {
                Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          duration: Duration(milliseconds: 600),
                          child: WorkoutDetail(
                            id: item.id,
                          )));
              },
              child: sliderItem(item),
            );
          }
        ),
        dotSize: 4.0,
        dotSpacing: 15.0,
        autoplayDuration: Duration(seconds: 6),
        dotPosition: DotPosition.bottomRight,
        dotVerticalPadding: 5.0,
        dotHorizontalPadding: 5.0,
        dotColor: greyColor,
        indicatorBgPadding: 5.0,
        dotBgColor: Colors.transparent,
        borderRadius: false,
      ),
    );
  }

  sliderItem( Workout item) {
    return Container(
      width: double.infinity,
      height: 200.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          Hero(
            tag: item.slug!,
            child: Container(
              width: double.infinity,
              height: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              //   image: DecorationImage(
              //     image: NetworkImage(item.image!),
              //     fit: BoxFit.cover,
              //   ),
              ),
              child: CachedNetworkImage(
                imageUrl: item.image!,
                placeholderFadeInDuration: Duration(seconds: 0),
                fit: BoxFit.cover,
                // placeholder: (context, url) => CircularProgressIndicator(),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                cacheManager: CacheManager(
                    Config(
                      item.slug!,
                      stalePeriod: const Duration(days: 7),
                      //one week cache period
                    )
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 200.0,
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.5, 0.9],
                colors: [
                  blackColor.withOpacity(0.0),
                  blackColor.withOpacity(0.3),
                  blackColor.withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(fixPadding),
                  child: Text(
                    item.title!.toUpperCase(),
                    style: white16MediumTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  homeWorkoutPlan() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              fixPadding * 2.0, 0.0, fixPadding * 2.0, fixPadding * 2.0),
          child: Text(
            'Quick Home Workout Plan',
            style: primaryColor16MediumTextStyle,
          ),
        ),
        _con.listenForWorkoutsDone == false ? 
        CircularLoadingWidget( height: 100,) :
        Container(
          width: double.infinity,
          height: 204.0,
          child: ListView.builder(
            itemCount: _con.workouts!.length,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              
              Workout item = _con.workouts![index];
              
              return Padding(
                padding: (index == 0)
                    ? EdgeInsets.only(
                        left: fixPadding * 2.0,
                        right: fixPadding * 1.5,
                        top: 2.0,
                        bottom: 2.0)
                    : (index == _con.workouts!.length - 1)
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
                            child: WorkoutDetail(
                              id: item.id,
                            )));
                  },
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    width: 130.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          blurRadius: 1.0,
                          spreadRadius: 1.0,
                          color: lightGreyColor!,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Hero(
                          tag: item.slug!,
                          child: Container(
                            width: 130.0,
                            height: 200.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                // image: AssetImage(item.image),
                                image: NetworkImage(item.image!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 200.0,
                          alignment: Alignment.bottomLeft,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.1, 0.5, 0.9],
                              colors: [
                                blackColor.withOpacity(0.0),
                                blackColor.withOpacity(0.3),
                                blackColor.withOpacity(0.7),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(fixPadding),
                                child: Text(
                                  item.title!,
                                  style: white14MediumTextStyle,
                                ),
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
        )
      ],
    );
  }

  // flatAbsWorkoutPlan() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.fromLTRB(
  //             fixPadding * 2.0, 0.0, fixPadding * 2.0, fixPadding * 2.0),
  //         child: Text(
  //           'Flat Abs Workout Plan',
  //           style: primaryColor16MediumTextStyle,
  //         ),
  //       ),
  //       Container(
  //         width: double.infinity,
  //         height: 204.0,
  //         child: ListView.builder(
  //           itemCount: flatAbsWorkoutList.length,
  //           scrollDirection: Axis.horizontal,
  //           physics: BouncingScrollPhysics(),
  //           itemBuilder: (context, index) {
  //             final item = flatAbsWorkoutList[index];
  //             return Padding(
  //               padding: (index == 0)
  //                   ? EdgeInsets.only(
  //                       left: fixPadding * 2.0,
  //                       right: fixPadding * 1.5,
  //                       top: 2.0,
  //                       bottom: 2.0)
  //                   : (index == flatAbsWorkoutList.length - 1)
  //                       ? EdgeInsets.only(
  //                           right: fixPadding * 2.0, top: 2.0, bottom: 2.0)
  //                       : EdgeInsets.only(
  //                           right: fixPadding * 1.5, top: 2.0, bottom: 2.0),
  //               child: InkWell(
  //                 onTap: () {
  //                   // Navigator.push(
  //                   //     context,
  //                   //     PageTransition(
  //                   //         type: PageTransitionType.fade,
  //                   //         duration: Duration(milliseconds: 600),
  //                   //         child: WorkoutDetail(
  //                   //           title: item['title'],
  //                   //           image: item['image'],
  //                   //           heroTag: item['heroTag'],
  //                   //         )));
  //                 },
  //                 borderRadius: BorderRadius.circular(10.0),
  //                 child: Container(
  //                   width: 130.0,
  //                   height: 200.0,
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(10.0),
  //                     boxShadow: <BoxShadow>[
  //                       BoxShadow(
  //                         blurRadius: 1.0,
  //                         spreadRadius: 1.0,
  //                         color: lightGreyColor!,
  //                       ),
  //                     ],
  //                   ),
  //                   child: Stack(
  //                     children: [
  //                       Hero(
  //                         tag: item['heroTag'],
  //                         child: Container(
  //                           width: 130.0,
  //                           height: 200.0,
  //                           decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(10.0),
  //                             image: DecorationImage(
  //                               image: AssetImage(item['image']),
  //                               fit: BoxFit.cover,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         width: double.infinity,
  //                         height: 200.0,
  //                         alignment: Alignment.bottomLeft,
  //                         decoration: BoxDecoration(
  //                           gradient: LinearGradient(
  //                             begin: Alignment.topCenter,
  //                             end: Alignment.bottomCenter,
  //                             stops: [0.1, 0.5, 0.9],
  //                             colors: [
  //                               blackColor.withOpacity(0.0),
  //                               blackColor.withOpacity(0.3),
  //                               blackColor.withOpacity(0.7),
  //                             ],
  //                           ),
  //                           borderRadius: BorderRadius.circular(10.0),
  //                         ),
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.end,
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Padding(
  //                               padding: EdgeInsets.all(fixPadding),
  //                               child: Text(
  //                                 item['title'],
  //                                 style: white14MediumTextStyle,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //       )
  //     ],
  //   );
  // }

  unlockPremium() {
    return Padding(
      padding: const EdgeInsets.all(fixPadding * 2.0),
      child: InkWell(
        onTap: () {
          if(userRepo.currentUser.value.apiToken == null || userRepo.currentUser.value.apiToken == ''){
            Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.scale,
                  alignment: Alignment.bottomCenter,
                  child: Walkthrough()));
          }else{
            Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.scale,
                  alignment: Alignment.bottomCenter,
                  child: UnlockPremium()));
          }
          
        },
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          padding: const EdgeInsets.all(fixPadding * 2.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: cardColor,
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurRadius: 5.0,
                spreadRadius: 2.0,
                color: lightGreyColor!,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Unlock the',
                style: darkBlue22BoldTextStyle,
              ),
              height5Space,
              Text(
                'Premium Workouts',
                style: darkBlue22BoldTextStyle,
              ),
              heightSpace,
              Material(
                borderRadius: BorderRadius.circular(20.0),
                elevation: 3.0,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    fixPadding * 4.0,
                    fixPadding * 1.2,
                    fixPadding * 4.0,
                    fixPadding * 1.2,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: darkBlueColor,
                  ),
                  child: Text(
                    'Unlock now'.toUpperCase(),
                    style: white18SemiBoldTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  workoutCategories() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              fixPadding * 2.0, 0.0, fixPadding * 2.0, fixPadding * 2.0),
          child: Text(
            'Workouts Categories',
            style: primaryColor16MediumTextStyle,
          ),
        ),
        _con.listenForCategoriesDone == false ? 
        CircularLoadingWidget( height: 100) :
        Container(
          //height: 170.0,
          padding: EdgeInsets.only(left:20, right: 20),
          width: double.infinity,
          child: GridView.count(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            padding: EdgeInsets.symmetric(vertical: 10),
            crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4,
            children: List.generate(_con.categories!.length, (index) {
              
              int lastIndex = _con.categories!.length - 1;

              return GridCategoryWorkoutWidget(
                category: _con.categories![index],
                lastIndex: lastIndex,
                index: index
              );

            }),
          )
        ),
      ],
    );
  }

  // popularTrainer() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.all(fixPadding * 2.0),
  //         child: Text(
  //           'Popular trainer',
  //           style: primaryColor16MediumTextStyle,
  //         ),
  //       ),
  //       Container(
  //         height: 220.0,
  //         width: double.infinity,
  //         child: ListView.builder(
  //           itemCount: trainerList.length,
  //           scrollDirection: Axis.horizontal,
  //           physics: BouncingScrollPhysics(),
  //           itemBuilder: (context, index) {
  //             final item = trainerList[index];
  //             return Padding(
  //               padding: (index == 0)
  //                   ? EdgeInsets.only(
  //                       left: fixPadding * 2.0,
  //                       right: fixPadding * 1.5,
  //                       top: 2.0,
  //                       bottom: 2.0)
  //                   : (index == trainerList.length - 1)
  //                       ? EdgeInsets.only(
  //                           right: fixPadding * 2.0, top: 2.0, bottom: 2.0)
  //                       : EdgeInsets.only(
  //                           right: fixPadding * 1.5, top: 2.0, bottom: 2.0),
  //               child: InkWell(
  //                 onTap: () {
  //                   Navigator.push(
  //                     context,
  //                     PageTransition(
  //                       type: PageTransitionType.fade,
  //                       duration: Duration(milliseconds: 600),
  //                       child: Trainer(
  //                         name: item['name'],
  //                         imagePath: item['image'],
  //                         type: item['type'],
  //                         heroTag: item['heroTag'],
  //                       ),
  //                     ),
  //                   );
  //                 },
  //                 borderRadius: BorderRadius.circular(20.0),
  //                 child: Container(
  //                   width: 170.0,
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(20.0),
  //                     color: whiteColor,
  //                     boxShadow: <BoxShadow>[
  //                       BoxShadow(
  //                         blurRadius: 1.0,
  //                         spreadRadius: 1.0,
  //                         color: lightGreyColor!,
  //                       ),
  //                     ],
  //                   ),
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Expanded(
  //                         child: Hero(
  //                           tag: item['heroTag'],
  //                           child: Container(
  //                             decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.vertical(
  //                                   top: Radius.circular(20.0)),
  //                               image: DecorationImage(
  //                                 image: AssetImage(item['image']),
  //                                 fit: BoxFit.cover,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         padding: EdgeInsets.all(fixPadding),
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.start,
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               item['name'],
  //                               style: primaryColor16MediumTextStyle,
  //                             ),
  //                             height5Space,
  //                             Text(
  //                               item['type'],
  //                               style: grey14MediumTextStyle,
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
