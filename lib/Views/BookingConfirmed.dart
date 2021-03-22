import 'dart:collection';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Constants/AppColors.dart';
import 'package:my_app/Constants/AppConstants.dart';
import 'package:my_app/Constants/AppStrings.dart';
import 'package:my_app/Constants/AppTextStyles.dart';
import 'package:my_app/Models/BookingConfirmedResponse.dart';
import 'package:my_app/Models/CommonResponse.dart';
import 'package:my_app/Models/userResponse.dart';
import 'package:my_app/Utils/ApiManager.dart';
import 'package:my_app/Views/ProductScreen.dart';
import 'package:my_app/Widgets/custom_background_common_View.dart';
import 'package:my_app/Widgets/custom_button.dart';

class BookingConfirmed extends StatefulWidget {
  Booking booking;
  String courtName;
  String bookedDate, bookingSlotEndTime, bookingSlotStartTime;
  int pitchId, price, courtId;
  DateTime selectedDate;

  BookingConfirmed(
      {this.courtName,
      this.bookedDate,
      this.bookingSlotEndTime,
      this.bookingSlotStartTime,
      @required this.pitchId,
      @required this.selectedDate,
      this.price,
      this.courtId});

  @override
  _BookingConfirmedState createState() => _BookingConfirmedState();
}

class _BookingConfirmedState extends State<BookingConfirmed> {
  List<SportsItemView> sportsItemList = [];
  List<SportsItemView> availableItemList = [];
  bool isLoading = false;
  UserResponse user;

  @override
  void initState() {
    // print(widget.booking.price);
    // TODO: implement initState
    super.initState();
    userApiCall();
    sportsItemList.add(SportsItemView(
        text: "Football", imageUrl: "assets/images/footBall.png"));
    sportsItemList.add(SportsItemView(
        text: "BoxCricket", imageUrl: "assets/images/cricket.png"));
    availableItemList.add(SportsItemView(
        text: "", imageUrl: "assets/images/footBall.png", isSelected: false));
    availableItemList.add(SportsItemView(
        text: "", imageUrl: "assets/images/bottle.png", isSelected: true));
    availableItemList.add(SportsItemView(
        text: "", imageUrl: "assets/images/tshirt.png", isSelected: false));
    availableItemList.add(SportsItemView(
        text: "", imageUrl: "assets/images/rugby.png", isSelected: false));
  }

  String _startTime, _endTime, bookedDate;

