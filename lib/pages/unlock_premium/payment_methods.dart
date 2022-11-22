import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:protennisfitness/constant/constants.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:protennisfitness/elements/CircularLoadingWidget.dart';
import '../../models/payment_method.dart';
import '../../helpers/helper.dart';
import 'success_checkout.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../controllers/user_controller.dart';

import '../../providers/user_repository.dart' as userRepo;
// ignore: must_be_immutable
class PaymentMethodsWidget extends StatefulWidget {
  @override

  String? plan;

  PaymentMethodsWidget(
      {Key? key,
      this.plan})
      : super(key: key);

  _PaymentMethodsWidgetState createState() => _PaymentMethodsWidgetState();
}

class _PaymentMethodsWidgetState extends StateMVC<PaymentMethodsWidget> {

  UserController _con = new UserController();

  _PaymentMethodsWidgetState() : super(UserController()) {
    _con = controller as UserController;
  }

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  bool montly = false, quarterly = false, yearly = false;

  double montlyPrice = 29.99, quarterlyPrice = 49.99, yearlyPrice = 149.99;
  
  @override
  void initState() {

    // TODO GET ALL PAYMENTS METHODS FROM API FOR CURRENT USER
    _con.listenForUserPaymentMethods().whenComplete(() {
      // define first as selected if exists
      // if empty open dialog to create new
      Future.delayed(Duration(milliseconds: 100), () {
        if(_con.methods.isEmpty) _newPaymentMethod();
      });
    });

    if(widget.plan == 'montly') montly = true;
    else if(widget.plan == 'quarterly') quarterly = true;
    else if(widget.plan == 'yearly') yearly = true;

    super.initState();
  }

