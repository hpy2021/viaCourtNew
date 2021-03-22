import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_app/Constants/AppColors.dart';
import 'package:my_app/Constants/AppTextStyles.dart';
import 'package:my_app/Models/userResponse.dart';
import 'package:my_app/Widgets/custom_background_common_View.dart';

class EditProfile extends StatefulWidget {
  UserResponse user;

  EditProfile({@required this.user});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(context),
    );
  }

  _buildBody(context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors().homegradient()),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 46,
          ),
          header("My Profile", context),
          SizedBox(
            height: 13,
          ),
          Flexible(child: mainBody())
        ],
      ),
    );
  }

  mainBody() {
    return BackgroundCurvedView(
      widget: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: profileView(),
            ),
          ],
        ),
      ),
    );
  }

  header(String text, context) {
    return Container(
      padding: EdgeInsets.only(left: 13, right: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.only(left: 0),
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "Edit  ",
                style: TextStyle(color: Colors.transparent),
              ),
              Expanded(
                child: Container(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.textStyle25white,
                  ),
                ),
              ),
              Text(
                "Edit",
                style: AppTextStyles.textStyle18white,
              ),
            ],
          ),
          // SizedBox(height: 26),
          // Container(
          //   height: 97,
          //   width: 97,
          //   decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       image: DecorationImage(
          //           image: AssetImage("assets/images/profile.jpg"))),
          // ),
          // SizedBox(height: 9),
          // Text(
          //   "${widget.user.firstname + " " + widget.user.lastname}",
          //   style: AppTextStyles.textStyle25white,
          // ),
        ],
      ),
    );
  }

  profileView() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 22),
      children: [
        SizedBox(
          height: 23,
        ),
        Text(
          "INFORMATION",
          style: TextStyle(color: AppColors.lightGreenText_color, fontSize: 16),
        ),
        SizedBox(
          height: 27,
        ),
        _textIconWidget(text: "${widget.user.firstname}", label: "First Name"),
        SizedBox(
          height: 15,
        ),
        Divider(
          color: Color(0xffBAC2DA),
        ),
        SizedBox(
          height: 15,
        ),
        _textIconWidget(text: "${widget.user.lastname}", label: "Last Name"),
        SizedBox(
          height: 15,
        ),
        Divider(
          color: Color(0xffBAC2DA),
        ),
        SizedBox(
          height: 15,
        ),
        _textIconWidget(text: "${widget.user.email}", label: "Email"),
        SizedBox(
          height: 15,
        ),
        Divider(
          color: Color(0xffBAC2DA),
        ),
        SizedBox(
          height: 15,
        ),
        // _textIconWidget(text: "+166 - 12345XXXX", label: "Phone"),
        // SizedBox(
        //   height: 15,
        // ),
        // Divider(
        //   color: Color(0xffBAC2DA),
        // ),
      ],
    );
  }

  _textIconWidget({String label, String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.textStyle18,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 16, color: Colors.black),
          )
        ],
      ),
    );
  }
}
