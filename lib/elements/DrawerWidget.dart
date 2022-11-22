
import 'package:protennisfitness/screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:protennisfitness/constant/constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../providers/user_repository.dart' as userRepo;

class DrawerWidget extends StatefulWidget {

  //HomeWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends StateMVC<DrawerWidget> {
  // ProfileController _con;

  _DrawerWidgetState() : super();
  // ProfileController()) {
  //   _con = controller;
  // }

  logoutDialogue() {
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
                      "You sure want to logout?",
                      style: black16MediumTextStyle,
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: (width / 3.5),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              'Cancel',
                              style: black16RegularTextStyle,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            userRepo.logout().then((value) {

                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: Walkthrough()));
                            });
                          },
                          child: Container(
                            width: (width / 3.5),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              'Logout',
                              style: white16RegularTextStyle,
                            ),
                          ),
                        ),
                      ],
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
    return Drawer(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            padding: EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            image: userRepo.currentUser.value.image != null ? DecorationImage(
                              image: NetworkImage(userRepo.currentUser.value.image!),
                              fit: BoxFit.cover,
                            ) : DecorationImage(
                              image: AssetImage("assets/user.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        widthSpace,
                        widthSpace,
                        Text(
                          userRepo.currentUser.value.name ?? "",
                          style: black16SemiBoldTextStyle,
                        ),
                      ],
                    ),
                    //TODO EDIT PROFILE
                    /*InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: AccountSetting()));
                      },
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        height: 40.0,
                        width: 40.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: primaryColor,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: whiteColor,
                          size: 20.0,
                        ),
                      ),
                    ),*/
                  ],
                ),
                SizedBox(height: 25.0),
                // Text(
                //   'About'.toUpperCase(),
                //   style: black12RegularTextStyle,
                // ),
                heightSpace,
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         PageTransition(
                //             type: PageTransitionType.rightToLeft,
                //             child: TrainerList()));
                //   },
                //   child: settingTile('My Trainer', ''),
                // ),
                // InkWell(
                //   onTap: () {},
                //   child: settingTile('My Workout', ''),
                // ),
                /*InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: Notifications()));
                  },
                  child: settingTile('Notifications', ''),
                ),
                InkWell(
                  onTap: () {},
                  child: settingTile('Language', ''),
                ),*/
                userRepo.currentUser.value.premium == true ? SizedBox.shrink() :
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: UnlockPremium()));
                  },
                  child: settingTile('Unlock Premium', ''),
                ),
                // InkWell(
                //   onTap: () {},
                //   child: settingTile('Invite Friends', ''),
                // ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: PrivacyPolicy(),
                      ),
                    );
                  },
                  child: settingTile('Privacy Policy', ''),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: TermsOfUse(),
                      ),
                    );
                  },
                  child: settingTile('Terms of use', ''),
                ),
                SizedBox(height: 25.0),
                Text(
                  'App'.toUpperCase(),
                  style: black12RegularTextStyle,
                ),
                heightSpace,
                /*InkWell(
                  onTap: () {
                    _openMail("mailto:suport@protennisfitness.com");
                  },
                  child: settingTile('Support', ''),
                ),
                InkWell(
                  onTap: () {},
                  child: settingTile('Report a Bug', ''),
                ),*/
                InkWell(
                  onTap: () {},
                  child: settingTile('App Version 1.0', '', icon: false),
                ),
                InkWell(
                  onTap: () => logoutDialogue(),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: fixPadding * 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.red,
                          size: 24.0,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          'Logout',
                          style: red16MediumTextStyle,
                        ),
                      ],
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

  settingTile(title, type, {bool icon = true}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: black16MediumTextStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  (type != '')
                      ? Text(
                          type,
                          style: black16RegularTextStyle,
                        )
                      : Container(),
                  SizedBox(width: 5.0),
                  icon == true ?
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12.0,
                    color: blackColor,
                  ) : SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 1.0,
          color: lightGreyColor!,
        ),
      ],
    );
  }
}