  successOrderDialog() {
    showDialog(
      context: context,
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
                padding: EdgeInsets.all(fixPadding * 2.0),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/success_gif.gif',
                      width: 70.0,
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Success!",
                      style: grey16SemiBoldTextStyle,
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

    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        Navigator.of(context).pop();
      });
    });
    Future.delayed(const Duration(milliseconds: 2500), () {
      setState(() {
        Navigator.of(context).pop();
      });
    });
  }

  ///ERROR DIALOG
  errorDialog(String message) {
    showDialog(
      context: context,
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
                padding: EdgeInsets.all(fixPadding * 2.0),
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
                      style: grey16SemiBoldTextStyle,
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

    Future.delayed(const Duration(milliseconds: 2500), () {
      setState(() {
        Navigator.of(context).pop();
      });
    });
  }


  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    print("onCreditCardModelChange");
    
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });

  }

  /// SAVE PAYMENT METHOD INFO TO STRIPE
  void _addPaymentMethod(){
    if (formKey.currentState!.validate()) {
      print('valid!');
      OverlayEntry loader = Helper.overlayLoader(context);
      Overlay.of(context)!.insert(loader);

      PaymentMethod _newMethod = new PaymentMethod();
      _newMethod.holderName = cardHolderName;
      _newMethod.number = cardNumber;
      _newMethod.date = expiryDate;
      _newMethod.cvc = cvvCode;


      _con.addNewPaymentMethod(_newMethod).then((value) async {
        
        loader.remove();

        if(value){
          successOrderDialog();

          _con.listenForUserPaymentMethods();
        }else{
          errorDialog("Error, Invalid Card!");
        }
        
      });
      
      

    } else {
      print('invalid!');
    }
  }

  /// CREATE NEW PAYMENT METHOD
  void _newPaymentMethod() {
    print("_newPaymentMethod");
    // OPEN DIALOG TO ADD PAYMENT METHOD
    showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Wrap(
            children: [
              Container(
                padding: EdgeInsets.all(fixPadding),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "New Method",
                            style: black16MediumTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/visacard.png',
                                width: 40.0,
                                fit: BoxFit.fitWidth,
                              ),
                              SizedBox(width: 5.0),
                              Image.asset(
                                'assets/mastercard.png',
                                width: 40.0,
                                fit: BoxFit.fitWidth,
                              ),
                            ],
                          ),
                        ]
                      ),
                    ),
                    /*CreditCardWidget(
                      cardNumber: cardNumber,
                      expiryDate: expiryDate,
                      cardHolderName: cardHolderName,
                      cvvCode: cvvCode,
                      showBackView: isCvvFocused,
                      obscureCardNumber: false,
                      obscureCardCvv: false,
                    ),*/

                    
                    CreditCardForm(
                      formKey: formKey,
                      obscureCvv: true,
                      obscureNumber: false,
                      cardNumber: cardNumber,
                      cvvCode: cvvCode,
                      cardHolderName: cardHolderName,
                      expiryDate: expiryDate,
                      themeColor: Colors.blue,
                      cardNumberDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Card Number',
                        hintText: 'XXXX XXXX XXXX XXXX',
                      ),
                      expiryDateDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Exp. Date',
                        hintText: 'XX/XX',
                      ),
                      cvvCodeDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'CVV',
                        hintText: 'XXX',
                      ),
                      cardHolderDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Card Holder',
                      ),
                      onCreditCardModelChange: onCreditCardModelChange,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            primary: Colors.grey,
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'halter',
                                fontSize: 14,
                                package: 'flutter_credit_card',
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            primary: const Color(0xff1b447b),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            child: const Text(
                              'Add',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'halter',
                                fontSize: 14,
                                package: 'flutter_credit_card',
                              ),
                            ),
                          ),
                          onPressed: () {
                            _addPaymentMethod();
                          },
                        )
                      ],
                    )      
                          
                       
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );

  }

  ///FINISH CHECKOUT PROCCESS
  void _checkout(){

    // implement subscription on payment method
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    // enviar product + payment id
    _con.createUserSubscription(widget.plan!).then((value) {

        loader.remove();

        if(value){
          //UPDATE LOCAL USER
          userRepo.currentUser.value.premium = true;
          userRepo.currentUser.notifyListeners();

          userRepo.updateCurrentUser(userRepo.currentUser.value);

          // GO TO SUCCESS PAGE
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft, 
              child: SuccessCheckoutWidget()
            ),(route) => false
          );
        }else{
          // display error
          errorDialog("Error, failed to create subscription!");
        }
    });

  }

  @override
  Widget build(BuildContext context) {
    
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.0,
        centerTitle: true,
        title: Text(
          'Payment Methods',
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: blackColor,
            ),
            onPressed: () => _newPaymentMethod(),
          ),
        ],
      ),
      bottomNavigationBar: _con.methods.isEmpty ? SizedBox.shrink() : Material(
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
                  (montly)
                          ? '\$$montlyPrice'
                          : (quarterly) ? '\$$quarterlyPrice'
                          : '\$$yearlyPrice',
                  style: black22SemiBoldTextStyle,
                ),
              ),
              InkWell(
                onTap: (){
                  if(_con.selectedMethod != null){
                    _checkout();
                  }else{
                    // DISPLAY DIALOG TO SELECT PAYMENT METHOD
                  }
                  
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
                    'Finish',
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
            height: MediaQuery.of(context).size.height - 70,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _con.listenForUserPaymentMethodsDone == false ? 
                  CircularLoadingWidget( height: 100) :

                  _con.methods.isEmpty ? 
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Please add new Payment Method to continue",
                            maxLines: 4,
                            textAlign: TextAlign.center,
                            style: black26MediumTextStyle,
                          ),
                          InkWell(
                            //onTap: () => successOrderDialog(),
                            onTap: (){
                              _newPaymentMethod();
                            },
                            borderRadius: BorderRadius.circular(15.0),
                            child: Container(
                              width: (width - fixPadding * 6.0) / 2.0,
                              height: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: primaryColor,
                              ),
                              child: Text(
                                'Add new method',
                                style: white16MediumTextStyle,
                              ),
                            ),
                          ),
                          SizedBox.shrink()
                        ],
                      )
                    )
                  )
                  :
                  // LIST OF PAYMENT METHODS
                  Expanded(
                    child: Container(
                      child: ListView.separated(
                        padding: EdgeInsets.all(20),
                        itemCount: _con.methods.length,
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        separatorBuilder: (context, index){
                          return SizedBox(height:10);
                        },
                        itemBuilder: (context, index) {
                          
                          PaymentMethod _currentMethod = _con.methods.elementAt(index);
                          
                          return Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _con.selectedMethod = _currentMethod;
                                  });
                                },
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(fixPadding * 3.0),
                                  decoration: (_con.selectedMethod != null && _con.selectedMethod!.id == _currentMethod.id)
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
                                                _currentMethod.holderName != null ? _currentMethod.holderName! : "'empty'",
                                                style: black22SemiBoldTextStyle,
                                              ),
                                              height5Space,
                                              Text(
                                                "XXXX XXXX XXXX " + _currentMethod.last4Digits!,
                                                style: black14SemiBoldTextStyle,
                                              ),
                                              height5Space,
                                              Text(
                                                _currentMethod.date!,
                                                style: grey14MediumTextStyle,
                                              )
                                            ],
                                          ),
                                          // Text(
                                          //   '\$$montlyPrice',
                                          //   style: (montly)
                                          //       ? primaryColor18SemiBoldTextStyle
                                          //       : black18SemiBoldTextStyle,
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              (_con.selectedMethod != null && _con.selectedMethod!.id == _currentMethod.id)
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
                          );
                                
                        }
                      ),
                    ),
                  ),

                ],
              ),
          ),
          
        ],
      ),
    );
  }
}
