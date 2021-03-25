import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:my_app/Constants/AppColors.dart';

import 'package:my_app/Constants/AppTextStyles.dart';
import 'package:my_app/Models/userResponse.dart';
import 'package:my_app/Utils/ApiManager.dart';
import '../Constants/AppConstants.dart';
import '../Constants/AppStrings.dart';
import '../Models/BookingResponse.dart';
import '../Widgets/custom_background_common_View.dart';

class MyBookings extends StatefulWidget {
  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  List<Bookings> bookingList = [];
  bool isLoading = false;
  UserResponse user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userApiCall();
  }

  userApiCall() async {
    if (await ApiManager.checkInternet()) {
      if (mounted)
        setState(() {
          isLoading = true;
        });
      user = UserResponse.fromJson(
          await ApiManager().getCallwithheader(AppStrings.USER_URL));

      if (user.status == "Active") {
        if (mounted)
          setState(() {
            isLoading = false;
          });
        _getBookings();
        user = user;
        if (mounted) setState(() {});
      } else {
        if (mounted)
          setState(() {
            isLoading = false;
          });
        // AppConstants().showToast(msg: "${user.message}");
      }
    } else {
      AppConstants().showToast(msg: tr("internetNotavailabletext"));
    }
  }

  _getBookings() async {
    if (mounted)
      setState(() {
        isLoading = true;
      });

    Map<String, dynamic> request = new HashMap();
    BookingResponse response = BookingResponse.fromJson(
      await ApiManager().postCallWithHeader(
          AppStrings.MYBOOKING_URL + "/${user.id}", request, context),
    );
    if (response != null) {
      isLoading = false;

      bookingList = response.bookings;

      setState(() {});
    }

    if (mounted) setState(() {});
  }

  String _startTime, _endTime, bookedDate;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: AnnotatedRegion(
            child: _buildBody(),
            value: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light),
          ),
        ),
        AppConstants.progress(isLoading, context)
      ],
    );
  }

  _buildBody() {
    return Container(
      decoration: BoxDecoration(gradient: AppColors().homegradient()),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 46,
          ),
          _header(),
          SizedBox(
            height: 3,
          ),
          SizedBox(
            height: 13,
          ),
          Expanded(child: _RecentBody())
        ],
      ),
    );
  }

  _header() {
    return Container(
      padding: EdgeInsets.only(left: 13, right: 20),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              tr("myBookingsText"),
              style: AppTextStyles.textStyle25white,
            ),
          ),
        ],
      ),
    );
  }

  _RecentBody() {
    return BackgroundCurvedView(
      widget: bookingList == null || bookingList.length == 0
          ? Container(
              child: Center(
                  child: Text(
              tr("noBookingsFound"),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )))
          : ListView.builder(
              padding: EdgeInsets.all(15),
              physics: BouncingScrollPhysics(),
              itemCount: bookingList.length,
              itemBuilder: (BuildContext ctx, int index) {
                _startTime = DateFormat("HH:mm a").format(DateTime.parse(
                    "2017-07-04 ${bookingList[index].bookingSlotStartTime}"));
                _endTime = DateFormat("HH:mm a").format(DateTime.parse(
                    "2017-07-04 ${bookingList[index].bookingSlotEndTime}"));

                bookedDate = DateFormat("MMMM dd, yyyy").format(
                    DateTime.parse("${bookingList[index].bookingDate}"));
                return _bookingListItem(bookingList[index]);
              },
            ),
    );
  }

  _bookingListItem(Bookings bookings) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Card(
        shadowColor: Colors.black,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bookings.pitchImage == null
                      ? Container()
                      : _imageView(bookings.pitchImage),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "${bookings.bookingNumber}",
                              style: AppTextStyles.textStyle15mediumblack,
                            ),
                            Text(
                              "$bookedDate",
                              style: AppTextStyles.textStyle14green,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${bookings.name}",
                          style: AppTextStyles.textStyle14grey,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "$_startTime - $_endTime",
                          style: AppTextStyles.textStyle14green,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 2,
              thickness: 2,
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Total",
                    style: AppTextStyles.textStyle15mediumblack,
                  ),
                  Text(
                    "\$ ${bookings.total}",
                    style: AppTextStyles.textStyle15mediumblack,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _imageView(String url) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Image.network(
          "${AppStrings.IMGBASE_URL + url}",
          height: 40,
          width: 40,
          fit: BoxFit.cover,
          errorBuilder: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
