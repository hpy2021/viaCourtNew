import 'dart:collection';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:my_app/Constants/AppColors.dart';
import 'package:my_app/Constants/AppConstants.dart';
import 'package:my_app/Constants/AppStrings.dart';
import 'package:my_app/Constants/AppTextStyles.dart';
import 'package:my_app/Models/BookingConfirmedResponse.dart';
import 'package:my_app/Models/CommonResponse.dart';
import 'package:my_app/Models/SignUpResposne.dart';
import 'package:my_app/Models/SlotItemModel.dart';
import 'package:my_app/Models/TimeSlotResponse.dart';
import 'package:my_app/Models/userResponse.dart';
import 'package:my_app/Views/BookingConfirmed.dart';
import 'package:my_app/Widgets/custom_button.dart';
import 'package:my_app/Utils/ApiManager.dart';

class SelectSlot extends StatefulWidget {
  int pitchid, courtid, locationid, price;

  SelectSlot(
      {@required this.pitchid,
      this.locationid,
      this.courtid,
      @required this.price});

  @override
  _SelectSlotState createState() => _SelectSlotState();
}

class _SelectSlotState extends State<SelectSlot> {
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  var date = DateFormat("MMMM dd, yyyy");
  var date2 = DateFormat("dd/MM/yyyy");
  var requestDateFormate = DateFormat("yyyy-MM-dd");
  bool isLoading = false;
  String result;
  String dateTime, endTime;
  UserResponse user;

  List<Timeslots> slotItemList = [];

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
        print(user.firstname);
        user = user;
        setState(() {

        });
        AppConstants().showToast(msg: "User returned SuccessFully");
      } else {
        if (mounted)
          setState(() {
            isLoading = false;
          });
        // AppConstants().showToast(msg: "${user.message}");
      }
    }
  }

  getSlots({int id, DateTime booking_date}) async {
    if (await ApiManager.checkInternet()) {
      if (mounted)
        setState(() {
          isLoading = true;
        });
      print(id);
      Map<String, dynamic> request = new HashMap();

      // request["name"] = "abc";
      // request["status"] = "Available";
      // request["email"] = "yash@gmail.com";
      // request["court_id"] = "3";
      // request["location_id"] = "1";
      // request["price"] = "50";
      // request["slote_duration"] = "2";
      request["booking_date"] = "${requestDateFormate.format(booking_date)}";
      TimeSlotResponse response = new TimeSlotResponse.fromJson(
          await ApiManager().postCallWithHeader(
              AppStrings.PITCH_TIME_SLOT_URL + "/$id", request, context)); //
      // print(response.timeslots.length);
      // api call
      // TimeSlotResponse response = new TimeSlotResponse.fromJson(await ApiManager()
      //     .postCallWithHeader(AppStrings.PRODUCT_URL, request, context));
      if (response != null) {
        if (response.timeslots == null) {

          slotItemList.clear();
          slotItemList == null;
          setState(() {});
        } else {
          if (mounted)
            setState(() {
              isLoading = false;
            });
          slotItemList = response.timeslots;

          if (mounted) setState(() {});
        }
      }
      if (mounted)
        setState(() {
          isLoading = false;
        });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("pitch id: ${widget.pitchid}");
    print("location id: ${widget.locationid}");
    print("courtid: ${widget.courtid}");
    // getSlots(id: widget.pitchid, booking_date: _currentDate2);
    userApiCall();
  }

  availablityCheckApi(String startTime, String endTime) async {
    if (await ApiManager.checkInternet()) {
      if (mounted)
        setState(() {
          isLoading = true;
        });
      Map<String, dynamic> request = new HashMap();
      request["booking_slot_start_time"] = "$startTime";
      request["booking_slot_end_time"] = "$endTime";
      CommonResponse response = new CommonResponse.fromJson(await ApiManager()
          .postCallWithHeader(
              AppStrings.AVAILABILITY_URL +
                  "/${widget.pitchid}" +
                  "/availability",
              request,
              context));
      if (response != null) {
        print(response.result);
        if (mounted)
          setState(() {
            isLoading = false;
          });
        result = response.result;
        setState(() {});

        return response.result;
      } else {
        if (mounted)
          setState(() {
            isLoading = false;
          });
        if (mounted) setState(() {});
      }
      if (mounted)
        setState(() {
          isLoading = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: _buildBody(),
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 46,
          ),
          AppConstants().header(text: AppStrings.selectSlot, context: context),
          SizedBox(
            height: 13,
          ),
          Flexible(child: calenderView())
        ],
      ),
    );
  }

  calenderView() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
          ),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40),
            ),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  roundedCornerTextView(),
                  _calender(),
                  _slotsAvailbletextView(),
                  SizedBox(
                    height: 12,
                  ),
                  _slotsView(),
                  _bottomBookingButton()
                ],
              ),
            )));
  }

  roundedCornerTextView() {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 28, 20, 14),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 7, color: Color(0xff3FA786).withOpacity(0.27))
          ],

          // border: Border.all(color: Color(0xff3FA786).withOpacity(0.27))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${date2.format(_currentDate2)}",
              style: AppTextStyles.textStyle15medium,
            ),
            Icon(
              Icons.calendar_today_outlined,
              color: AppColors.appColor_color,
            )
          ],
        ));
  }

  bool isSelected = false;

  _calender() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 14, 20, 35),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(blurRadius: 7, color: Color(0xff3FA786).withOpacity(0.27))
          ]),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          print("date : $date");
          // isSelected = !isSelected;
          _currentDate2 = date;
          getSlots(id: widget.pitchid, booking_date: date);

          setState(() {});
        },

        weekendTextStyle: TextStyle(
            color: Color(0xff666666),
            fontWeight: FontWeight.w500,
            fontSize: 12),

        weekdayTextStyle: TextStyle(
          color: AppColors.appColor_color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),

        thisMonthDayBorderColor: Colors.grey,
        daysTextStyle: AppTextStyles.textStyle12medium,
        dayPadding: 7,
