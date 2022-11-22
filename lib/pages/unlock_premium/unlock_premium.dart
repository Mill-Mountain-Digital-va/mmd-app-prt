import 'package:protennisfitness/constant/constants.dart';
import 'package:protennisfitness/pages/unlock_premium/checkout.dart';
// import 'package:protennisfitness/screens.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import '../../providers/payment-service.dart';
// import 'package:stripe_payment/stripe_payment.dart';
import 'package:page_transition/page_transition.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../../controllers/subscriptions_controller.dart';
import 'package:pay_ios/pay_ios.dart';
// import 'payment_methods.dart';


class UnlockPremium extends StatefulWidget {
  @override
  _UnlockPremiumState createState() => _UnlockPremiumState();
}

class _UnlockPremiumState extends StateMVC<UnlockPremium> {

  SubscriptionsController _con = new SubscriptionsController();

  _UnlockPremiumState() : super(SubscriptionsController()) {
    _con = controller as SubscriptionsController;
  }


  bool free = false, montly = false, quarterly = false, yearly = true;

  double freePrice = 0.0, montlyPrice = 29.99, quarterlyPrice = 49.99, yearlyPrice = 149.99;
  
  @override
  void initState() {
    // Stripe.publishableKey = "pk_test_51JPXKnGw17JvxF7qtLTQqQJQHyFkcO3NdW2m2gtFhR5UM9ekIUC3tI7K2M8STPokVsDnF19otw0k1W557ealfdd8009yTkxXxI";
    // StripePayment.setOptions(
    //   StripeOptions(        
    //      publishableKey:"pk_test_51JPXKnGw17JvxF7qtLTQqQJQHyFkcO3NdW2m2gtFhR5UM9ekIUC3tI7K2M8STPokVsDnF19otw0k1W557ealfdd8009yTkxXxI",
    //       merchantId: "YOUR_MERCHANT_ID",
    //       androidPayMode: 'test'
    //   ));

    super.initState();
  }

