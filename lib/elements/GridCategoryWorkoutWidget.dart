import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../pages/workout/category_workouts.dart';

import '../models/category.dart';
// import '../models/route_argument.dart';

import '../../constant/constants.dart';

// ignore: must_be_immutable
class GridCategoryWorkoutWidget extends StatelessWidget {
  Category? category;
  int? index;
  int? lastIndex;
  String? heroTag;

  GridCategoryWorkoutWidget({Key? key, this.category, this.index, this.lastIndex, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 600),
            child: CategoryWorkoutsWidget(
              category: category,
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
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Hero(
              tag: category!.slug!,//['heroTag'],
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.0),
                    bottom: Radius.circular(20.0),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(category!.image!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
    
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey.withOpacity(0.3),
              ),
            ),
            Container(
              padding: EdgeInsets.all(fixPadding * 1),
              child: Text(
                category!.name!,
                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
              ),
            )

            // Container(
            //   padding: EdgeInsets.all(fixPadding * 1),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         item['title'],
            //         style: primaryColor16MediumTextStyle,
            //       ),
            //       height5Space,
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           Icon(
            //             Icons.timer,
            //             color: greyColor,
            //             size: 18.0,
            //           ),
            //           width5Space,
            //           Text(
            //             item['time'],
            //             style: grey14MediumTextStyle,
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}