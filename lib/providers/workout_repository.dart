import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/helper.dart';
import '../models/workout.dart';
import '../models/category.dart';
// import '../models/filter.dart';
// import '../models/product.dart';
// import '../models/review.dart';
// import '../models/user.dart';
// import '../providers/user_repository.dart' as userRepo;
// import '../providers/settings_repository.dart' as settingsRepo;
ValueNotifier<List<Workout>> favoriteWorkouts = new ValueNotifier( <Workout>[] );

Future<Stream<Workout>> getWorkouts({String type = ""} ) async {
  final String url = '${GlobalConfiguration().getValue('api_base_url')}workouts';
  print(url);

  Uri uri = Uri.parse(url);
  Map<String, dynamic> _queryParams = {};

  // // _queryParams['limit'] = '10';
  // _queryParams['with'] = 'market;category;options;optionGroups;productReviews;productReviews.user';
  // if (settingsRepo.deliveryAddress.value.latitude != null && settingsRepo.deliveryAddress.value.longitude != null) {
  //   _queryParams['myLon'] = settingsRepo.deliveryAddress.value.longitude.toString();
  //   _queryParams['myLat'] = settingsRepo.deliveryAddress.value.latitude.toString();
  //   _queryParams['areaLon'] = settingsRepo.deliveryAddress.value.longitude.toString();
  //   _queryParams['areaLat'] = settingsRepo.deliveryAddress.value.latitude.toString();
  // }
  if(type.isNotEmpty){
    _queryParams['type'] = type;
  }

  uri = uri.replace(queryParameters: _queryParams);
  
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data as Map<String, dynamic>))
      .expand((data) => (data as List))
      .map((data) {
        print(data);
    return Workout.fromJSON(data);
  });
}

/// GET INFO OF SELECTED WORKOUT
Future<Stream<Workout>> getWorkout(String? id) async {
  Uri uri = Helper.getUri('api/v2/workouts/$id');

  print(uri);
  
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data as Map<String, dynamic>))
      .map((data) => Workout.fromJSON(data));
}

/// GET INFO OF SELECTED WORKOUT
Future<Stream<Workout>> getWorkoutsSearch(String txt) async {
  final String url = '${GlobalConfiguration().getValue('api_base_url')}workouts_search';
  print(url);

  Uri uri = Uri.parse(url);
  Map<String, dynamic> _queryParams = {};

  _queryParams['search'] = txt;
  uri = uri.replace(queryParameters: _queryParams);

  print(uri.toString());
  
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data as Map<String, dynamic>))
      .expand((data) => (data as List))
      .map((data) {
        print(data);
    return Workout.fromJSON(data);
  });
}

/// GET LIST OF ALL WORKOUTS OF SELECTED CATEGORY
Future<Stream<Workout>> getCategoryWorkouts(String id) async {
  // Uri uri = Helper.getUri('api/v2/category_workouts?id=$id');
  
  final String url = '${GlobalConfiguration().getValue('api_base_url')}category_workouts';

  Uri uri = Uri.parse(url);
  Map<String, dynamic> _queryParams = {};

  _queryParams['id'] = id;

  uri = uri.replace(queryParameters: _queryParams);
  
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data as Map<String, dynamic>))
      .expand((data) => (data as List))
      .map((data) {
    return Workout.fromJSON(data);
  });
}

///GET LIST OF ALL AVAILABLE CATEGORIES OF WORKOUTS
Future<Stream<Category>> getCategories( ) async {
  final String url = '${GlobalConfiguration().getValue('api_base_url')}categories';
  print(url);

  Uri uri = Uri.parse(url);
  Map<String, dynamic> _queryParams = {};
  uri = uri.replace(queryParameters: _queryParams);
  
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data as Map<String, dynamic>))
      .expand((data) => (data as List))
      .map((data) {
        print(data);
    return Category.fromJSON(data);
  });
}

/// WORKOUT TO FAVORITE
Future<void> setWorkoutFavorites() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if(prefs.containsKey('favorites')){

    List<String> _save = [];

    // Add new to the list
    // favoriteWorkouts.value.add(workout);

    // convert to string list
    favoriteWorkouts.value.forEach((element) {
      _save.add(json.encode(element.toMap()));
    });

    await prefs.setStringList('favorites', _save);
    
    favoriteWorkouts.notifyListeners();
  }
}

/// GET All Saved Favorites
Future<bool> getFavoriteWorkouts() async {
  bool done = false;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.clear();
  if (prefs.containsKey('favorites')) {
    List<String> _data = prefs.getStringList('favorites') ?? [];
    favoriteWorkouts.value.clear();

    _data.forEach((element) {
      favoriteWorkouts.value.add( Workout.fromJSON(json.decode(element)));
    });
    
    done = true;
  }
  
  favoriteWorkouts.notifyListeners();
  
  return done;
}