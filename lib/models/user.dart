import 'payment_method.dart';
import 'user_basic.dart';

class User {
  String? id;
  String? username;
  String? name;
  String? email;
  String? password;
  String? confirmationPassword;
  String? apiToken;
  String? deviceToken;
  String? phone;
  String? address;
  // Media image;
  List<String>? roles;

  List<PaymentMethod> paymentMethods = [];

  String? image;

  String? stripeId;

  // used for indicate if client logged in or not
  bool? auth;

  UserBasic? basic;

  bool premium = false;

//  String role;

  User();

  User.fromJSON(Map<String, dynamic> jsonMap) {
    try {

      id = jsonMap['id'].toString();
      name = jsonMap['full_name'];
      username = jsonMap['username'];
      email = jsonMap['email'];
      apiToken = jsonMap['api_token'];
      deviceToken = jsonMap['device_token'];

      phone = jsonMap['phone'] != null? jsonMap['phone'].toString() : '';
      // fiscalNumber = jsonMap['fiscal_number'] != null? jsonMap['fiscal_number'].toString() : '';
      
      stripeId = jsonMap['stripe_id'] != null? jsonMap['stripe_id'].toString() : '';

      premium = jsonMap['premium'] != null && (jsonMap['premium'].toString() == '1' || jsonMap['premium'] == true ) ? true : false;

      roles = [];
      // driverId = jsonMap['driver_id'] != null && jsonMap['driver_id'] != '' ? jsonMap['driver_id'].toString() : '';

      if(jsonMap['roles'] != null && (jsonMap['roles'] as List).length > 0 ){
        List.from(jsonMap['roles']).forEach((element) {
          roles!.add(element);
        });

      }

      basic = new UserBasic();
      basic!.gender = jsonMap['gender'] != null? jsonMap['gender'].toString() : '';
      basic!.age = jsonMap['age'] != null? jsonMap['age'].toString() : '';
      basic!.height = jsonMap['height'] != null? jsonMap['height'].toString() : '';
      basic!.weight = jsonMap['weight'] != null? jsonMap['weight'].toString() : '';
      basic!.fitnessLevel = jsonMap['fitness_level'] != null? jsonMap['fitness_level'].toString() : '';


      image = jsonMap['image'] != null? jsonMap['image'] : '';

      /*try {
        address = jsonMap['custom_fields']['address']['view'];
      } catch (e) {
        address = "";
      }
      try {
        bio = jsonMap['custom_fields']['bio']['view'];
      } catch (e) {
        bio = "";
      }*/
      // image = jsonMap['media'] != null && (jsonMap['media'] as List).length > 0
      //     ? Media.fromJSON(jsonMap['media'][0])
      //     : new Media();

    //   {
    //     "id": 24,
    //     "uuid": "10e35b16-2960-4b16-b23b-d1faca2abcfb",
    //     "first_name": "Vasco",
    //     "last_name": null,
    //     "email": "vasco@protennisfitness.com",
    //     "username": "vascobatista",
    //     "age": "30",
    //     "height": "170",
    //     "weight": "65",
    //     "fitness_level": "1",
    //     "dob": null,
    //     "phone": null,
    //     "gender": "male",
    //     "address": null,
    //     "city": null,
    //     "pincode": null,
    //     "state": null,
    //     "country": null,
    //     "avatar_type": "gravatar",
    //     "avatar_location": null,
    //     "password_changed_at": null,
    //     "active": true,
    //     "confirmation_code": null,
    //     "confirmed": true,
    //     "timezone": null,
    //     "last_login_at": null,
    //     "last_login_ip": null,
    //     "created_at": "2021-07-18T10:17:50.000000Z",
    //     "updated_at": "2021-07-18T10:17:50.000000Z",
    //     "deleted_at": null,
    //     "stripe_id": null,
    //     "card_brand": null,
    //     "card_last_four": null,
    //     "trial_ends_at": null,
    //     "api_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiM2M5YWJmZTZkMThmNGQ2MTM2Mjg5MDAzZTI0ZTVlMGJiNmQ1NWE0MzcxMzYxNmNjZGE1MTUzYzdlZWNmMTU4ODU1ZmZhOWI3ZDMxYWQwODEiLCJpYXQiOiIxNjI5MDQ1NjU2LjUxODk2NCIsIm5iZiI6IjE2MjkwNDU2NTYuNTE4OTcwIiwiZXhwIjoiMTY2MDU4MTY1Ni41MTA4NDciLCJzdWIiOiIyNCIsInNjb3BlcyI6W119.X7phTdCvEWVIXoyh7PrDfijdg3PDY4LZz3jtVNpFymYLGqEtWSH6GuILzrwbvOGWDFf9s8L_XB8iyByWt2LckPlwC1F0QMqiSYHeF9wlAdabEJqzaN1g6uQBWEACjrGZd2adwl2QtYpTximW3Fu36BEmbcRP-vev8wYzTyf5XRgp44eloDBnh6XZ9UJu8f0cQI4EyNrTWaNG8bV1_BadwdTsMoyQg_Mv3IBe_csn0Ea4Wy-bMLR6HyWQPJcBhkALbisigbJlhJqorEnY6nJKmlQxcu8YR00AkdkGTK_M9-B8gfuHvn_cRqNzcgCrlxMvUAgJetG1jnjyQ_J5gMGiyCYnjfgYWIt85Nhhs7m39PqRVAfMWvjas2r6iWIZIfI7X5RA9t_N2yQPIDL0EU3gcHtNJ1wRjw0PmgJPaSf1BVnP0C3T9JIg_M7wKBFFAOqgC3Y2CXAZADRBxWGyzlRnb3NukqnVX3t9TNDNMrmHuzNdqGqj-gEY6mwi3VZRuIFsUNYJmiqF3xLp94-_rRoxYMOfjHHwWp1tBf4YuiLt58krkEgLCKqp_ED8z7h4dZRpD0YLR5rsz3WTiXLfa7IqSHvVFgCM2Xye6n_gObVRkVGVo0V-qZjhxjdsTnlNKaK_LcN3uhS9TJ25i0HiMF0SA7VLd2hNACiS7o74-CMgrXQ",
    //     "expires_at": "2022-08-15 16:40:56",
    //     "full_name": "Vasco",
    //     "image": "https://www.gravatar.com/avatar/3d410d163e86a3870b86934b78cf3ae8.jpg?s=80&d=mm&r=g"
    // }

    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["full_name"] = name;
    map["username"] = username;
    map["stripe_id"] = stripeId;
    //map["password"] = password;

    map["api_token"] = apiToken;
    map["device_token"] = deviceToken;

    if (deviceToken != null) {
      map["device_token"] = deviceToken;
    }

    map["phone"] = phone;
    map["premium"] = premium;

    if(basic != null){
      map['gender'] = basic!.gender;
      map['age'] = basic!.age;
      map['height'] = basic!.height;
      map['weight'] = basic!.weight;
      map['fitness_level'] = basic!.fitnessLevel;
    }
    

    map['image'] = image;

    return map;
  }

  Map toLogin() {
    var map = new Map<String, dynamic>();
    map["email"] = email;
    map["password"] = password;
    return map;
  }

  /*@override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }*/
}