  /// GO TO PAGE WITH PAYMENT METHODS - Cards
  void _subscribeCard() async {

    String plan = "montly";

    if(free == true) Navigator.of(context).pop();
    else{

      if(quarterly == true) plan = "quarterly";
      else if(yearly == true) plan = "yearly";

    // IF PAY WITH CARD -- STRIPE
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft, 
          child: CheckoutWidget(
            plan: plan
          )
        )
      );
    }

  }

  /// CHECKOUT PAYMENT WITH APPLE IN APP PURCHASE
  void _subscribeApple() async {

    String plan = "pro_tennis_monthly";

    if(quarterly == true) plan = "pro_tennis_quarterly";
    else if(yearly == true) plan = "pro_tennis_yearly";

    _con.subscribe(plan);
  }

  /// OPEN DIALOG TO SELECT PAYMENT METHOD
  void _subscribe() async {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Wrap(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Please select your payment method",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: black16MediumTextStyle,
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Container(
                      width: (width / 2),
                      height: 60,
                      child: RawApplePayButton(
                        style: ApplePayButtonStyle.black,
                        type: ApplePayButtonType.subscribe,
                        onPressed: (){ 

                          Navigator.of(context).pop();
                          _subscribeApple();
                        }
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        _subscribeCard();
                      },
                      child: Container(
                        width: (width / 2),
                      height: 60,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: Text(
                          'Subscribe with\nCredit Card',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: whiteColor,
                          )
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    _con.context = context;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.0,
        centerTitle: true,
        title: Text(
          'Premium Subscription',
          style: appBarTextStyle,
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: blackColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 2.0,
        child: Container(
          width: width,
          height: 80.0,
          padding: EdgeInsets.fromLTRB(fixPadding * 2.0, fixPadding * 1.3,
              fixPadding * 2.0, fixPadding * 1.3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: (width - fixPadding * 6.0) / 2.0,
                alignment: Alignment.center,
                child: Text(
                  (free) ? '\$$freePrice'
                      : (montly)
                          ? '\$$montlyPrice'
                          : (quarterly) ? '\$$quarterlyPrice'
                          : '\$$yearlyPrice',
                  style: black22SemiBoldTextStyle,
                ),
              ),
              InkWell(
                //onTap: () => successOrderDialog(),
                onTap: (){
                  // _subscribe();
                  _subscribeApple();
                  // _con.loadAppleProducts();
                },
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  width: (width - fixPadding * 6.0) / 2.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: primaryColor,
                  ),
                  child: Text(
                    'Subscribe',
                    style: white16MediumTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            padding: EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // _con.loadAppleProducts(context),

                // Free Start
                // Stack(
                //   children: [
                //     InkWell(
                //       onTap: () {
                //         if (!free) {
                //           setState(() {
                //             free = true;
                //             montly = false;
                //             quarterly = false;
                //             yearly = false;
                //           });
                //         }
                //       },
                //       borderRadius: BorderRadius.circular(20.0),
                //       child: Container(
                //         width: double.infinity,
                //         padding: EdgeInsets.all(fixPadding * 3.0),
                //         decoration: (free)
                //             ? BoxDecoration(
                //                 borderRadius: BorderRadius.circular(20.0),
                //                 color: whiteColor,
                //                 boxShadow: <BoxShadow>[
                //                   BoxShadow(
                //                     blurRadius: 5.0,
                //                     spreadRadius: 5.0,
                //                     color: lightGreyColor!,
                //                   ),
                //                 ],
                //               )
                //             : BoxDecoration(
                //                 borderRadius: BorderRadius.circular(20.0),
                //                 color: whiteColor,
                //               ),
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.start,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //               children: [
                //                 Column(
                //                   mainAxisAlignment: MainAxisAlignment.start,
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Text(
                //                       'Free Trial',
                //                       style: black22SemiBoldTextStyle,
                //                     ),
                //                     height5Space,
                //                   ],
                //                 ),
                //                 Text(
                //                   '\$$freePrice',
                //                   style: (free)
                //                       ? primaryColor18SemiBoldTextStyle
                //                       : black18SemiBoldTextStyle,
                //                 ),
                //               ],
                //             ),
                //             (free) ? heightSpace : SizedBox(height: 0.0),
                //             (free)
                //                 ? Text(
                //                     'Access to all content: All workout, all health tips and chat with trainer.',
                //                     style: black16MediumTextStyle,
                //                   )
                //                 : Container(),
                //           ],
                //         ),
                //       ),
                //     ),
                //     (free)
                //         ? Positioned(
                //             bottom: 0.0,
                //             right: 0.0,
                //             child: Container(
                //               width: 40.0,
                //               height: 40.0,
                //               alignment: Alignment.center,
                //               decoration: BoxDecoration(
                //                 color: primaryColor,
                //                 borderRadius: BorderRadius.only(
                //                   topLeft: Radius.circular(20.0),
                //                   topRight: Radius.circular(0.0),
                //                   bottomRight: Radius.circular(20.0),
                //                 ),
                //               ),
                //               child: Icon(
                //                 Icons.check,
                //                 color: whiteColor,
                //                 size: 20.0,
                //               ),
                //             ),
                //           )
                //         : Container(),
                //   ],
                // ),
                // // Free End
                // heightSpace,
                // heightSpace,
                // Medium Start
                Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        if (!montly) {
                          setState(() {
                            free = false;
                            montly = true;
                            quarterly = false;
                            yearly = false;
                          });
                        }
                      },
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(fixPadding * 3.0),
                        decoration: (montly)
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: whiteColor,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    spreadRadius: 5.0,
                                    color: lightGreyColor!,
                                  ),
                                ],
                              )
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: whiteColor,
                              ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Monthly',
                                      style: black22SemiBoldTextStyle,
                                    ),
                                    height5Space,
                                    Text(
                                      'Monthly Subscription'.toUpperCase(),
                                      style: grey14MediumTextStyle,
                                    )
                                  ],
                                ),
                                Text(
                                  '\$$montlyPrice',
                                  style: (montly)
                                      ? primaryColor18SemiBoldTextStyle
                                      : black18SemiBoldTextStyle,
                                ),
                              ],
                            ),
                            (montly) ? heightSpace : SizedBox(height: 0.0),
                            (montly)
                                ? Text(
                                    'Access to all content: All workout, all health tips and chat with trainer.',
                                    style: black16MediumTextStyle,
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    (montly)
                        ? Positioned(
                            bottom: 0.0,
                            right: 0.0,
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(0.0),
                                  bottomRight: Radius.circular(20.0),
                                ),
                              ),
                              child: Icon(
                                Icons.check,
                                color: whiteColor,
                                size: 20.0,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                // Medium End

                heightSpace,
                heightSpace,
                // Full Start
                Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        if (!quarterly) {
                          setState(() {
                            free = false;
                            montly= false;
                            quarterly = true;
                            yearly = false;
                          });
                        }
                      },
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(fixPadding * 3.0),
                        decoration: (quarterly)
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: whiteColor,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    spreadRadius: 5.0,
                                    color: lightGreyColor!,
                                  ),
                                ],
                              )
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: whiteColor,
                              ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Quarterly',
                                      style: black22SemiBoldTextStyle,
                                    ),
                                    height5Space,
                                    Text(
                                      'Quarterly Subscription'.toUpperCase(),
                                      style: grey14MediumTextStyle,
                                    )
                                  ],
                                ),
                                Text(
                                  '\$$quarterlyPrice',
                                  style: (quarterly)
                                      ? primaryColor18SemiBoldTextStyle
                                      : black18SemiBoldTextStyle,
                                ),
                              ],
                            ),
                            (quarterly) ? heightSpace : SizedBox(height: 0.0),
                            (quarterly)
                                ? Text(
                                    'Access to all content: All workout, all health tips and chat with trainer.',
                                    style: black16MediumTextStyle,
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    (quarterly)
                        ? Positioned(
                            bottom: 0.0,
                            right: 0.0,
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(0.0),
                                  bottomRight: Radius.circular(20.0),
                                ),
                              ),
                              child: Icon(
                                Icons.check,
                                color: whiteColor,
                                size: 20.0,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                // Full End
                heightSpace,
                heightSpace,
                // Yearly Start
                Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        if (!yearly) {
                          setState(() {
                            free = false;
                            montly= false;
                            quarterly = false;
                            yearly = true;
                          });
                        }
                      },
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(fixPadding * 3.0),
                        decoration: (yearly)
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: whiteColor,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    spreadRadius: 5.0,
                                    color: lightGreyColor!,
                                  ),
                                ],
                              )
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: whiteColor,
                              ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Yearly',
                                      style: black22SemiBoldTextStyle,
                                    ),
                                    height5Space,
                                    Text(
                                      'Yearly Subscription'.toUpperCase(),
                                      style: grey14MediumTextStyle,
                                    )
                                  ],
                                ),
                                Text(
                                  '\$$yearlyPrice',
                                  style: (yearly)
                                      ? primaryColor18SemiBoldTextStyle
                                      : black18SemiBoldTextStyle,
                                ),
                              ],
                            ),
                            (yearly) ? heightSpace : SizedBox(height: 0.0),
                            (yearly)
                                ? Text(
                                    'Access to all content: All workout, all health tips and chat with trainer.',
                                    style: black16MediumTextStyle,
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    (yearly)
                        ? Positioned(
                            bottom: 0.0,
                            right: 0.0,
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(0.0),
                                  bottomRight: Radius.circular(20.0),
                                ),
                              ),
                              child: Icon(
                                Icons.check,
                                color: whiteColor,
                                size: 20.0,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                // Yearly End
              ],
            ),
          ),
        ],
      ),
    );
  }
}
