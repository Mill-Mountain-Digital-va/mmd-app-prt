class PaymentMethod {
  String? id;
  String? name;
  String? last4Digits;
  String? number;
  String? date;
  String? cvc;
  String? holderName;

  PaymentMethod();

  PaymentMethod.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      print(jsonMap['id']);
      id = jsonMap['id'];
      name = jsonMap['name'] != null ? jsonMap['name'].toString() : '';

      date = jsonMap['card'] != null ? jsonMap['card']['exp_month'].toString() + "/" + jsonMap['card']['exp_year'].toString() : '';
      last4Digits = jsonMap['card'] != null ? jsonMap['card']['last4'].toString() : '';

      holderName = jsonMap['metadata'] != null && jsonMap['metadata'] != [] ? jsonMap['metadata']['holder_name'] : "";

/*
      {
        "id": "pm_1JWg9sGw17JvxF7qCpfFiYrO",
        "object": "payment_method",
        "billing_details": {
            "address": {
                "city": null,
                "country": null,
                "line1": null,
                "line2": null,
                "postal_code": null,
                "state": null
            },
            "email": null,
            "name": null,
            "phone": null
        },
        "card": {
            "brand": "visa",
            "checks": {
                "address_line1_check": null,
                "address_postal_code_check": null,
                "cvc_check": "pass"
            },
            "country": "US",
            "exp_month": 9,
            "exp_year": 2022,
            "fingerprint": "SEaXYrzUh2CySv4o",
            "funding": "credit",
            "generated_from": null,
            "last4": "4242",
            "networks": {
                "available": [
                    "visa"
                ],
                "preferred": null
            },
            "three_d_secure_usage": {
                "supported": true
            },
            "wallet": null
        },
        "created": 1630928320,
        "customer": "cus_K5ShdKXMOEuyN9",
        "livemode": false,
        "metadata": [],
        "type": "card"
      }*/

    } catch (e) {
      // id = '';
      name = '';
      // slug = '';
      // icon = 'cm';
      // status = '';
      
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    // map["slug"] = slug;
    // map["icon"] = icon;
    // map["status"] = status;
    
    return map;
  }

  /// OPTION USED TO MAP TO ADD TO STRIPE
  Map toStripe() {
    var map = new Map<String, dynamic>();
    //map["id"] = id;
    map["holder_name"] = holderName;
    map["number"] = number;
    map["cvc"] = cvc;
    map["exp_month"] = date!.split("/")[0];
    map["exp_year"] = date!.split("/")[1];
    
    return map;
  }
  
}
