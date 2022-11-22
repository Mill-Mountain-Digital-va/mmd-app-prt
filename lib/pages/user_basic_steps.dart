import 'package:protennisfitness/constant/constants.dart';
// import 'package:protennisfitness/screens.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/user_basic_controller.dart';
// import '../pages/bottom_bar.dart';
import '../screens.dart';

class UserBasicSteps extends StatefulWidget {
  @override
  _UserBasicStepsState createState() => _UserBasicStepsState();
}

class _UserBasicStepsState extends StateMVC<UserBasicSteps> {

  UserBasicController _con = new UserBasicController();

  _UserBasicStepsState() : super(UserBasicController()) {
    _con = controller as UserBasicController;
  }

  //current step of basic info
  double currentStep = 0;
  int totalSteps = 5;

  // HEIGHT
  String heightType = "cm";
  int _currentHeightIntValue = 170;
  /// RANGES TO SELECT HEIGHT IN "CM" AND "IN"
  List<List<int>> heightRanges = [[150,220] , [55, 86]];

  // WEIGHT
  String weightType = "kg";
  int _currentWeightIntValue = 65;
  /// RANGES TO SELECT WEIGHT IN "kg" AND "lbs"
  List<List<int>> weightRanges = [[40,120] , [88, 265]];

  // FITNESS LEVEL
  String _currentFitnessLevel = "";

  int _currentAgeIntValue = 30;

  @override
  void initState() {
    super.initState();

  }

  /// GO TO NEXT STEP
  void _goToNextStep({String step = "", String selected = ""}){
    print(step);

    if(step == "gender"){
      _con.userBasic!.gender = selected;
    }else if(step == "height"){
      _con.userBasic!.height = _currentHeightIntValue.toString();
      _con.userBasic!.heightType = heightType;
    }else if(step == "weight"){
      _con.userBasic!.weight = _currentWeightIntValue.toString();
      _con.userBasic!.weightType = weightType;
    }else if(step == "level"){
      _con.userBasic!.fitnessLevel= _currentFitnessLevel;
    }else if(step == "age"){
      _con.userBasic!.age= _currentAgeIntValue.toString();
    }

    setState(() {
      currentStep ++;
    });
  }

  /// RETURNS THE SELECTED WIDGET STEP
  Widget _getStepWidget(){

    print(currentStep.toStringAsFixed(0));
    dynamic selected;
    switch (currentStep.toStringAsFixed(0)) {
      case "0":
          selected = _genderStep();
        break;
      case "1":
          selected = _ageStep();
        break;
      case "2":
          selected = _heightStep();
        break;
      case "3":
          selected = _weightStep();
        break;
      case "4":
          selected = _fitnessStep();
        break;
      case "5":
          selected = _signUpStep();
        break;
      default:
        selected = SizedBox.shrink();
    }

    return selected;

  }

