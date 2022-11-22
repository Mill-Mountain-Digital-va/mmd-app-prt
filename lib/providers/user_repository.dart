import 'dart:convert';
import 'dart:io';

import 'package:protennisfitness/models/requests/apple_payment.dart';

import '../models/payment_method.dart';

import '../models/user_basic.dart';
import 'package:flutter/cupertino.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/helper.dart';
import '../models/user.dart';
import '../models/route_argument.dart';

ValueNotifier<User> currentUser = new ValueNotifier(User());

RouteArgument? redirectRouteArgument;
String? redirectPage;

Future<User> login(User user) async {
  final String url = '${GlobalConfiguration().getValue('api_base_url')}login';
  final client = new http.Client();

  print(url);
  print(json.encode(user.toLogin()));

  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toLogin()),
  );
  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  }
  return currentUser.value;
}


/// LOGOUT
Future<void> logout() async {
  currentUser.value = new User();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user');
}

/// DELETE USER ACCOUNT
Future<void> delete() async {

  final client = new http.Client();

  final String url = '${GlobalConfiguration().getValue('api_base_url')}deleteAccount';
  // print(json.encode(user.toMap()));

  String _token = currentUser.value.apiToken!;
  final response = await client.post(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json', 
      'Authorization': 'Bearer $_token'
    },
    // body: json.encode(user.toMap()),
  );

  bool result = false;

  if (response.statusCode == 200) {
    // verificar return do serviço
    result = true;
  }

  print(result);

  // delete local values
  currentUser.value = new User();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user');
}

Future<User> register(User user, UserBasic userBasic) async {
  final String url = '${GlobalConfiguration().getValue('api_base_url')}register';
  final client = new http.Client();

  user.basic = userBasic;

  Map params = user.toMap();

  //params.addAll(userBasic.toMap());
  
  print(params);

  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(params),
  );

  print(response.statusCode);
  if (response.statusCode == 201) {
    print(response.body);

    setCurrentUser(response.body);
    // print(json.decode(response.body)['data']);
    currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    // currentUser.value.apiToken = json.decode(response.body)['access_token'];
  }
  return currentUser.value;
}

Future<bool> resetPassword(User user) async {
  final String url = '${GlobalConfiguration().getValue('api_base_url')}send_reset_link_email';
  final client = new http.Client();

  print(url);
  print(json.encode(user.toMap()));

  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );
  if (response.statusCode == 200) {
    print(json.decode(response.body)['data']);
    return true;
  } else {
    return false;
  }
}



void setCurrentUser(jsonString) async {
  if (json.decode(jsonString)['data'] != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('current_user', json.encode(json.decode(jsonString)['data']));
  }

}


/// update user saved on SharedPrefs
void updateCurrentUser(User user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString('current_user', json.encode(user.toMap()));
}

// Future<void> setCreditCard(CreditCard creditCard) async {
//   if (creditCard != null) {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('credit_card', json.encode(creditCard.toMap()));
//   }
// }

Future<User> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.clear();
  if (currentUser.value.auth == null && prefs.containsKey('current_user')) {
    currentUser.value = User.fromJSON(json.decode(prefs.get('current_user').toString() ));
    currentUser.value.auth = true;
  } else {
    currentUser.value.auth = false;
  }
  currentUser.notifyListeners();
  return currentUser.value;
}

// Future<CreditCard> getCreditCard() async {
//   CreditCard _creditCard = new CreditCard();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey('credit_card')) {
//     _creditCard = CreditCard.fromJSON(json.decode(await prefs.get('credit_card')));
//   }
//   return _creditCard;
// }

Future<User> update(User user) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  final String url = '${GlobalConfiguration().getValue('api_base_url')}users/${currentUser.value.id}?$_apiToken';
  final client = new http.Client();

  print(url);
  print(json.encode(user.toMap()));

  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );

  setCurrentUser(response.body);
  currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  return currentUser.value;
}

// Future<Stream<Address>> getAddresses() async {
//   User _user = currentUser.value;
//   final String _apiToken = 'api_token=${_user.apiToken}&';
//   final String url =
//       '${GlobalConfiguration().getValue('api_base_url')}delivery_addresses?$_apiToken&search=user_id:${_user.id}&searchFields=user_id:=&orderBy=updated_at&sortedBy=desc';
//   print(url);
//   final client = new http.Client();
//   final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

//   return streamedRest.stream
//       .transform(utf8.decoder)
//       .transform(json.decoder)
//       .map((data) => Helper.getData(data))
//       .expand((data) => (data as List))
//       .map((data) {
//     return Address.fromJSON(data);
//   });
// }

// Future<Address> addAddress(Address address) async {
//   User _user = userRepo.currentUser.value;
//   final String _apiToken = 'api_token=${_user.apiToken}';
//   address.userId = _user.id;
//   final String url = '${GlobalConfiguration().getValue('api_base_url')}delivery_addresses?$_apiToken';
//   final client = new http.Client();
//   final response = await client.post(
//     url,
//     headers: {HttpHeaders.contentTypeHeader: 'application/json'},
//     body: json.encode(address.toMap()),
//   );
//   return Address.fromJSON(json.decode(response.body)['data']);
// }

