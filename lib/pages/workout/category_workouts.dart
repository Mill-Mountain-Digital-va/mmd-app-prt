import 'package:protennisfitness/constant/constants.dart';
import 'package:protennisfitness/elements/CircularLoadingWidget.dart';
// import 'package:protennisfitness/models/exercises.dart';
import 'package:protennisfitness/screens.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
// import 'package:protennisfitness/widget/column_builder.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../models/category.dart';
import '../../elements/ListWorkoutWidget.dart';
import '../../elements/DrawerWidget.dart';
import '../../controllers/workouts_controller.dart';

// ignore: must_be_immutable
class CategoryWorkoutsWidget extends StatefulWidget {
  Category? category;

  CategoryWorkoutsWidget(
      {Key? key,
      @required this.category})
      : super(key: key);
  @override
  _CategoryWorkoutsWidgetState createState() => _CategoryWorkoutsWidgetState();
}

class _CategoryWorkoutsWidgetState extends StateMVC<CategoryWorkoutsWidget> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  WorkoutsController _con = new WorkoutsController();

  bool favorite = false;
  _CategoryWorkoutsWidgetState() : super(WorkoutsController()) {
    _con = controller as WorkoutsController;
  }

  @override
  void initState() {

    // get selected workout
    _con.listenForCategoryWorkouts( widget.category!.id! );

    super.initState();
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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: primaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
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
      drawer: DrawerWidget(),
      body: Container(
        child: Column(
            children: [
              Container(
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
                      tag: widget.category!.slug!,
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
                            image: NetworkImage(widget.category!.image!),
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
                              widget.category!.name!,
                              style: white14MediumTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _con.listenForWorkoutsDone == false ? 
              CircularLoadingWidget( height: 100,) :
              Expanded(
                child: Container(
                  child: ListView.separated(
                    padding: EdgeInsets.all(20),
                    itemCount: _con.workouts!.length,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    separatorBuilder: (context, index){
                      return SizedBox(height:10);
                    },
                    itemBuilder: (context, index) {
              
                      return ListWorkoutWidget(
                        workout: _con.workouts!.elementAt(index),
                      );
              
                    }
                  ),
                ),
              ),
            ],
          ),
      )
    );
  }


}