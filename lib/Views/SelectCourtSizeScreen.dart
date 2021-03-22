import 'dart:collection';
import 'dart:io';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:my_app/Constants/AppColors.dart';
import 'package:my_app/Constants/AppConstants.dart';
import 'package:my_app/Constants/AppStrings.dart';
import 'package:my_app/Constants/AppTextStyles.dart';
import 'package:my_app/Models/CourtListModel.dart';
import 'package:my_app/Models/PitchResponse.dart';
import 'package:my_app/Provider/CourtProvider.dart';
import 'package:my_app/Utils/ApiManager.dart';
import 'package:my_app/Views/SelectDateScreen.dart';
import 'package:my_app/Views/SelectSlot.dart';
import 'package:http/http.dart' as http;

class SelectCourtSize extends StatefulWidget {
  // int pitchId, locationId;

  // SelectCourtSize({@required this.pitchId, this.locationId});

  @override
  _SelectCourtSizeState createState() => _SelectCourtSizeState();
}

class _SelectCourtSizeState extends State<SelectCourtSize> {
  List<PitchData> pitchList = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getCourtSize(widget.locationId);
    getCourtSize();

  }

  getCourtSize() async {
    if (await ApiManager.checkInternet()) {
      if (mounted)
        setState(() {
          isLoading = true;
        });
      // print(id);
      Map<String, dynamic> request = new HashMap();

      // request["name"] = "abc";
      // request["status"] = "Available";
      // request["email"] = "yash@gmail.com";
      // request["court_id"] = "3";
      // request["location_id"] = "1";
      // request["price"] = "50";
      // request["slote_duration"] = "2";
      // request["booking_date"] = "2021-02-27";
      // request["locations_id"] = widget.locationId;
      PitchesResponse response = new PitchesResponse.fromJson(await ApiManager()
          .getCallwithheader(
        // AppStrings.PITCHES_URL + "/" + widget.locationId.toString(),
        AppStrings.PITCHES_URL,

      ),); // api call
      // PitchesResponse response = new PitchesResponse.fromJson(await ApiManager()
      //     .postCallWithHeader(AppStrings.PITCH_TIME_SLOT_URL, request, context));
      if (response.status == 200) {
        if (mounted)
          setState(() {
            isLoading = false;
          });
        pitchList = response.result;

        if (mounted) setState(() {});
      }
      if (mounted)
        setState(() {
          isLoading = false;
        });
    }
    else {
      if (mounted)
        setState(() {
          isLoading = false;
        });
      AppConstants().showToast(msg:"Internet is not available");
    }
  }

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
            )),
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
              height: 13
          ),
          Expanded(child: _courtListView())
        ],
      ),
    );
  }

  _courtListView() {
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
        child: ListView.builder(
          padding: EdgeInsets.all(17),
          itemCount: pitchList.length,
          itemBuilder: (BuildContext context, int index) {
            return _courtListItemView(pitchList[index]);
          },),
      ),);
  }

  _courtListItemView(PitchData courtList) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          color: AppColors.itemListBackGroundColor),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectDateScreen(
              //     courtid: widget.pitchId,
              //     locationid: widget.locationId,
              pitchId: courtList.id,
              size: courtList.size,
              isFromPitch: true,
              // price: courtList.price,
            ),),),
        child: Column(
          children: [
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
//                 Container(
//                   child: ClipRRect(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(10),
//                         // topRight: Radius.circular(10),
//                       ),
//                       child: CachedNetworkImage(
//                         height: 100,
//                         width: 100,
//                         fit: BoxFit.cover,
//                         imageUrl: AppStrissngs.IMGBASE_URL + courtList.pitchImage,
//                         progressIndicatorBuilder:
//                             (context, url, downloadProgress) =>
//                                 Padding(
//                                   padding: const EdgeInsets.all(20.0),
//                                   child: SpinKitCircle(
// color: AppColors.appColor_color,
//                                       size: 50,),
//                                 ),
//                         errorWidget: (context, url, error) => Icon(Icons.error),
//                       )
//                       // child:AppConstants.imageLoader(courtList.pitchImage, "")
//                       // CachedNetworkImage(
//                       //   imageUrl: "http://via.placeholder.com/200x150",
//                       //   imageBuilder: (context, imageProvider) => Container(
//                       //     decoration: BoxDecoration(
//                       //       image: DecorationImage(
//                       //           image: imageProvider,
//                       //           fit: BoxFit.cover,
//                       //           colorFilter:
//                       //           ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
//                       //     ),
//                       //   ),
//                       //   placeholder: (context, url) => CircularProgressIndicator(),
//                       //   errorWidget: (context, url, error) => Icon(Icons.error),
//                       // ),
//                       // child: Image.network(
//                       //   "${AppStringss.IMGBASE_URL + courtList.pitchImage}",
//                       //   height: 100,
//                       //   width: 100,
//                       //   fit: BoxFit.cover,
//                       // ),
//                       ),
//                 ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 17, 0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Width",
                          style: AppTextStyles.textStyle14medium,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          ": 58 ft/17.68 m",
                          style: AppTextStyles.textStyle14grey,
                        ),)
                    ],
                  ),
                ),
                SizedBox(height: 5),

                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 17, 0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          AppStrings.sizeText,
                          style: AppTextStyles.textStyle14medium,
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Text(
                            ": ${courtList.size}",
                            style: AppTextStyles.textStyle14grey,
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 17, 0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "See Law",
                          style: AppTextStyles.textStyle14medium,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          ": 9.8 m",
                          style: AppTextStyles.textStyle14grey,
                        ),)
                    ],
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
            //   ],
            // ),

            // Padding(
            //   padding: EdgeInsets.fromLTRB(21, 0, 17, 0),
            //   child: Row(
            //     children: [
            //       Expanded(
            //           flex: 1,
            //           child: Text(
            //             AppStrings.SeeLawText,
            //             style: AppTextStyles.textStyle14medium,
            //           )),
            //       Expanded(
            //           flex: 3,
            //           child: Text(
            //             ":${courtList.seeLav}",
            //             style: AppTextStyles.textStyle14grey,
            //           ))
            //     ],
            //   ),
            // ),
            // SizedBox(height: 10),
            _bottomButton(courtList.price.toString())
          ],
        ),
      ),
    );
  }

  _bottomButton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.appColor_color,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      ),
      child: Text(
        "\$ ${text} / Hour",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  _header() {
    return Container(
      padding: EdgeInsets.only(left: 13, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr("selectCourttextSize"),
                style: AppTextStyles.textStyle25white,
              ),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 30,
                  ),
                  Positioned(
                    bottom: 15,
                    right: 2,
                    child: Container(
                      height: 11,
                      width: 11,
                      decoration:
                      BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    ),
                  )
                ],
              )
            ],
          ),
          Text(
            tr("listofCourttextsize"),
            style: TextStyle(color:Colors.white70,fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class CourtList {
  String width, length, seeLav, price;

  CourtList({this.width, this.length, this.seeLav, this.price});
}
