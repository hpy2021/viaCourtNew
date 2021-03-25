import 'dart:collection';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Constants/AppColors.dart';
import 'package:my_app/Constants/AppConstants.dart';
import 'package:my_app/Constants/AppStrings.dart';
import 'package:my_app/Constants/AppTextStyles.dart';
import 'package:my_app/Models/CommonResponse.dart';
import 'package:my_app/Models/userResponse.dart';
import 'package:my_app/Utils/ApiManager.dart';
import 'package:my_app/Widgets/custom_background_common_View.dart';
import 'package:my_app/Widgets/custom_button.dart';

class EditProfile extends StatefulWidget {
  UserResponse user;

  EditProfile({@required this.user});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController fNameController, lNameController, emailController;
  bool iseditEnabled = false;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fNameController = TextEditingController();
    lNameController = TextEditingController();
    emailController = TextEditingController();

    fNameController.text = widget.user.firstname;
    lNameController.text = widget.user.lastname;
    emailController.text = widget.user.email;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: _buildBody(context),
        ),
        AppConstants.progress(isLoading, context)
      ],
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
          Expanded(child: mainBody())
        ],
      ),
    );
  }

  mainBody() {
    return BackgroundCurvedView(
      widget: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              profileView(),
              Visibility(
                visible: iseditEnabled,
                child: _UpdateButton(),
              ),
              // SizedBox(
              //   height: 15,
              // ),
            ],
          ),
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
                onTap: () => Navigator.pop(context,false),
                child: Container(
                  padding: EdgeInsets.only(left: 0),
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.textStyle25white,
                ),
              ),
              InkWell(
                onTap: () {
                  iseditEnabled = !iseditEnabled;
                  AppConstants().showToast(
                      msg: iseditEnabled ? "Edit enabled" : "Edit disable");
                  setState(() {});
                },
                child: Text(
                  "Edit",
                  style: AppTextStyles.textStyle18white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  profileView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 23,
            ),
            Text(
              "INFORMATION",
              style: TextStyle(
                  color: AppColors.lightGreenText_color, fontSize: 16),
            ),
            SizedBox(
              height: 27,
            ),
            _textIconWidget(
                text: "${widget.user.firstname}",
                label: "First Name",
                controller: fNameController,
                enable: iseditEnabled),
            SizedBox(
              height: 15,
            ),
            Divider(
              color: Color(0xffBAC2DA),
            ),
            SizedBox(
              height: 15,
            ),
            _textIconWidget(
                text: "${widget.user.lastname}",
                label: "Last Name",
                controller: lNameController,
                enable: iseditEnabled),
            SizedBox(
              height: 15,
            ),
            Divider(
              color: Color(0xffBAC2DA),
            ),
            SizedBox(
              height: 15,
            ),
            _textIconWidget(
                text: "${widget.user.email}",
                label: "Email",
                controller: emailController,
                enable: false),
            SizedBox(
              height: 15,
            ),
            Divider(
              color: Color(0xffBAC2DA),
            ),
          ],
        ),
      ),
    );
  }

  _textIconWidget(
      {String label,
      String text,
      TextEditingController controller,
      bool enable}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.textStyle18,
          ),
          // Container(),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
                enabled: enable,
                // hintText: text,
                border: InputBorder.none),
            style: TextStyle(fontSize: 16, color: Colors.black),
          )
        ],
      ),
    );
  }

  _UpdateButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
      child: CustomButton(
        onPressed: () {
          _updateApiCall();
        },
        text: tr("updateText"),
      ),
    );
  }

  _updateApiCall() async {
    if (await ApiManager.checkInternet()) {
      if (mounted)
        setState(() {
          isLoading = true;
        });
      Map<String,dynamic> request = new HashMap();
      request["firstname"] = fNameController.text;
      request["lastname"] = lNameController.text;
      request["email"]=widget.user.email;


      CommonResponse response = CommonResponse.fromJson(
          await ApiManager().postCallWithHeader(AppStrings.UPDATE_PROFILE + "/${widget.user.id}",request,context));

      if (response != null) {
        if (mounted)
          setState(() {
            isLoading = false;
          });
        print(response.message);
        Navigator.pop(context,true);
        setState(() {});
        // AppConstants().showToast(msg: "User returned SuccessFully");
      } else {
        if (mounted)
          setState(() {
            isLoading = false;
          });
        // AppConstants().showToast(msg: "${registerResponse.message}");
      }
    } else {
      AppConstants().showToast(msg: "Internet is not available");
    }
  }
}
