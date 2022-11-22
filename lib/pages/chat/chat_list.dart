import 'package:protennisfitness/constant/constants.dart';
import 'package:protennisfitness/screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final chatList = [
    {
      'name': 'Amenda Johnson',
      'image': 'assets/trainer/trainer_1.jpg',
      'msg': 'Hello, How can i help you?',
      'time': '1d ago',
      'status': 'unread'
    },
    {
      'name': 'Russeil Taylor',
      'image': 'assets/trainer/trainer_2.jpg',
      'msg': 'Okay',
      'time': '1d ago',
      'status': 'read'
    },
    {
      'name': 'Lliana George',
      'image': 'assets/trainer/trainer_3.jpg',
      'msg': 'Good',
      'time': '5d ago',
      'status': 'read'
    },
    {
      'name': 'Suzein Smith',
      'image': 'assets/trainer/trainer_4.jpg',
      'msg': 'Take care.',
      'time': '1w ago',
      'status': 'read'
    },
    {
      'name': 'Olivier Hayden',
      'image': 'assets/trainer/trainer_5.jpg',
      'msg': 'Hello, How can i help you?',
      'time': '1d ago',
      'status': 'unread'
    },
    {
      'name': 'Amenda Johnson',
      'image': 'assets/trainer/trainer_1.jpg',
      'msg': 'Okay',
      'time': '1d ago',
      'status': 'read'
    },
    {
      'name': 'Russeil Taylor',
      'image': 'assets/trainer/trainer_2.jpg',
      'msg': 'Good',
      'time': '5d ago',
      'status': 'read'
    },
    {
      'name': 'Lliana George',
      'image': 'assets/trainer/trainer_3.jpg',
      'msg': 'Take care.',
      'time': '1w ago',
      'status': 'read'
    },
    {
      'name': 'Suzein Smith',
      'image': 'assets/trainer/trainer_4.jpg',
      'msg': 'Take care.',
      'time': '1w ago',
      'status': 'read'
    },
    {
      'name': 'Olivier Hayden',
      'image': 'assets/trainer/trainer_5.jpg',
      'msg': 'Hello, How can i help you?',
      'time': '1d ago',
      'status': 'unread'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 1.0,
        title: Text(
          'Chats',
          style: appBarTextStyle,
        ),
      ),
      body: (chatList.length == 0)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat,
                    color: greyColor,
                    size: 70.0,
                  ),
                  heightSpace,
                  Text(
                    'No Chat Available',
                    style: grey20MediumTextStyle,
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: chatList.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final item = chatList[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                duration: Duration(milliseconds: 500),
                                type: PageTransitionType.rightToLeft,
                                child: ChatScreen(name: item['name']!)));
                      },
                      child: Container(
                        padding: EdgeInsets.all(fixPadding * 2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 70.0,
                              height: 70.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35.0),
                                border:
                                    Border.all(width: 0.3, color: primaryColor),
                                image: DecorationImage(
                                  image: AssetImage(item['image']!),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            widthSpace,
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item['name']!,
                                              style: black18SemiBoldTextStyle,
                                            ),
                                            SizedBox(width: 7.0),
                                            (item['status'] == 'unread')
                                                ? Container(
                                                    width: 10.0,
                                                    height: 10.0,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      color: primaryColor,
                                                    ),
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                        heightSpace,
                                        Text(
                                          item['msg']!,
                                          style: grey14MediumTextStyle,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                        item['time']!,
                                        style: grey14MediumTextStyle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    divider(),
                  ],
                );
              },
            ),
    );
  }

  divider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      width: MediaQuery.of(context).size.width - fixPadding * 4.0,
      height: 1.0,
      color: Colors.grey[200],
    );
  }
}
