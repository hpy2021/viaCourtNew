import 'dart:collection';

import 'package:easy_localization/easy_localization.dart';
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
import 'package:my_app/Models/SlotItemModel.dart';
import 'package:my_app/Models/TimeSlotResponse.dart';
import 'package:my_app/Models/userResponse.dart';
import 'package:my_app/Utils/ApiManager.dart';
import 'package:my_app/Views/BookingConfirmed.dart';
import 'package:my_app/Views/HomeScreen.dart';
import 'package:my_app/Views/SelectDateScreen.dart';
import 'package:my_app/Widgets/custom_button.dart';
import 'package:my_app/Constants/Applocalization.dart';

class SelectTimeSlot extends StatefulWidget {
  int pitchId, price, courtId;
  DateTime selectedDate;
  String courtName;

  // int pitchId;
  SelectTimeSlot(
      {@required this.pitchId,
      this.courtName,
      @required this.selectedDate,
      this.price,
      this.courtId});

  @override
  _SelectTimeSlotState createState() => _SelectTimeSlotState();
}

class _SelectTimeSlotState extends State<SelectTimeSlot> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userApiCall();
    getSlots(id: widget.pitchId, booking_date: widget.selectedDate);
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
        print(user.firstname);
        user = user;
        setState(() {});
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
      print("askdlalksd ${id}");
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
                  "/${widget.pitchId}" +
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
          AppConstants().header(
              text: AppLocalizations.of(context).translate("selectSlot"),
              context: context),
          SizedBox(
            height: 13,
          ),
          Expanded(child: calenderView())
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
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                roundedCornerTextView(),
                _slotsView(),
                Expanded(child: SizedBox()),
                _bottomBookingButton()
              ],
            )));
  }

  navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectDateScreen(
          //     courtid: widget.pitchId,
          //     locationid: widget.locationId,
          // pitchId: courtList.id,
          // size: courtList.size,
          isFromPitch: false,
          // price: courtList.price,
        ),
      ),
    );
    widget.selectedDate = result;
    setState(() {});
    print(result);
  }

  roundedCornerTextView() {
    return InkWell(
      onTap: () async {
        navigateAndDisplaySelection(context);
      },
      child: Container(
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
              "${date2.format(widget.selectedDate)}",
              style: AppTextStyles.textStyle15medium,
            ),
            Icon(
              Icons.calendar_today_outlined,
              color: AppColors.appColor_color,
            )
          ],
        ),
      ),
    );
  }

  bool isForOnetime = false;

  _slotsView() {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: slotItemList == null
          ? Center(
              child: Text(
              "No slots available",
              style: AppTextStyles.textStyle14grey,
            ))
          : Wrap(
              children: List<Widget>.generate(slotItemList.length, (index) {
                if (isForOnetime) {
                  slotItemList.forEach((element) {
                    if (element.isBooked) {
                      element.isBooked = false;
                    }
                    print(element.isBooked);
                    isForOnetime = false;
                  });
                }

                return _slotsListItemView2(slotItemList[index]);
              }).toList(),
            ),
    );
  }

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
        // color:  AppColors.availableBackgroundColor,
        elevation: 0,
        highlightElevation: 0,

        padding: EdgeInsets.symmetric(horizontal: 19, vertical: 12),
        // onPressed: (){
        //
        // },

        onPressed: () async {
          if (slotItem.isBooked == true) {
            slotItem.isBooked = false;
            dateTime = "";
            endTime = "";
            setState(() {});
          } else {
            isForOnetime = true;
            var time = "${slotItem.from}";
            dateTime = DateFormat("yyyy-MM-dd").format(widget.selectedDate);
            dateTime = dateTime + " " + time + ":" + "00";
            print(dateTime);
            var endtime = "${slotItem.to}";
            endTime = DateFormat("yyyy-MM-dd").format(widget.selectedDate);
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
            // color: slotItem.isBooked
            //     ? AppColors.appColor_color
            //     : AppColors.availableBackgroundColor
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
                // color: AppColors.availableTextColor
                // : AppColors.notavailableTextColor,
                ),
          ),
        ),
      ),
    );
  }

  _slotsListItemView2(Timeslots slotItem) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 10, 9),
      child: InkWell(
        // radius: 2,

        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(5),
        // ),
        // color: slotItem.isBooked
        //     ? AppColors.appColor_color
        //     : AppColors.availableBackgroundColor,
        // // color:  AppColors.availableBackgroundColor,
        // elevation: 0,
        // highlightElevation: 0,
        //
        // padding: EdgeInsets.symmetric(horizontal: 19, vertical: 12),
        // // onPressed: (){
        // //
        // // },
        //
        onTap: () async {
          if (slotItem.isBooked == true) {
            slotItem.isBooked = false;
            dateTime = "";
            endTime = "";
            setState(() {});
          } else {
            isForOnetime = true;
            var time = "${slotItem.from}";
            dateTime = DateFormat("yyyy-MM-dd").format(widget.selectedDate);
            dateTime = dateTime + " " + time + ":" + "00";
            print(dateTime);
            var endtime = "${slotItem.to}";
            endTime = DateFormat("yyyy-MM-dd").format(widget.selectedDate);
            endTime = endTime + " " + endtime + ":" + "00";
            await availablityCheckApi(dateTime, endTime);
            if (result == "available") {
              slotItem.isBooked = true;
              setState(() {});
            } else if (result == null) {
              AppConstants().showToast(
                  msg: AppLocalizations.of(context)
                      .translate("selectedSlottimeValidationpassed"));
            } else if (result == "not available") {
              AppConstants().showToast(
                  msg: AppLocalizations.of(context)
                      .translate("notAvailableText"));
            }
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 19, vertical: 12),
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
                // color: AppColors.availableTextColor
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
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => BookingConfirmed(),
            //   ),
            // );
            print(dateTime);
            if (dateTime == null || dateTime == "") {
              AppConstants().showToast(
                  msg: AppLocalizations.of(context)
                      .translate("selectSlotValidation"));
            } else {
              // print(widget.selectedDate);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingConfirmed(
                    bookingSlotStartTime: dateTime,
                    bookingSlotEndTime: endTime,
                    price: widget.price,
                    pitchId: widget.pitchId,
                    courtId: widget.courtId,
                    selectedDate: widget.selectedDate,
                    bookedDate: widget.selectedDate.toString(),
                    courtName: widget.courtName,

                    //      = widget.courtId;
                    //     // request["locations_id"] = "${widget.locationid}";
                    //     request["pitch_id"] = "${widget.pitchId}";
                    // request["users_id"] = "${user.id}";
                    //     request["booking_date"] = "${widget.selectedDate}";
                    // request["booking_slot"] = "$startTime to $endTime";
                    //     request["booking_slot_start_time"] = "$startTime";
                    // request["booking_slot_end_time"] = "$endTime";
                    // request["price"] = "${widget.price}";

                    // booking: response.booking,
                    // courtName: courtName,
                  ),
                ),
              );
              // _bookingConfirmapi(dateTime, endTime);
            }
          },
          text: AppLocalizations.of(context).translate("bookText")),
    );
  }

  _bookingConfirmapi(String startTime, String endTime) async {
    if (await ApiManager.checkInternet()) {
      if (mounted)
        setState(() {
          isLoading = true;
        });
      Map<String, dynamic> request = new HashMap();

      request["courts_id"] = "${widget.courtId}";
      // request["locations_id"] = "${widget.locationid}";
      request["pitch_id"] = "${widget.pitchId}";
      request["users_id"] = "${user.id}";
      request["booking_date"] = "${widget.selectedDate}";
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
          String courtName;
          response.court.forEach((element) {
            setState(() {
              courtName = element.title;
            });
          });

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingConfirmed(
                // booking: response.booking,
                courtName: courtName,
              ),
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
        setState(
          () {
            isLoading = false;
          },
        );
    }
  }
}
