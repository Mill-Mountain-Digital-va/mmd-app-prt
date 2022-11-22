import 'package:protennisfitness/constant/constants.dart';
import 'package:protennisfitness/screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Trainer extends StatefulWidget {
  final String? name, imagePath, type, heroTag;

  const Trainer(
      {Key? key,
      @required this.name,
      @required this.imagePath,
      @required this.type,
      @required this.heroTag})
      : super(key: key);
  @override
  _TrainerState createState() => _TrainerState();
}

class _TrainerState extends State<Trainer> {
  bool follow = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: Material(
        elevation: 2.0,
        child: Container(
          width: width,
          height: 70.0,
          padding: EdgeInsets.fromLTRB(
              fixPadding * 2.0, fixPadding, fixPadding * 2.0, fixPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: ChatScreen(
                            name: widget.name,
                          )));
                },
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  width: (width - fixPadding * 4.0 - fixPadding) / 2,
                  padding: EdgeInsets.fromLTRB(fixPadding * 1.5, fixPadding,
                      fixPadding * 1.5, fixPadding),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      width: 0.8,
                      color: primaryColor,
                    ),
                  ),
                  child: Text(
                    'Message',
                    style: primaryColor16MediumTextStyle,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    follow = !follow;
                  });
                },
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  width: (width - fixPadding * 4.0 - fixPadding) / 2,
                  padding: EdgeInsets.fromLTRB(fixPadding * 1.5, fixPadding,
                      fixPadding * 1.5, fixPadding),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: (follow) ? Colors.transparent : primaryColor,
                    border: Border.all(
                      width: 0.8,
                      color: primaryColor,
                    ),
                  ),
                  child: Text(
                    (follow) ? 'Following' : 'Follow',
                    style: (follow)
                        ? primaryColor16MediumTextStyle
                        : white16MediumTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 350.0,
                pinned: true,
                forceElevated: true,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                elevation: 0.0,
                leading: IconButton(
                  color: whiteColor.withOpacity(0.7),
                  icon: Icon(
                    Icons.arrow_back,
                    color: blackColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                centerTitle: true,
                title: Text(
                  widget.name!,
                  style: appBarTextStyle,
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: widget.heroTag!,
                    child: Container(
                      width: width,
                      // height: 350.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(widget.imagePath!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: ListView(
            children: [
              trainerDetail(),
              about(),
            ],
          ),
        ),
      ),
    );
  }

  trainerDetail() {
    return Container(
      padding: EdgeInsets.only(
          top: fixPadding * 2.0,
          right: fixPadding * 2.0,
          left: fixPadding * 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name!,
                style: primaryColor18SemiBoldTextStyle,
              ),
              height5Space,
              Text(
                widget.type!,
                style: grey14MediumTextStyle,
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '1.7k',
                style: black18SemiBoldTextStyle,
              ),
              height5Space,
              Text(
                'Followers',
                style: black14MediumTextStyle,
              )
            ],
          ),
        ],
      ),
    );
  }

  about() {
    return Container(
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: primaryColor16MediumTextStyle,
          ),
          heightSpace,
          heightSpace,
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
            style: black14RegularTextStyle,
            textAlign: TextAlign.justify,
          ),
          heightSpace,
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
            style: black14RegularTextStyle,
            textAlign: TextAlign.justify,
          ),
          heightSpace,
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
            style: black14RegularTextStyle,
            textAlign: TextAlign.justify,
          ),
          heightSpace,
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
            style: black14RegularTextStyle,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
