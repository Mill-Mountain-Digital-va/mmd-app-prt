// import 'dart:async';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import '../models/route_argument.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

// import '../providers/settings_repository.dart' as settingsRepo;
import '../providers/workout_repository.dart' as workoutRepo;
// import '../helpers/helper.dart';
//import '../../generated/l10n.dart';
import '../models/workout.dart';
import '../models/category.dart';

class WorkoutsController extends ControllerMVC {
  
  GlobalKey<ScaffoldState>? scaffoldKey;

  bool listenForWorkoutsDone = true;
  bool listenForCategoriesDone = true;

  // LIST OF WORKOUTS
  List<Workout>? workouts = [];

  // LIST OF Categories
  List<Category>? categories = [];

  // WORKOUT
  Workout? workout;

  bool favorite = false;

  WorkoutsController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }


  @override
  void initState() {

    super.initState();
  }

  /// GET LIST OF WORKOUTS
  Future<void> listenForWorkouts() async {
    print("_listenForWorkouts");

    setState((){
      listenForWorkoutsDone = false;
      workouts!.clear();
    });

    final Stream<Workout> stream = await workoutRepo.getWorkouts(type: "featured");

    stream.listen((Workout _workout) {
      print(_workout);
      setState(() => workouts!.add(_workout));
    }, 
    onError: (a) {}, 
    onDone: ()  {
      
      print(workouts!.length);

      setState(() {
        listenForWorkoutsDone = true;
      });
    });
  }

  /// GET WORKOUT DETAILS BY ID
  Future<void> listenForWorkout({String? id, String? message}) async {

    final Stream<Workout> stream = await workoutRepo.getWorkout(id);
    stream.listen((Workout _workout) {
      setState(() => workout = _workout);
    }, onError: (a) {
      print(a);
      // scaffoldKey.currentState.showSnackBar(SnackBar(
      //   content: Text(S.current.verify_your_internet_connection),
      // ));
    }, onDone: () async {
      print("done");
      print(workout!.exercises!.length);

      await checkWorkoutFavorite();
    });
  }

  /// GET LIST OF CATEGORIES OF WORKOUTS
  Future<void> listenForCategories() async {
    print("listenForCategories");

    setState((){
      listenForCategoriesDone = false;
      categories!.clear();
    });

    final Stream<Category> stream = await workoutRepo.getCategories( );

    stream.listen((Category _category) {
      print(_category);
      setState(() => categories!.add(_category));
    }, 
    onError: (a) {}, 
    onDone: ()  {
      setState(() {
        listenForCategoriesDone = true;
      });
    });
  }

  /// GET LIST OF WORKOUTS OF SELECTED CATEGORY
  Future<void> listenForCategoryWorkouts(String id) async {

    setState((){
      listenForWorkoutsDone = false;
      workouts!.clear();
    });

    final Stream<Workout> stream = await workoutRepo.getCategoryWorkouts(id);

    stream.listen((Workout _workout) {
      setState(() => workouts!.add(_workout));
    }, 
    onError: (a) {}, 
    onDone: ()  {

      setState(() {
        listenForWorkoutsDone = true;
      });
    });

  }

  // SEARCH WORKOUTS AND CATEGORIES
  Future<void> searchForWorkoutsCategories(String search) async {

    setState((){
      listenForWorkoutsDone = false;
      workouts!.clear();
    });

    final Stream<Workout> stream = await workoutRepo.getWorkoutsSearch(search);

    stream.listen((Workout _workout) {
      setState(() => workouts!.add(_workout));
    }, 
    onError: (a) {}, 
    onDone: ()  {

      setState(() {
        listenForWorkoutsDone = true;
      });
    });

  }


  Future<bool> getWorkoutFavorites() async{

    await workoutRepo.getFavoriteWorkouts().whenComplete(() {
      
    }).onError((error, stackTrace) {
      return false;
    });

    return true;
  }

  Future<void> checkWorkoutFavorite() async {
    if(workoutRepo.favoriteWorkouts.value.where((element) => element.id == workout!.id).isNotEmpty){
      setState(() {
        favorite = true;
      });
    }else{
      setState(() {
        favorite = false;
      });
    }
  }


  Future<void> addRemoveFavorite(BuildContext context) async {

    if(workoutRepo.favoriteWorkouts.value.where((element) => element.id == workout!.id).isEmpty){
      workoutRepo.favoriteWorkouts.value.add(workout!);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added to favorite')));
    }else{
      workoutRepo.favoriteWorkouts.value.removeWhere((element) => element.id == workout!.id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Remove from favorite')));
    }

    await workoutRepo.setWorkoutFavorites();

    await checkWorkoutFavorite();
  }



}
