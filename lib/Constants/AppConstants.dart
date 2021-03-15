import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_app/Constants/AppColors.dart';
import 'package:my_app/Constants/AppStrings.dart';
import 'package:my_app/Constants/AppTextStyles.dart';
import 'package:my_app/Views/Cart.dart';

class AppConstants {
  static progress(bool isLoading, BuildContext context) {
    return isLoading
        ? Container(
            color: Color(0x80ffffff),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Color(0x80ffffff),
              child: SpinKitThreeBounce(
                size: 40,
                duration: new Duration(milliseconds: 1800),
                color: AppColors.appColor_color,
              ),
            ),
          )
        : Container();
  }

  header({String text, @required context}) {
    return Container(
      padding: EdgeInsets.only(
          left: text == AppStrings.confirmationText ||
                  text == AppStrings.bookingText ||
                  text == AppStrings.activityText
              ? 0
              : 13,
          right: 20),
      child: Row(
        children: [
          Visibility(
            visible: text == AppStrings.confirmationText ||
                    text == AppStrings.bookingText ||
                    text == AppStrings.activityText
                ? false
                : true,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          SizedBox(width: 15),
          Text(
            text,
            style: AppTextStyles.textStyle25white,
          ),
        ],
      ),
    );
  }

  void showToast({String msg}) {
    BotToast.showCustomText(
        toastBuilder: (_) => Container(
              decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    msg,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  )),
            ),
        duration: Duration(seconds: 2),
        onlyOne: true,
        clickClose: true,
        align: Alignment(0, 0.75));
  }

  static imageLoader(String url, String placeholder) {
    return Container(
        child: Image.network(
      "${AppStrings.IMGBASE_URL + url}",
      // height: 40,
      // width: 40,
      fit: BoxFit.contain,
      // loadingBuilder: (context, child, loadingProgress) => Padding(
      //   padding: const EdgeInsets.all(20.0),
      //   child: SpinKitCircle(
      //     color: AppColors.appColor_color,
      //     size: 50,
      //   ),
      // ),
      errorBuilder: (context, url, error) => Icon(Icons.error),
    ));
  }
}
