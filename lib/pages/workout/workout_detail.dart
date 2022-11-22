import 'package:protennisfitness/constant/constants.dart';
import 'package:protennisfitness/elements/CircularLoadingWidget.dart';
import 'package:protennisfitness/models/exercises.dart';
import 'package:protennisfitness/screens.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:protennisfitness/widget/column_builder.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:flutter_html/flutter_html.dart';
import '../../controllers/workouts_controller.dart';
import '../../providers/settings_repository.dart' as settingsRepo;
import '../../providers/user_repository.dart' as userRepo;

class WorkoutDetail extends StatefulWidget {
  final String? id;

  const WorkoutDetail(
      {Key? key,
      @required this.id})
      : super(key: key);
  @override
  _WorkoutDetailState createState() => _WorkoutDetailState();
}

class _WorkoutDetailState extends StateMVC<WorkoutDetail> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  WorkoutsController _con = new WorkoutsController();

  // bool favorite = false;
  _WorkoutDetailState() : super(WorkoutsController()) {
    _con = controller as WorkoutsController;
  }

  @override
  void initState() {

    // get selected workout
    _con.listenForWorkout(id: widget.id! ).whenComplete(() {

    });

    super.initState();
  }



  void _favorite() async {

    await _con.addRemoveFavorite(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1.0,
        centerTitle: true,
        title: Text(
          _con.workout != null ? _con.workout!.title! : '',
          style: appBarTextStyle,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              (_con.favorite) ? Icons.favorite : Icons.favorite_border,
              color: primaryColor,
            ),
            onPressed: () {
              _favorite();
            },
          ),
        ],
      ),
      body: _con.workout == null ? CircularLoadingWidget( height: MediaQuery.of(context).size.height )
      : Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  upperImage(),
                  settingsRepo.isPremium() == true || _con.workout!.free == true ? SizedBox.shrink() :
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.0),
                            bottom: Radius.circular(20.0),
                          ),
                          color: Colors.red[400],
                        ),
                        child: Center(
                          child: Text(
                            'Premium',
                            style: TextStyle(
                                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  aboutExercise(),
                  exercise(),
                  SizedBox(height: 80.0),
                ],
              ),
            ),
            settingsRepo.isPremium() == true || _con.workout!.free == true ?
            Positioned(
              bottom: 0.0,
              left: 0.0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 80.0,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.scale,
                        alignment: Alignment.bottomCenter,
                        child: WorkoutScreen(
                          workout: _con.workout,
                        )
                      )
                    );
                  },
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(fixPadding * 3.0,
                        fixPadding * 1.5, fixPadding * 3.0, fixPadding * 1.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [0.1, 0.5, 0.9],
                        colors: [
                          Colors.green[700]!,
                          Colors.green[500]!,
                          Colors.green[300]!,
                        ],
                      ),
                    ),
                    child: Text(
                      'Start Workout'.toUpperCase(),
                      style: white16MediumTextStyle,
                    ),
                  ),
                ),
              ),
            ) :
            Positioned(
              bottom: 0.0,
              left: 0.0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 80.0,
                color: Colors.transparent,
                alignment: Alignment.center,
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
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(fixPadding * 3.0,
                        fixPadding * 1.5, fixPadding * 3.0, fixPadding * 1.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [0.1, 0.5, 0.9],
                        colors: [
                          Color(0xFF222141),
                          Color(0xFF222141).withOpacity(0.9),
                          Color(0xFF132747).withOpacity(0.8),
                        ],
                      ),
                    ),
                    child: Text(
                      'Unlock now'.toUpperCase(),
                      style: white16MediumTextStyle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  upperImage() {
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
      child: Stack(
        children: [
          Hero(
            tag: _con.workout!.slug!,
            child: Container(
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
                image: DecorationImage(
                  image: NetworkImage(_con.workout!.image!),
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
                  blackColor.withOpacity(0.2),
                  blackColor.withOpacity(0.6),
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
                    _con.workout!.title!,
                    style: white14MediumTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  aboutExercise() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(fixPadding * 2.0),
      color: primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: (width - fixPadding * 4.0 - 2.0) / 2.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total: ' + _con.workout!.exercises!.length.toString() + ' Exercises',
                  style: white14MediumTextStyle,
                ),
                heightSpace,
                Text(
                  'Turns: ' + _con.workout!.turns!,
                  style: white14MediumTextStyle,
                ),
              ],
            ),
          ),
          Container(
            width: 1.0,
            height: 60.0,
            color: whiteColor,
          ),
          Container(
            width: (width - fixPadding * 4.0 - 2.0) / 2.0,
            padding: EdgeInsets.only(left: fixPadding * 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Equipment',
                  style: white14MediumTextStyle,
                ),
                heightSpace,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  margin: EdgeInsets.only(left: 0),
                  // width: MediaQuery.of(context).size.width - 150,
                  child: Html(
                    data: _con.workout!.equipment,
                    style: {
                      "p": Style(
                        fontSize: FontSize.medium,
                        color: Colors.white
                      ),
                    }
                  ),
                  
                )
                // Text(
                //   _con.workout!.equipment,
                //   maxLines: 2,
                //   overflow: TextOverflow.ellipsis,
                //   style: white12MediumTextStyle,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  exercise() {
    return Container(
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: ColumnBuilder(
        itemCount: _con.workout!.exercises!.length,
        itemBuilder: (context, index) {
          
          Exercise item = _con.workout!.exercises!.elementAt(index);

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 90.0,
                    margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
                    padding: EdgeInsets.only(
                      left: (45.0 + fixPadding),
                      right: fixPadding,
                    ),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: whiteColor,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          blurRadius: 3.0,
                          spreadRadius: 3.0,
                          color: lightGreyColor!,
                        ),
                      ],
                    ),
                    child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 200,
                                  margin: EdgeInsets.only(right: 10 ),
                                  child: Text(
                                    item.title!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: black16MediumTextStyle,
                                  ),
                                ),
                              ],
                            ),
                            height5Space,
                            item.exerciseMode() == "time" ? 
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Time:',
                                  style: black12MediumTextStyle,
                                ),
                                SizedBox(width: 3.0),
                                Text(
                                  item.duration! + " seconds",
                                  style: grey12RegularTextStyle,
                                )
                              ],
                            ) : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Repetitions:',
                                  style: black12MediumTextStyle,
                                ),
                                SizedBox(width: 3.0),
                                Text(
                                  item.repetitions! + " Repetitions",
                                  style: grey12RegularTextStyle,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Equipment:',
                                  style: black12MediumTextStyle,
                                ),
                                SizedBox(width: 3.0),
                                Text(
                                  item.equipment!,
                                  style: grey12RegularTextStyle,
                                )
                              ],
                            ),
                            SizedBox(height: 2.0),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   crossAxisAlignment: CrossAxisAlignment.end,
                            //   children: [
                            //     Text(
                            //       'Burns:',
                            //       style: black12MediumTextStyle,
                            //     ),
                            //     SizedBox(width: 3.0),
                            //     Text(
                            //       item['burn'],
                            //       style: grey12RegularTextStyle,
                            //     )
                            //   ],
                            // ),
                          ],
                        ),
                        // (item['status'] == 'completed')
                        //     ? Container(
                        //         width: 24.0,
                        //         height: 24.0,
                        //         alignment: Alignment.center,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(12.0),
                        //           color: Colors.green,
                        //         ),
                        //         child: Icon(
                        //           Icons.check,
                        //           size: 16.0,
                        //           color: whiteColor,
                        //         ),
                        //       )
                        //     : Container(
                        //         height: 80.0,
                        //         margin: EdgeInsets.only(top: fixPadding),
                        //         alignment: Alignment.topRight,
                        //         child: Container(
                        //           padding: EdgeInsets.all(5.0),
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(5.0),
                        //             color: primaryColor,
                        //           ),
                        //           child: Text(
                        //             'Remain',
                        //             style: whiteSmallTextStyle,
                        //           ),
                        //         ),
                        //       ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(
                        width: 2.0,
                        color:
                            (index % 2 == 0) ? primaryColor : Colors.red[800]!,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(item.image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              (index != _con.workout!.exercises!.length - 1)
                  ? Container(
                      width: 1.5,
                      height: 30.0,
                      // (item['status'] == 'completed') ? primaryColor : 
                      color: greyColor.withOpacity(0.7),
                      margin: EdgeInsets.only(left: 43.5),
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }
}
