import 'dart:io';

import 'package:protennisfitness/constant/constants.dart';
import 'package:protennisfitness/screens.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  DateTime? currentBackPressTime;
  int currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
        elevation: 3.0,
        child: Container(
          width: double.infinity,
          height: 60.0,
          color: whiteColor.withOpacity(0.6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              bottomBarItem(1, 'assets/icon/5.png', 'assets/icon/5_active.png'),
              bottomBarItem(2, 'assets/icon/1.png', 'assets/icon/1_active.png'),
              // bottomBarItem(3, 'assets/icon/2.png', 'assets/icon/2_active.png'),
              // bottomBarItem(4, 'assets/icon/3.png', 'assets/icon/3_active.png'),
              bottomBarItem(3, 'assets/icon/4.png', 'assets/icon/4_active.png'),
            ],
          ),
        ),
      ),
      body: WillPopScope(
        child: (currentIndex == 1)
            ? Search()
            : (currentIndex == 2)
                ? WorkOutWidget()
                : (currentIndex == 3) ? Profile() : SizedBox.shrink(),
                    // ? HealthTipsList()
                    // : (currentIndex == 4)
                    //     ? ChatList()
                    //     : Profile(),
        onWillPop: () async {
          bool backStatus = onWillPop();
          if (backStatus) {
            exit(0);
          }
          return false;
        },
      ),
    );
  }

  bottomBarItem(index, iconPath, activeIconPath) {
    return InkWell(
      onTap: () {
        if (index != currentIndex) {
          setState(() {
            currentIndex = index;
          });
        }
      },
      borderRadius: BorderRadius.circular(35.0),
      child: Container(
        width: (MediaQuery.of(context).size.width) / 5.0,
        height: 50.0,
        alignment: Alignment.center,
        child: Image.asset(
          (index == currentIndex) ? activeIconPath : iconPath,
          width: 28.0,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }
}