  /// GOES TO PREVIOUS STEP
  void _backStep(BuildContext context){
    
    if(currentStep.toStringAsFixed(0) == "0") {
      /// go to page login
      Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: Walkthrough()));
    }else{
      setState(() {
        currentStep --;
      });
    }
    
  }
  /// SET FOCUS TO PAGE 
  void setPageFocus() {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() { });
  }

  /// RETURN SIGN UP FORM
  Widget _signUpStep(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // print("ererr");
    // print(MediaQuery.of(context).viewInsets.bottom);

    // TODO NEED TO FIX BOTTOM VIEWINSETS WHEN KEYBORAD IS UP

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SafeArea(
          child: 
          Container(
            width: width,
            height: height * 0.8 - MediaQuery.of(context).viewInsets.bottom,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        width: width,
                        // height: height * 0.8,
                        padding: EdgeInsets.all(fixPadding * 2.0),
                        child: Form(
                          key: _con.signupFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Sign Up',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 25),
                              ),
                              SizedBox(height: 50.0),
                              TextFormField(
                                  // style: TextStyle(color: Theme.of(context).accentColor),
                                  keyboardType: TextInputType.text,
                                  decoration: getInputDecoration(hintText: '', labelText: 'Username'),
                                style: TextStyle(color: Colors.white),
                                  // initialValue: address.description?.isNotEmpty ?? false ? address.description : null,
                                  // validator: (input) => input.trim().length == 0 ? 'Not valid address description' : null,
                                  onSaved: (input) => _con.user!.username = input!,
                                onEditingComplete: () {
                                  setPageFocus();
                                },
                              ),
                              heightSpace,
                              heightSpace,
                              TextFormField(
                                  keyboardType: TextInputType.text,
                                  decoration: getInputDecoration(hintText: '', labelText: 'Full Name'),
                                style: TextStyle(color: Colors.white),
                                  onSaved: (input) => _con.user!.name = input!,
                                onEditingComplete: () {
                                  setPageFocus();
                                },
                              ),
                              heightSpace,
                              heightSpace,
                              TextFormField(
                                keyboardType: TextInputType.text,
                                style: TextStyle(color: Colors.white),
                                decoration: getInputDecoration(hintText: '', labelText: 'Email'),
                                onSaved: (input) => _con.user!.email = input!,
                                onEditingComplete: () {
                                  setPageFocus();
                                },
                              ),
                              heightSpace,
                              heightSpace,
                              TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: getInputDecoration(hintText: '', labelText: 'Password'),
                                style: TextStyle(color: Colors.white),
                                onSaved: (input) => _con.user!.password = input!,
                                obscureText: true,
                                onEditingComplete: () {
                                  setPageFocus();
                                },
                              ),
                              heightSpace,
                              heightSpace,
                              TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: getInputDecoration(hintText: '', labelText: 'Confirm Password'),
                                style: TextStyle(color: Colors.white),
                                onSaved: (input) => _con.user!.confirmationPassword = input!,
                                obscureText: true,
                                onEditingComplete: () {
                                  setPageFocus();
                                },
                              ),
                            ],
                          ),
                        ),                        
                      ),
                    ]
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.all(fixPadding * 2.0),
                //   child: InkWell(
                //     onTap: () {
                //       // Navigator.push(
                //       //     context,
                //       //     PageTransition(
                //       //         type: PageTransitionType.rightToLeft,
                //       //         child: OTPScreen()));
                //     },
                //     borderRadius: BorderRadius.circular(30.0),
                //     child: Container(
                //       width: width - fixPadding * 2.0,
                //       padding: EdgeInsets.all(fixPadding * 2.0),
                //       alignment: Alignment.center,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(30.0),
                //         color: primaryColor,
                //       ),
                //       child: Text(
                //         'Continue',
                //         style: white16MediumTextStyle,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );

  }

  /// RETURN OPTION TO SETUP HEIGHT
  Widget _ageStep(){
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: height * 0.2),
          height: height * 0.5,
          padding: EdgeInsets.all(fixPadding * 0.4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Age',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 25),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NumberPicker(
                    value: _currentAgeIntValue,
                    minValue: 16,
                    maxValue: 99,
                    step: 1,
                    itemHeight: 40,
                    axis: Axis.vertical,
                    onChanged: (value) => setState(() => _currentAgeIntValue = value),
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(16),
                    //   border: Border.all(color: Colors.black26),
                    // ),
                    textStyle: TextStyle(color: Colors.grey, fontSize: 24),
                    selectedTextStyle: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );

  }

  /// RETURN OPTION TO SETUP HEIGHT
  Widget _heightStep(){
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;

    int selectedType = heightType == "cm" ? 0 : 1;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: height * 0.2),
          height: height * 0.5,
          padding: EdgeInsets.all(fixPadding * 0.4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Height',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 25),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.4), blurRadius: 40, offset: Offset(0, 15)),
                        BoxShadow(
                            color: Colors.black.withOpacity(0.4), blurRadius: 13, offset: Offset(0, 3))
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          highlightColor: Colors.transparent,
                          onTap: () {
                            //select type
                            setState(() {
                              heightType = "cm";
                              _currentHeightIntValue = 170;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 80,
                            decoration: BoxDecoration(
                              color: heightType == 'cm' ? Colors.grey : Colors.transparent,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: Text(
                                'cm',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText2!.merge(TextStyle(color: heightType == 'cm' ? Colors.white : Colors.black))
                              ),
                            )
                          )
                        ),
                        InkWell(
                          highlightColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              heightType = 'in';
                              _currentHeightIntValue = 67;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 80,
                            decoration: BoxDecoration(
                              color: heightType == 'in' ? Colors.grey : Colors.transparent,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: Text(
                                "in",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText2!.merge(TextStyle(color: heightType == 'in' ? Colors.white : Colors.black))
                              ),
                            )
                          )
                        )
                      ],
                    )
                  ),
                ],
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NumberPicker(
                    value: _currentHeightIntValue,
                    minValue: heightRanges[selectedType][0],
                    maxValue: heightRanges[selectedType][1],
                    step: 1,
                    itemHeight: 40,
                    axis: Axis.vertical,
                    onChanged: (value) => setState(() => _currentHeightIntValue = value),
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(16),
                    //   border: Border.all(color: Colors.black26),
                    // ),
                    textStyle: TextStyle(color: Colors.grey, fontSize: 24),
                    selectedTextStyle: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ],
              ),
              // SizedBox(height: 30),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     Container(
              //       margin: EdgeInsets.only(top:height-100),
              //       padding: EdgeInsets.all(fixPadding * 2.0),
              //       child: InkWell(
              //         onTap: () {
              //           // GO TO NEXT STEP
              //           _goToNextStep(step: "height", selected: "");
              //         },
              //         borderRadius: BorderRadius.circular(10.0),
              //         child: Container(
              //           width: width - fixPadding * 2.0,
              //           padding: EdgeInsets.all(fixPadding * 2.0),
              //           alignment: Alignment.center,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(30.0),
              //             color: primaryColor,
              //           ),
              //           child: Text(
              //             'Next',
              //             style: white16MediumTextStyle,
              //           ),
              //         ),
              //       ),
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ],
    );
  }

  /// RETURN OPTION TO SETUP WEIGHT
  Widget _weightStep(){
    double height = MediaQuery.of(context).size.height;

    int selectedType = weightType == "kg" ? 0 : 1;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: height * 0.2),
          height: height * 0.5,
          padding: EdgeInsets.all(fixPadding * 0.4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Weight',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 25),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.4), blurRadius: 40, offset: Offset(0, 15)),
                        BoxShadow(
                            color: Colors.black.withOpacity(0.4), blurRadius: 13, offset: Offset(0, 3))
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          highlightColor: Colors.transparent,
                          onTap: () {
                            //select type
                            setState(() {
                              weightType = "kg";
                              _currentWeightIntValue = 65;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 80,
                            decoration: BoxDecoration(
                              color: weightType == 'kg' ? Colors.grey : Colors.transparent,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: Text(
                                'kg',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText2!.merge(TextStyle(color: weightType == 'kg' ? Colors.white : Colors.black))
                              ),
                            )
                          )
                        ),
                        InkWell(
                          highlightColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              weightType = 'lbs';
                              _currentWeightIntValue = 143;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 80,
                            decoration: BoxDecoration(
                              color: weightType == 'lbs' ? Colors.grey : Colors.transparent,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: Text(
                                "lbs",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText2!.merge(TextStyle(color: weightType == 'lbs' ? Colors.white : Colors.black))
                              ),
                            )
                          )
                        )
                      ],
                    )
                  ),
                ],
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NumberPicker(
                    value: _currentWeightIntValue,
                    minValue: weightRanges[selectedType][0],
                    maxValue: weightRanges[selectedType][1],
                    step: 1,
                    itemHeight: 40,
                    axis: Axis.vertical,
                    onChanged: (value) => setState(() => _currentWeightIntValue = value),
                    textStyle: TextStyle(color: Colors.grey, fontSize: 24),
                    selectedTextStyle: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );

  }

  /// RETURN OPTION TO SETUP WEIGHT
  Widget _fitnessStep(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: height * 0.1),
          height: height * 0.5,
          padding: EdgeInsets.all(fixPadding * 0.4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Fitness Level',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 25),
              ),
              SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      // ON SELECET OPTION OF FITNESS LEVEL
                      setState(() {
                        _currentFitnessLevel = "1";
                      });
                    },
                    child: Container(
                      height: 95,
                      width: width * 0.8,
                      margin: EdgeInsets.only(top:20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: _currentFitnessLevel == "1" ? 2 : 1, color: _currentFitnessLevel == "1" ? Colors.white : Colors.black), 
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  "Beginner",
                                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                                )
                              ),
                              Expanded(
                                child: Text(
                                  "Some Experience",
                                  style: TextStyle(color: Colors.grey[400], fontSize: 16, fontWeight: FontWeight.w600),
                                )
                              )
                            ],
                          )
                          
                        ],
                      )
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      // ON SELECET OPTION OF FITNESS LEVEL
                      setState(() {
                        _currentFitnessLevel = "2";
                      });
                    },
                    child: Container(
                      height: 95,
                      width: width * 0.8,
                      margin: EdgeInsets.only(top:20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: _currentFitnessLevel == "2" ? 2 : 1, color: _currentFitnessLevel == "2" ? Colors.white : Colors.black), 
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Intermediate",
                                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),  
                                ),
                                Text(
                                  "Moderate experience with consistent training",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.grey[400], fontSize: 16, fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      // ON SELECET OPTION OF FITNESS LEVEL
                      setState(() {
                        _currentFitnessLevel = "3";
                      });
                    },
                    child: Container(
                      height: 95,
                      width: width * 0.8,
                      margin: EdgeInsets.only(top:20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: _currentFitnessLevel == "3" ? 2 : 1, color: _currentFitnessLevel == "3" ? Colors.white : Colors.black), 
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Advanced",
                                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),  
                                ),
                                Text(
                                  "Very experienced with consistent training",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.grey[400], fontSize: 16, fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          )
                          
                        ],
                      )
                    ),
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ],
    );

  }

  /// RETUNR OPTION TO SETUP GENDER
  Widget _genderStep(){

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: height * 0.2),
          height: height * 0.5,
          padding: EdgeInsets.all(fixPadding * 0.4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Gender',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 25),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     PageTransition(
                      //         type: PageTransitionType.rightToLeft,
                      //         child: Walkthrough()));
                      _goToNextStep(step: "gender", selected: "male");
                    },
                    child: Container(
                      width: width * 0.4,
                      height: width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        // color: primaryColor,
                        border: Border.all(width: 2, color: Colors.white), 
                      ),
                      // padding: EdgeInsets.all(fixPadding * 2.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.male,
                            color: Colors.white,
                            size: 50,
                          ),
                          Text(
                            'Male',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      _goToNextStep(step: "gender", selected: "female");
                    },
                    child: Container(
                      width: width * 0.4,
                      height: width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        // color: primaryColor,
                        border: Border.all(width: 2, color: Colors.white), 
                      ),
                      // padding: EdgeInsets.all(fixPadding * 2.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.female,
                            color: Colors.white,
                            size: 50,
                          ),
                          Text(
                            'Female',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // heightSpace,
              // heightSpace,
              // InkWell(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         PageTransition(
              //             type: PageTransitionType.rightToLeft,
              //             child: Walkthrough()));
              //   },
              //   child: Text(
              //     'Skip for now'.toUpperCase(),
              //     style: black14MediumTextStyle,
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }


  _register() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)),
          child: Wrap(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SpinKitRing(
                      color: primaryColor,
                      lineWidth: 1.5,
                      size: 35.0,
                    ),
                    heightSpace,
                    heightSpace,
                    Text('Please Wait..', style: grey14MediumTextStyle),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
    // call service to register
    if(await _con.register()){
      Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            child: BottomBar()));
    }else{
      //close loading widget
      Navigator.of(context).pop();
    }

    
    // Timer(
    //     Duration(seconds: 3),
    //     () => Navigator.push(
    //           context,
    //           MaterialPageRoute(builder: (context) => BottomBar()),
    //         ));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print("########");

    // total       --- 1.0
    // currentStep ---  x
    // x = (current * 1)/total
    double totalProgress = ((currentStep + 1) * 1.0) / totalSteps;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/register_img_v2.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7)
              ),
            )
          ),

          _getStepWidget(),
  
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 30),
            title: Container(
              width: width / 0.5,
              constraints: BoxConstraints(maxWidth: 100),
              child: LinearProgressIndicator(
                value: totalProgress,
                color: Colors.white,
                backgroundColor: Colors.grey,
                semanticsLabel: 'Linear progress indicator',
              ),
            ),
            trailing: SizedBox(width: 100),
            leading: InkWell(
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                _backStep(context);
                // Navigator.of(context).pushNamed('/Pages', arguments: 1);
              },
              child: Container(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 20,
                    )
                  ]
                ),      
              )
            )
          ),
          currentStep.toStringAsFixed(0) != "0" ?
          Container(
            margin: EdgeInsets.only(top:height-100),
            padding: EdgeInsets.all(fixPadding * 2.0),
            child: InkWell(
              onTap: () async {
                // GO TO NEXT STEP
                if(currentStep.toStringAsFixed(0) == "1"){
                  _goToNextStep(step: "age");
                }else if(currentStep.toStringAsFixed(0) == "2"){
                  _goToNextStep(step: "height");
                }else if(currentStep.toStringAsFixed(0) == "3"){
                  _goToNextStep(step: "weight");
                }else if(currentStep.toStringAsFixed(0) == "4" && _currentFitnessLevel != ""){
                  _goToNextStep(step: "level");
                }else if(currentStep.toStringAsFixed(0) == "5"){
                  // validate sign up form
                  //call service to register
                  _register();

                }


                // Navigator.push(
                //     context,
                //     PageTransition(
                //         type: PageTransitionType.rightToLeft,
                //         child: Walkthrough()));
              },
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                width: width - fixPadding * 2.0,
                // padding: EdgeInsets.all(fixPadding * 2.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[800],
                ),
                child: Text(
                  currentStep.toStringAsFixed(0) == "5" ? 'Sign UP' : 'Next',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
          ): SizedBox.shrink(),
        ],
      ),
    );
  }

  InputDecoration getInputDecoration({String? hintText, String? labelText}) {
    return new InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: TextStyle(color: Colors.white),
      labelStyle: TextStyle(color: Colors.white),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      floatingLabelStyle: TextStyle(color: Colors.white),
      // hasFloatingPlaceholder: true,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      // labelStyle: Theme.of(context).textTheme.bodyText2!.merge(
      //       TextStyle(color: Theme.of(context).accentColor),
      //     ),
    );
  }
}