  _data() {
    _startTime = DateFormat("HH:mm a")
        .format(DateTime.parse("${widget.bookingSlotStartTime}"));
    _endTime = DateFormat("HH:mm a")
        .format(DateTime.parse("${widget.bookingSlotEndTime}"));
    print(_startTime + " sdfasdfasdf " + _endTime);
    bookedDate = DateFormat("MMMM dd, yyyy")
        .format(DateTime.parse("${widget.bookedDate}"));
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

  availablityCheckApi() async {
    if (await ApiManager.checkInternet()) {
      if (mounted)
        setState(() {
          isLoading = true;
        });
      Map<String, dynamic> request = new HashMap();

      // request["courts_id"] = "${widget.courtid}";
      // request["locations_id"] = "${widget.locationid}";
      // request["pitch_id"] = "${widget.pitchid}";
      // request["users_id"] = "${widget.courtid}";
      // request["booking_date"] = "$_currentDate2";
      // request["booking_slot"] = "${startTime + " to "+ endTime}";
      // request["booking_slot_start_time"] = "$startTime";
      // request["booking_slot_end_time"] = "$endTime";
      // request["price"] = "${widget.price}";

      request["bookings_id"] = "102";
      request["users_id"] = "1";
      request["price"] = "223";
      request["services_id"] = "1";
      CommonResponse response = new CommonResponse.fromJson(await ApiManager()
          .postCallWithHeader(AppStrings.ADD_TO_CART, request, context));
      // CommonResponse response = new CommonResponse.fromJson(await ApiManager()
      //     .postCallWithHeader(
      //     AppStrings.BOOKING_CONFIRM_URL,
      //     request,
      //     context));

      //
      // print(response.timeslots.length);
      // api call
      // TimeSlotResponse response = new TimeSlotResponse.fromJson(await ApiManager()
      //     .postCallWithHeader(AppStrings.PRODUCT_URL, request, context));
      if (response != null) {
        print(response.result);
        if (mounted)
          setState(() {
            isLoading = false;
          });
        // result = response.result;
        setState(() {});

        return response.result;
        // if (response.timeslots == null) {
        // slotItemList.clear();
        // slotItemList == null;
      } else {
        if (mounted)
          setState(() {
            isLoading = false;
          });
        // slotItemList = response.timeslots;

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
    _data();
    // isLoading = false;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 46,
          ),
          AppConstants()
              .header(text: AppStrings.reviewbookingText, context: context),
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
      padding: EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 27,
          ),
          _imageView(),
          SizedBox(
            height: 20,
          ),
          _detailsView(),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0.0, right: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: AppColors.appColor_color,
                  size: 25,
                ),
                SizedBox(width: 5.7),
                Expanded(
                    child: Text(
                  // "${data.address1 == null ? "Address" : data.address1}",
                  "Soccer City Ave Nasrec, Johnesburg, 2147, South Africa",
                  style: AppTextStyles.textStyle14green,
                ))
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          _iconTextWidget(
              text: "$bookedDate", icon: Icons.calendar_today_outlined),
          // text: "January 29, 2021", icon: Icons.calendar_today_outlined),
          SizedBox(
            height: 16,
          ),
          _iconTextWidget(
              text: "$_startTime - $_endTime",
              icon: Icons.access_time_outlined),
          // text: "10:30 AM - 11:20 AM", icon: Icons.access_time_outlined),
          Expanded(
            child: SizedBox(
              height: 16,
            ),
          ),
          // Divider(
          //   thickness: 1,
          //   color: Color(0xffCECECE),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // Text("Available Sports",
          //     style: AppTextStyles.textStyle14mediumblack),
          // SizedBox(
          //   height: 15,
          // ),
          // Container(
          //     height: 38,
          //     width: double.infinity,
          //     child: _availableSportList()),
          // SizedBox(
          //   height: 16,
          // ),
          // Divider(
          //   thickness: 1,
          //   color: Color(0xffCECECE),
          // ),
          // Expanded(child: Container(),),
          // SizedBox(
          //   height: 10,http://cb548057bf17.ngrok.io/api/addToCart
          //
          // 'bookings_id' => 'required',
          // 'users_id' =>'required',
          // 'price'=> 'required',
          // 'services_id' =>'required',
          // ),
          // Text("Available Items",
          //     style: AppTextStyles.textStyle14mediumblack),
          //
          // SizedBox(
          //   height: 9,
          // ),
          // Container(
          //     height: 50,
          //     width: double.infinity,
          //     child: _additionalItemsView()),
          SizedBox(
            height: 21,
          ),
          _bottomContinueButton(),
          SizedBox(
            height: 20,
          ),
          // _SizedBox(
          //               height: 21,
          //             ),availableSportList()
        ],
      ),
    ));
  }

  _imageView() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          foregroundDecoration: BoxDecoration(
              color: Colors.black.withOpacity(0.39),
              borderRadius: BorderRadius.circular(10)),
          child: Image.asset(
            "assets/images/pitchImage.png",
            height: 149,
            width: 370,
          ),
        ),
        _onImageText()
      ],
    );
  }

  _onImageText() {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.appColor_color,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 28,
            ),
          ),
          SizedBox(width: 8),
          Text(
            "Please review your booking",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
          )
        ],
      ),
    );
  }

  _detailsView() {
    return Container(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title:
            Text("${widget.courtName}", style: AppTextStyles.textStyle18medium),
        trailing: Text("\$ ${widget.price.round()}",
            style: AppTextStyles.textStyle18mediumwithGreen),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Lorem ipsum dolor sit", style: AppTextStyles.textStyle14grey),
            Text("Width : 58 ft/17.68 m, Lenth : 6 ft/1.83 m.",
                style: AppTextStyles.textStyle14grey),
          ],
        ),
      ),
    );
  }

  _iconTextWidget({IconData icon, String text}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 25,
          color: AppColors.appColor_color,
        ),
        SizedBox(
          width: 5.7,
        ),
        Text(text, style: AppTextStyles.textStyle14green)
      ],
    );
  }

  _availableSportList() {
    return Container(
        child: ListView.builder(
            itemCount: sportsItemList.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return _availableSportsItemView(sportsItemList[index]);
            }));
  }

  _availableSportsItemView(SportsItemView item) {
    return Container(
        padding: EdgeInsets.only(right: 17),
        child: Column(
          children: [
            Image.asset(
              item.imageUrl,
              height: 21,
              width: 21,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 2.4),
            Text(item.text,
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff666666),
                    fontWeight: FontWeight.w500))
          ],
        ));
  }

  _additionalItemsView() {
    return Container(
      child: ListView.builder(
          itemCount: availableItemList.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (BuildContext ctx, int index) {
            return InkWell(
              onTap: () {
                availableItemList[index].isSelected =
                    !availableItemList[index].isSelected;
                setState(() {});
              },
              child: Container(
                  margin: EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                      color: availableItemList[index].isSelected
                          ? AppColors.selectedColor
                          : AppColors.notselectedColor,
                      borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Image.asset(
                    availableItemList[index].imageUrl,
                    height: 37,
                    width: 37,
                    color: availableItemList[index].isSelected
                        ? AppColors.selectedItemColor
                        : AppColors.notselectedItemColor,
                  )),
            );
          }),
    );
  }

  _bottomContinueButton() {
    return CustomButton(
        onPressed: () {
          print(widget.selectedDate);
          _bookingConfirmapi(
              widget.bookingSlotStartTime, widget.bookingSlotEndTime);
          // availablityCheckApi();
        },
        text: AppStrings.confirmText);
  }

  _bookingConfirmapi(String startTime, String endTime) async {
    if (await ApiManager.checkInternet()) {
      if (mounted)
        setState(() {
          isLoading = true;
        });
      Map<String, dynamic> request = new HashMap();

      var requestDateFormate = DateFormat("yyyy-MM-dd");
      request["courts_id"] = "${widget.courtId}";
      // request["locations_id"] = "${widget.locationid}";
      request["pitch_id"] = "${widget.pitchId}";
      request["users_id"] = "${user.id}";
      request["booking_date"] = requestDateFormate.format(widget.selectedDate);
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

      if (response.message == "booking successfully") {
        if (mounted)
          setState(() {
            isLoading = false;
          });

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(
              courtId: response.booking.courtsId,
              bookingId: response.booking.id,
              userId: int.parse(response.booking.usersId),
              pitchId: response.booking.pitchId,
            ),
          ), (route) => false
        );
        AppConstants().showToast(msg: response.message);
      } else {
        AppConstants().showToast(
            msg: "This slot is already taken please select another slot");
        if (mounted)
          setState(() {
            isLoading = false;
          });
      }
      setState(() {});

      if (mounted)
        setState(() {
          isLoading = false;
        });
    } else {
      if (mounted)
        setState(() {
          isLoading = false;
        });
      AppConstants().showToast(msg: "Internet is not available");
    }
  }
}

class SportsItemView {
  String imageUrl, text;

  bool isSelected = false;

  SportsItemView({this.text, this.imageUrl, this.isSelected});
}
