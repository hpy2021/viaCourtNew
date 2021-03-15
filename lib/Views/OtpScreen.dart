
import 'package:flutter/material.dart';
import 'package:my_app/Constants/AppColors.dart';
import 'package:my_app/Constants/AppStrings.dart';
import 'package:my_app/Constants/AppTextStyles.dart';
import 'package:my_app/Views/BottomNavigationBarHome.dart';
import 'package:my_app/Views/HomeScreen.dart';
import 'package:my_app/Widgets/OtpTextFieldWidget.dart';
import 'package:my_app/Widgets/custom_button.dart';

class OtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _body(context),
    );
  }

  _body(context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 26),
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(gradient: AppColors().gradient()),
            width: double.infinity,
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              SizedBox(height: 105),
              _text(),
              SizedBox(height: 54),
              _otpField(context),
              SizedBox(height: 45),
              _resendText(),
              SizedBox(height: 34),
              _loginButton(context)
            ]),
          ),
          _backButton(context)
        ],
      ),
    );
  }

  _text() {
    return Padding(
      padding: const EdgeInsets.only(right: 80),
      child: Text(
        "Please enter the 4-digit code sent to you at +166-123456XXXX",
        style: AppTextStyles.textStyle18,
      ),
    );
  }

  _otpField(context) {
    return OTPTextField(
      length: 4,
      width: MediaQuery.of(context).size.width,
      // textFieldAlignment: MainAxisAlignment.spaceAround,
      // fieldWidth: 50,
      keyboardType: TextInputType.number,
      fieldStyle: FieldStyle.box,

      style: TextStyle(fontSize: 30),
      onCompleted: (pin) {
        print("Completed: " + pin);
      },
    );
  }

  _resendText() {
    return Text(
      "Resend code in 0:08",
      style: TextStyle(color: Colors.black.withOpacity(0.55)),
    );
  }

  _loginButton(context) {
    return CustomButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavigationBarView(),
          ),
        );
      },
      text: AppStrings.loginButtonText,
    );
  }

  _backButton(context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(26, 53, 0, 0),
        height: 30,
        width: 30,
        decoration:
            BoxDecoration(color: Color(0xff51526E), shape: BoxShape.circle),
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
