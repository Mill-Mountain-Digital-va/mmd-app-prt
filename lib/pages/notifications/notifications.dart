import 'package:protennisfitness/constant/constants.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final notificationList = [
    {
      'type': 'message',
      'title': 'Congratulations..',
      'description': 'Congratulations you completed your todays workout.'
    },
    {
      'type': 'subscriptions',
      'title': 'Subscribe premium plan and save 25%',
      'description':
          'Subscribe our premium plan and save upto 25%. Subscribe now.'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.0,
        centerTitle: true,
        title: Text(
          'Notifications',
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
      body: (notificationList.length == 0)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 100.0,
                    width: 100.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: greyColor.withOpacity(0.2),
                    ),
                    child: Icon(
                      Icons.notifications_off,
                      color: greyColor,
                      size: 55.0,
                    ),
                  ),
                  heightSpace,
                  heightSpace,
                  Text(
                    'No new notifications',
                    style: grey20MediumTextStyle,
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: notificationList.length,
              itemBuilder: (context, index) {
                final item = notificationList[index];
                return Dismissible(
                  key: Key('$item'),
                  onDismissed: (direction) {
                    setState(() {
                      notificationList.removeAt(index);
                    });

                    // Then show a snackbar.
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${item['title']} dismissed")));
                  },
                  // Show a red background as the item is swiped away.
                  background: Container(color: Colors.red),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(fixPadding * 2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular((index == 0) ? 30.0 : 0.0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 70.0,
                              height: 70.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35.0),
                                color: primaryColor,
                              ),
                              child: Icon(
                                (item['type'] == 'message')
                                    ? Icons.notifications
                                    : Icons.credit_card,
                                size: 35.0,
                                color: whiteColor,
                              ),
                            ),
                            widthSpace,
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title']!,
                                    style: black16MediumTextStyle,
                                    textAlign: TextAlign.justify,
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    item['description']!,
                                    style: grey14RegularTextStyle,
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1.0,
                        width: double.infinity,
                        color: lightGreyColor!,
                        margin:
                            EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
