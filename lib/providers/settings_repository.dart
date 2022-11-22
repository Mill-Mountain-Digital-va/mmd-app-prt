import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/setting.dart';
import '../models/user_basic.dart';
import '../models/user.dart';

import 'user_repository.dart' as userRepo;
import 'workout_repository.dart' as workoutRepo;

import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';


ValueNotifier<Setting> setting = new ValueNotifier(new Setting());
ValueNotifier<UserBasic> userBasic = new ValueNotifier(new UserBasic());

//FUNCTION TO LOAD INITIAL SETTINGS FOR THE APP


// TO CHECK AND LOAD USER INFO PREVIOUS SAVED ON LOCAL STORAGE IF IS NOT FIRST TIME
Future<bool> loadUserBasicInfo() async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  await workoutRepo.getFavoriteWorkouts();

  if (prefs.containsKey('current_user')) {
    //
    // userRepo.currentUser.value = User.fromJSON(json.decode(prefs.getString('current_user')!));

    User user = User.fromJSON(json.decode(prefs.getString('current_user')!));

    await userRepo.getUserProfile(user);
    // userRepo.currentUser.notifyListeners();

    return true;
  } else {

    // userBasic.value = UserBasic.fromJSON({});
    return false;
  }

  // if (prefs.containsKey('user_basic')) {
  //   userBasic.value = UserBasic.fromJSON(json.decode(prefs.getString('user_basic')));
  //   return true;
  // } else {

  //   userBasic.value = UserBasic.fromJSON({});
  //   return false;
  // }

    // current_user
}

/// RETURN IF USER IS PREMIUM
bool isPremium() {
  return userRepo.currentUser.value.premium;
}

/***
 * APPLE IN APP PURCHASES
 */

final InAppPurchase _inAppPurchase = InAppPurchase.instance;
late StreamSubscription<List<PurchaseDetails>> _subscription;
List<String> _notFoundIds = <String>[];
List<ProductDetails> _products = <ProductDetails>[];
List<PurchaseDetails> _purchases = <PurchaseDetails>[];
List<String> _consumables = <String>[];
bool _isAvailable = false;
bool _purchasePending = false;
bool _loading = true;
String? _queryProductError;
  
/// LOAD SUBSCRIPTIONS FORM APPLE AND STATUS
void loadAppleSubscriptions() {
  
}