//          weekDays: null, /// for pass null when you do not want to render weekDays
//       headerText: 'Custom Header',
        headerTextStyle: TextStyle(color: Color(0xff666666), fontSize: 15),
        leftButtonIcon: Card(
          elevation: 24,
          shadowColor: Color(0xff000000).withOpacity(0.07),
          child: Icon(Icons.chevron_left),
        ),
        rightButtonIcon: Card(
          elevation: 24,
          shadowColor: Color(0xff000000).withOpacity(0.07),
          child: Icon(Icons.chevron_right),
        ),
        height: 350,
        weekFormat: false,
        // markedDatesMap: _markedDateMap,
        selectedDateTime: _currentDate2,
        showIconBehindDayText: true,
//          daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
        customGridViewPhysics: NeverScrollableScrollPhysics(),
        // markedDateShowIcon: true,
        markedDateIconMaxShown: 4,
        selectedDayTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        inactiveDaysTextStyle: AppTextStyles.textStyle12medium,
        nextDaysTextStyle: AppTextStyles.textStyle12mediumlight,
        prevDaysTextStyle: AppTextStyles.textStyle12mediumlight,
        selectedDayButtonColor: AppColors.appColor_color,
        childAspectRatio: 1,

        todayTextStyle: TextStyle(
          color: Color(0xff666666),
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        markedDateIconBuilder: (event) {
          return event.icon;
        },
        minSelectedDate: _currentDate.subtract(Duration(days: 360)),
        maxSelectedDate: _currentDate.add(Duration(days: 360)),
        todayButtonColor: Color(0xffCFF4D2),

        // todayBorderColor: Colors.green,
        markedDateMoreShowTotal: true,
        // null for not showing hidden events indicator
        markedDateIconMargin: 9,
        markedDateIconOffset: 3,
      ),
    );
  }

  _slotsAvailbletextView() {
    return Column(
      children: [
        Text(
          "${date.format(_currentDate2)}",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Text(
          "Please select slots",
          style: TextStyle(fontSize: 12, color: AppColors.lightGreenText_color),
        )
      ],
    );
  }
  bool isForOnetime = false;

  _slotsView() {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: slotItemList.length == 0 || slotItemList.length == null
          ? Center(
              child: Text(
              "No slots available",
              style: AppTextStyles.textStyle14grey,
            ))
          : Wrap(
              children: List<Widget>.generate(slotItemList.length, (index) {
                if(isForOnetime){
                  slotItemList.forEach((element) {
                    if(element.isBooked){
                      element.isBooked = false;
                    }
                    print(element.isBooked);
                    isForOnetime = false;

                  });
                }

                return _slotsListItemView(slotItemList[index]);
              }).toList(),
            ),
    );
  }

  // _slotsListItemView(Timeslots slotItem) {
  //   return Material(
  //     child: Padding(
  //       padding:EdgeInsets.fromLTRB(0, 0, 11, 9),
  //       child: InkWell(
  //         borderRadius: BorderRadius.circular(5),
  //
  //
  //         highlightColor: Colors.blue,
  //         splashColor: Colors.grey,
  //         focusColor: Colors.blue,
  //         onTap: () async {
  //           if (slotItem.isBooked == true) {
  //             slotItem.isBooked = false;
  //             setState(() {});
  //           } else {
  //             var time = slotItem.from;
  //             dateTime = DateFormat("yyyy-MM-dd").format(_currentDate2);
  //             dateTime = dateTime + " " + time + ":" + "00";
  //             print(dateTime);
  //             var endtime = slotItem.to;
  //             endTime = DateFormat("yyyy-MM-dd").format(_currentDate2);
  //             endTime = endTime + " " + endtime + ":" + "00";
  //             await availablityCheckApi(dateTime, endTime);
  //             if (result == "available") {
  //               slotItem.isBooked = true;
  //               setState(() {});
  //             } else if (result == null) {
  //               AppConstants().showToast(
  //                   msg:
  //                       "The slot you are selecting has passed so try to select another slot.");
  //             } else if (result == "not available") {
  //               AppConstants().showToast(msg: "This slot is not available.");
  //             }
  //           }
  //         },
  //         child: Container(
  //           padding: EdgeInsets.symmetric(horizontal: 19, vertical: 12),
  //           // margin:
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(5),
  //               color: slotItem.isBooked
  //                   ? AppColors.appColor_color
  //                   : AppColors.availableBackgroundColor
  //               // : AppColors.notavailableBackgroundColor
  //
  //               ),
  //           child: Text(
  //             "${slotItem.from}",
  //             style: TextStyle(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.w500,
  //                 // color:AppColors.availableTextColor
  //                 color: slotItem.isBooked
  //                     ? Colors.white
  //                     : AppColors.availableTextColor
  //                 // : AppColors.notavailableTextColor,
  //                 ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  _slotsListItemView(Timeslots slotItem) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 10, 9),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: slotItem.isBooked
            ? AppColors.appColor_color
            : AppColors.availableBackgroundColor,
        elevation: 0,
        highlightElevation: 0,

        padding: EdgeInsets.symmetric(horizontal: 19, vertical: 12),

        onPressed: () async {

          if (slotItem.isBooked == true) {
            slotItem.isBooked = false;
            dateTime = "";
            endTime = "";
            setState(() {});
          } else {
            isForOnetime = true;
            var time = slotItem.from;
            dateTime = DateFormat("yyyy-MM-dd").format(_currentDate2);
            dateTime = dateTime + " " + time + ":" + "00";
            print(dateTime);
            var endtime = slotItem.to;
            endTime = DateFormat("yyyy-MM-dd").format(_currentDate2);
            endTime = endTime + " " + endtime + ":" + "00";
            await availablityCheckApi(dateTime, endTime);
            if (result == "available") {
              slotItem.isBooked = true;
              setState(() {});
            } else if (result == null) {
              AppConstants().showToast(
                  msg:
                      "The slot you are selecting has passed so try to select another slot.");
            } else if (result == "not available") {
              AppConstants().showToast(msg: "This slot is not available.");
            }
          }
        },
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 19, vertical: 12),
          // margin:
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: slotItem.isBooked
                ? AppColors.appColor_color
                : AppColors.availableBackgroundColor
            // : AppColors.notavailableBackgroundColor
          ),
          child: Text(
            "${slotItem.from}",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                // color:AppColors.availableTextColor
                color: slotItem.isBooked
                    ? Colors.white
                    : AppColors.availableTextColor
                // : AppColors.notavailableTextColor,
                ),
          ),
        ),
      ),
    );
  }

  _bottomBookingButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 19),
      child: CustomButton(
          onPressed: () {
            if (dateTime.isEmpty) {
              AppConstants().showToast(msg: "Please select the slot");
            } else {
              _bookingConfirmapi(dateTime, endTime);
            }
          },
          text: AppStrings.continueText),
    );
  }

  _bookingConfirmapi(String startTime, String endTime) async {
    if (await ApiManager.checkInternet()) {
      if (mounted)
        setState(() {
          isLoading = true;
        });
      Map<String, dynamic> request = new HashMap();
      print("uuuuuuuuuusssssssssseeeerrrr"+user.id.toString());

      request["courts_id"] = "${widget.courtid}";
      request["locations_id"] = "${widget.locationid}";
      request["pitch_id"] = "${widget.pitchid}";
      request["users_id"] = "${user.id}";
      request["booking_date"] = "$_currentDate2";
      request["booking_slot"] = "$startTime to $endTime";
      request["booking_slot_start_time"] = "$startTime";
      request["booking_slot_end_time"] = "$endTime";
      request["price"] = "${widget.price}";

      // request["booking_slot_start_time"] = "$startTime";
      // request["booking_slot_end_time"] = "$endTime";
      // CommonResponse response = new CommonResponse.fromJson(await ApiManager()
      //     .postCallWithHeader(
      //         AppStrings.AVAILABILITY_URL + "/2" + "/availability",
      //         request,
      //         context));
      BookingConfirmedResponse response = new BookingConfirmedResponse.fromJson(
        await ApiManager().postCallWithHeader(
            AppStrings.BOOKING_CONFIRM_URL, request, context),
      );
      // print(response.timeslots.length);
      // api call
      // TimeSlotResponse response = new TimeSlotResponse.fromJson(await ApiManager()
      //     .postCallWithHeader(AppStrings.PRODUCT_URL, request, context));

      if (response != null) {
        if (response.message == "booking successfully") {
          if (mounted)
            setState(() {
              isLoading = false;
            });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingConfirmed(),
            ),
          );
          AppConstants().showToast(msg: response.message);
        }
        if (mounted)
          setState(() {
            isLoading = false;
          });
        setState(() {});
      } else {
        if (mounted)
          setState(() {
            isLoading = false;
          });
        if (mounted) setState(() {});
      }
      if (mounted)
        setState(() {
          isLoading = false;
        });
    }
  }
}
