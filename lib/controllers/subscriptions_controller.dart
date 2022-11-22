// import 'dart:async';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
// import '../models/route_argument.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

import 'package:page_transition/page_transition.dart';
import 'package:protennisfitness/models/requests/apple_payment.dart';
import '../pages/unlock_premium/success_checkout.dart';

import '../../providers/user_repository.dart' as userRepo;
import '../providers/settings_repository.dart' as settingsRepo;
import '../providers/consumable_store.dart';
// import '../helpers/helper.dart';
//import '../../generated/l10n.dart';


const String _yearlySubscriptionId = 'pro_tennis_yearly';
const String _quarterlySubscriptionId = 'pro_tennis_quarterly';
const String _monthlySubscriptionId = 'pro_tennis_monthly';

class SubscriptionsController extends ControllerMVC {
  ValueNotifier<Map<String, double>> progress = new ValueNotifier(new Map());

  GlobalKey<ScaffoldState>? scaffoldKey;

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

  BuildContext? context;

  // String _kConsumableId = 'consumable';
  // String _kUpgradeId = 'upgrade';
  // String _kSilverSubscriptionId = 'subscription_silver';
  // String _kGoldSubscriptionId = 'subscription_gold';

  List<String> _kProductIds = <String>[
    _yearlySubscriptionId,
    _quarterlySubscriptionId,
    _monthlySubscriptionId
  ];