// Future<Address> updateAddress(Address address) async {
//   User _user = userRepo.currentUser.value;
//   final String _apiToken = 'api_token=${_user.apiToken}';
//   address.userId = _user.id;
//   final String url = '${GlobalConfiguration().getValue('api_base_url')}delivery_addresses/${address.id}?$_apiToken';
//   final client = new http.Client();
//   final response = await client.put(
//     url,
//     headers: {HttpHeaders.contentTypeHeader: 'application/json'},
//     body: json.encode(address.toMap()),
//   );
//   return Address.fromJSON(json.decode(response.body)['data']);
// }

// Future<Address> removeDeliveryAddress(Address address) async {
//   User _user = userRepo.currentUser.value;
//   final String _apiToken = 'api_token=${_user.apiToken}';
//   final String url = '${GlobalConfiguration().getValue('api_base_url')}delivery_addresses/${address.id}?$_apiToken';
//   final client = new http.Client();
//   final response = await client.delete(
//     url,
//     headers: {HttpHeaders.contentTypeHeader: 'application/json'},
//   );
//   return Address.fromJSON(json.decode(response.body)['data']);
// }

Future<User> getUserProfile(User _user) async {

  // User _user = currentUser.value;
  final String _apiToken = 'api_token=${_user.apiToken}';
  final String url = '${GlobalConfiguration().getValue('api_base_url')}user?$_apiToken';
  final client = new http.Client();
  print(url);
  print(_apiToken);
  
  // final response = await client.get(
  //   Uri.parse(url),
  //   headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  // );
  final response = await client.post(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json', 
      'Authorization': 'Bearer ${_user.apiToken}'
    },
    // body: json.encode(_user.apiToken.toStripe()),
  );

    print(response.statusCode);
  if (response.statusCode == 200) {
    print(response.body);
    setCurrentUser(response.body);
    currentUser.value = User.fromJSON(json.decode(response.body)['result']['data']);
  }

  return currentUser.value;
}

Future<bool> addUserPaymentMethod(PaymentMethod method) async {
  final String url = '${GlobalConfiguration().getValue('api_base_url')}add_payment_method';
  final client = new http.Client();

  print(url);
  print(json.encode(method.toStripe()));

  String _token = currentUser.value.apiToken!;
  print(_token);

  final response = await client.post(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json', 
      'Authorization': 'Bearer $_token'
    },
    body: json.encode(method.toStripe()),
  );

  bool result = false;

  if (response.statusCode == 200) {
    // setCurrentUser(response.body);
    // currentUser.value = User.fromJSON(json.decode(response.body)['data']);

    // verificar return do serviço
    result = true;
  }
  return result;
  
}

Future<bool> createSubscription(String method, String plan ) async {

  final String url = '${GlobalConfiguration().getValue('api_base_url')}add_subscription';
  final client = new http.Client();

  print(url);

  String _token = currentUser.value.apiToken!;

  Map<String, dynamic> _queryParams = {};
  _queryParams['payment'] = method;
  _queryParams['plan'] = plan;

  final response = await client.post(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json', 
      'Authorization': 'Bearer $_token'
    },
    body: json.encode(_queryParams),
  );

  bool result = false;

  if (response.statusCode == 200) {
    // verificar return do serviço
    result = true;
  }
  return result;
  
}

///GET LIST OF ALL AVAILABLE CATEGORIES OF WORKOUTS
Future<Stream<PaymentMethod>> getPaymentMethods( ) async {
  final String url = '${GlobalConfiguration().getValue('api_base_url')}user_payment_methods';
  print(url);

  Uri uri = Uri.parse(url);
  Map<String, dynamic> _queryParams = {};
  uri = uri.replace(queryParameters: _queryParams);

  String _token = currentUser.value.apiToken!;
  
  final client = new http.Client();

  final request = http.Request('get', uri);
  request.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });

  final streamedRest = await client.send( request );

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)

      .map((data) => Helper.getData(data as Map<String, dynamic>))
      
      .expand((data) => (data as List))
      .map((data) {
        print(data);
    return PaymentMethod.fromJSON(data);
  });
}

///SAVE APPLE PAYMENT RECEIPT INFORMATION
Future<bool> appleSubscriptionPayment(ApplePaymentRequest _request) async {

  final String url = '${GlobalConfiguration().getValue('api_base_url')}apple_subscription';
  final client = new http.Client();

  print(url);
  print(json.encode(_request.toRequest()));

  String _token = currentUser.value.apiToken!;

  final response = await client.post(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json', 
      'Authorization': 'Bearer $_token'
    },
    body: json.encode(_request.toRequest()),
  );

  bool result = false;

  if (response.statusCode == 200) {
    // verificar return do serviço
    result = true;
  }


  return result;
  
}