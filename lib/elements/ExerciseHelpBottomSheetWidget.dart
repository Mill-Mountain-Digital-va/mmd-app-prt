import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:protennisfitness/constant/constants.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../models/exercises.dart';
import '../../generated/l10n.dart';

class ExerciseHelpBottomSheetWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Exercise? exercise;
  final VoidCallback? close;

  ExerciseHelpBottomSheetWidget({Key? key, this.scaffoldKey, this.exercise, this.close}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 10, offset: Offset(0, 0)),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ListView(
              padding: EdgeInsets.only(top: 20, bottom: 15, left: 20, right: 20),
              children: <Widget>[
                InkWell(
                  onTap: () async {

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        S.of(context).exercise_help,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                             
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Html(
                  data: exercise!.fullText,
                  /*style: {
                    "p": Style(
                      fontSize: FontSize.large,
                      color: darkBlueColor,
                      textAlign: TextAlign.center
                    ),
                  }*/
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, right: 25),
            child: InkWell(
              onTap: () async {
                print("close bottom sheet");
                this.close!();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ],
              ),
            )
          ),
          Container(
            height: 30,
            width: double.infinity,
            // padding: EdgeInsets.symmetric(vertical: 13, horizontal: config.App(context).appWidth(42)),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.8),
              borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 3,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