  SubscriptionsController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  @override
  void initState() {

    final Stream<List<PurchaseDetails>> purchaseUpdated = _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      // handle error here.
    });

    initStoreInfo();
    
    super.initState();
  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition = _inAppPurchase.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
    super.dispose();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = <ProductDetails>[];
        _purchases = <PurchaseDetails>[];
        _notFoundIds = <String>[];
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition = _inAppPurchase.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    final ProductDetailsResponse productDetailResponse = await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    
    print(productDetailResponse.productDetails.length);

    Future.delayed(Duration(seconds: 2), (){

      loadAppleProducts();
    });
    
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = consumables;
      _purchasePending = false;
      _loading = false;
    });


  }

  void loadAppleProducts() {
    if (_loading) {
      print('Fetching products...');
    }
    if (!_isAvailable) {
      print('NOT AVAILABLE products...');
    }

    
    if (_notFoundIds.isNotEmpty) {
      print("NOT FOUND");
      print('This app needs special configuration to run. Please see example/README.md for instructions.');
      
     print('[${_notFoundIds.join(", ")}] not found');
     print('This app needs special configuration to run. Please see example/README.md for instructions.');
    }

    // This loading previous purchases code is just a demo. Please do not use this as it is.
    // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
    // We recommend that you use your own server to verify the purchase data.

    // final Map<String, PurchaseDetails> purchases = Map<String, PurchaseDetails>.fromEntries( _purchases.map((PurchaseDetails purchase) {
    //   if (purchase.pendingCompletePurchase) {
    //     _inAppPurchase.completePurchase(purchase);
    //   }

    //   return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    // }));
    
    _products.forEach(
      (ProductDetails productDetails) {

        print(productDetails.currencyCode);
        print(productDetails.currencySymbol);
        print(productDetails.id);
        print(productDetails.price);
        print(productDetails.rawPrice);
        print(productDetails.title);
                  // onPressed: () {
                  //   late PurchaseParam purchaseParam;

                  //     purchaseParam = PurchaseParam(
                  //       productDetails: productDetails,
                  //     );

                  //     _inAppPurchase.buyNonConsumable( purchaseParam: purchaseParam );
                  // },
                
        
      });
  }

  /// SUBSCRIBE PLAN
  void subscribe(String plan){

    late PurchaseParam purchaseParam;

    purchaseParam = PurchaseParam(
      productDetails: _products.firstWhere((element) => element.id == plan),
      applicationUserName: userRepo.currentUser.value.email
    );

    _inAppPurchase.buyNonConsumable( purchaseParam: purchaseParam );

  }  




  // Card loadAppleProducts(BuildContext context) {
  //   if (_loading) {
  //     print('Fetching products...');
  //   }
  //   if (!_isAvailable) {
  //     print('NOT AVAILABLE products...');
  //   }
  //   const ListTile productHeader = ListTile(title: Text('Products for Sale'));

  //   final List<ListTile> productList = <ListTile>[];
    
  //   if (_notFoundIds.isNotEmpty) {
  //     print("NOT FOUND");
  //     print('This app needs special configuration to run. Please see example/README.md for instructions.');
      
  //     productList.add(ListTile(
  //         title: Text('[${_notFoundIds.join(", ")}] not found',
  //             style: TextStyle(color: ThemeData.light().errorColor)),
  //         subtitle: const Text(
  //             'This app needs special configuration to run. Please see example/README.md for instructions.')));
  //   }

  //   // This loading previous purchases code is just a demo. Please do not use this as it is.
  //   // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
  //   // We recommend that you use your own server to verify the purchase data.

  //   final Map<String, PurchaseDetails> purchases = Map<String, PurchaseDetails>.fromEntries( _purchases.map((PurchaseDetails purchase) {
  //     if (purchase.pendingCompletePurchase) {
  //       _inAppPurchase.completePurchase(purchase);
  //     }

  //     return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
  //   }));
    
  //   productList.addAll(_products.map(
  //     (ProductDetails productDetails) {
  //       final PurchaseDetails? previousPurchase = purchases[productDetails.id];

  //       print(previousPurchase);
  //       print(productDetails.currencyCode);
  //       print(productDetails.currencySymbol);
  //       print(productDetails.id);
  //       print(productDetails.price);
  //       print(productDetails.rawPrice);
  //       print(productDetails.title);

  //       return ListTile(
  //         title: Text(
  //           productDetails.title,
  //           style: TextStyle(color: Colors.black),
  //         ),
  //         subtitle: Text(
  //           productDetails.description,
  //           style: TextStyle(color: Colors.black),
  //         ),
  //         trailing: previousPurchase != null
  //             ? IconButton(
  //                 onPressed: () => confirmPriceChange(context),
  //                 icon: const Icon(Icons.upgrade))
  //             : TextButton(
  //                 style: TextButton.styleFrom(
  //                   backgroundColor: Colors.green[100],
  //                   // TODO(darrenaustin): Migrate to new API once it lands in stable: https://github.com/flutter/flutter/issues/105724
  //                   // ignore: deprecated_member_use
  //                   primary: Colors.white,
  //                 ),
  //                 onPressed: () {
  //                   late PurchaseParam purchaseParam;

  //                   // if (Platform.isAndroid) {
  //                   //   // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
  //                   //   // verify the latest status of you your subscription by using server side receipt validation
  //                   //   // and update the UI accordingly. The subscription purchase status shown
  //                   //   // inside the app may not be accurate.
  //                   //   final GooglePlayPurchaseDetails? oldSubscription =
  //                   //       _getOldSubscription(productDetails, purchases);

  //                   //   purchaseParam = GooglePlayPurchaseParam(
  //                   //       productDetails: productDetails,
  //                   //       changeSubscriptionParam: (oldSubscription != null)
  //                   //           ? ChangeSubscriptionParam(
  //                   //               oldPurchaseDetails: oldSubscription,
  //                   //               prorationMode:
  //                   //                   ProrationMode.immediateWithTimeProration,
  //                   //             )
  //                   //           : null);
  //                   // } else {
  //                     purchaseParam = PurchaseParam(
  //                       productDetails: productDetails,
  //                     );
  //                   // }

  //                   // if (productDetails.id == _kConsumableId) {
  //                   //   _inAppPurchase.buyConsumable(
  //                   //       purchaseParam: purchaseParam,
  //                   //       autoConsume: _kAutoConsume);
  //                   // } else {
  //                     _inAppPurchase.buyNonConsumable( purchaseParam: purchaseParam );
  //                   // }
  //                 },
  //                 child: Text(productDetails.price),
  //               ),
  //       );
  //     },
  //   ));

  //   return Card(
  //       child: Column(
  //           children: <Widget>[ const Divider()] + productList));
  // }

  Future<void> confirmPriceChange(BuildContext context) async {
    // if (Platform.isAndroid) {
    //   final InAppPurchaseAndroidPlatformAddition androidAddition =
    //       _inAppPurchase
    //           .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
    //   final BillingResultWrapper priceChangeConfirmationResult =
    //       await androidAddition.launchPriceChangeConfirmationFlow(
    //     sku: 'purchaseId',
    //   );
    //   if (priceChangeConfirmationResult.responseCode == BillingResponse.ok) {
    //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //       content: Text('Price change accepted'),
    //     ));
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text(
    //         priceChangeConfirmationResult.debugMessage ??
    //             'Price change failed with code ${priceChangeConfirmationResult.responseCode}',
    //       ),
    //     ));
    //   }
    // }
    // if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iapStoreKitPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iapStoreKitPlatformAddition.showPriceConsentIfNeeded();
    // }
  }


  void showPendingUI() {
    print("showPendingUI");
    setState(() {
      _purchasePending = true;
    });
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    print("deliverProduct");
    print(purchaseDetails.error);
    print(purchaseDetails.productID);
    print(purchaseDetails.purchaseID);
    print(purchaseDetails.status);
    print(purchaseDetails.verificationData.serverVerificationData);
    print(purchaseDetails.verificationData.source);
    print(purchaseDetails.transactionDate);
    // IMPORTANT!! Always verify purchase details before delivering the product.
    // if (purchaseDetails.productID == _kConsumableId) {
    //   await ConsumableStore.save(purchaseDetails.purchaseID!);
    //   final List<String> consumables = await ConsumableStore.load();
    //   setState(() {
    //     _purchasePending = false;
    //     _consumables = consumables;
    //   });
    // } else {
      setState(() {
        _purchases.add(purchaseDetails);
        _purchasePending = false;
      });
    // }

    // pass received values to 
    ApplePaymentRequest _request = new ApplePaymentRequest();

    _request.purchaseId = purchaseDetails.purchaseID;
    _request.productId = purchaseDetails.productID;
    _request.purchaseStatus = purchaseDetails.status.name;
    _request.serverData = purchaseDetails.verificationData.serverVerificationData.toString();
    _request.source = purchaseDetails.verificationData.source;
    _request.transactionDate = purchaseDetails.transactionDate;

    // save receipt values on database
    bool _result = await userRepo.appleSubscriptionPayment(_request);

    if(purchaseDetails.status == PurchaseStatus.purchased && _result == true){

      userRepo.currentUser.value.premium = true;
      userRepo.currentUser.notifyListeners();

      userRepo.updateCurrentUser(userRepo.currentUser.value);

      // GO TO SUCCESS PAGE
      Navigator.pushAndRemoveUntil(
        context!,
        PageTransition(
          type: PageTransitionType.rightToLeft, 
          child: SuccessCheckoutWidget()
        ),(route) => false
      );

    }else{
      // display error dialog


      errorDialog("Error, failed to create subscription!");
    }
 
    // send information to server

  }

  ///ERROR DIALOG
  errorDialog(String message) {
    showDialog(
      context: context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Wrap(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.close,
                      size: 70.0,
                      color: Colors.red,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      message,
                      // style: grey16SemiBoldTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );

    // Future.delayed(const Duration(milliseconds: 2500), () {
    //   setState(() {
    //     Navigator.of(context).pop();
    //     Navigator.of(context).pop();
    //   });
    // });
  }

  void handleError(IAPError error) {
    print(error.code);
    print(error.details);
    print(error.message);

    errorDialog(error.message);

    setState(() {
      _purchasePending = false;
    });
  }

  /// CALL API SERVICE TO VALIDATE RECEIPT DETAILS
  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  Future<void> _listenToPurchaseUpdated( List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      print(purchaseDetails.status);

      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased || purchaseDetails.status == PurchaseStatus.restored) {

          final bool valid = await _verifyPurchase(purchaseDetails);

          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }

        }
        // if (Platform.isAndroid) {
        //   if (!_kAutoConsume && purchaseDetails.productID == _kConsumableId) {
        //     final InAppPurchaseAndroidPlatformAddition androidAddition = _inAppPurchase.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();

        //     await androidAddition.consumePurchase(purchaseDetails);
        //   }
        // }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  

  Future<void> restoreApplePurchases( ) async {

    await _inAppPurchase.restorePurchases(applicationUserName: userRepo.currentUser.value.email);

  }

}
/// Example implementation of the
/// [`SKPaymentQueueDelegate`](https://developer.apple.com/documentation/storekit/skpaymentqueuedelegate?language=objc).
///
/// The payment queue delegate can be implementated to provide information
/// needed to complete transactions.
class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
