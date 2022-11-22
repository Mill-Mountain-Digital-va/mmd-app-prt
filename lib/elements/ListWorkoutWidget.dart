import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:protennisfitness/screens.dart';
// import '../pages/workout/category_workouts.dart';
import '../pages/workout/workout_detail.dart';

import '../models/workout.dart';

import '../../constant/constants.dart';
import '../providers/settings_repository.dart' as settingsRepo;
import '../../providers/user_repository.dart' as userRepo;

// ignore: must_be_immutable
class ListWorkoutWidget extends StatelessWidget {
  Workout? workout;

  ListWorkoutWidget({Key? key, @required this.workout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

        if(userRepo.currentUser.value.apiToken == null || userRepo.currentUser.value.apiToken == ''){
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.scale,
                alignment: Alignment.bottomCenter,
                child: Walkthrough()));
        }else if(settingsRepo.isPremium() == false && workout!.free == false){
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.scale,
                alignment: Alignment.bottomCenter,
                child: UnlockPremium()));
        }else {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              duration: Duration(milliseconds: 600),
              child: WorkoutDetail(
                id: workout!.id,
              )
            ),
          );
        }
      },
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        height: 100.0,
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
        child: Row(
          children: [
            Container(
              width: 100,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Hero(
                    tag: workout!.slug!,//['heroTag'],
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20.0),
                          bottom: Radius.circular(20.0),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(workout!.image!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  settingsRepo.isPremium() == true || workout!.free == true ? SizedBox.shrink() :
                  Container(
                    margin: EdgeInsets.only(bottom:5),
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.0),
                        bottom: Radius.circular(20.0),
                      ),
                      color: Colors.red[400],
                    ),
                    child: Text(
                      'Premium',
                      style: TextStyle(
                          color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  )
                  
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only( top: fixPadding * 1, left: fixPadding * 1, right: fixPadding * 1 ),
                  width: MediaQuery.of(context).size.width - 150,
                  child: Text(
                    workout!.title!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, color: primaryColor, fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: fixPadding * 0.5, right: fixPadding * 1 ),
                  width: MediaQuery.of(context).size.width - 150,
                  child: Html(
                    data: workout!.equipment,
                    style: {
                      "p": Style(
                        fontSize: FontSize.medium,
                        textOverflow: TextOverflow.ellipsis,
                        color: Colors.black,
                        textAlign: TextAlign.start
                      ),
                    }
                  ),
                  
                )
              ],
            )
          ],
        )
      ),
    );
  }
}