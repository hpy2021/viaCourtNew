import 'dart:collection';
import 'dart:io';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/Constants/AppColors.dart';
import 'package:my_app/Constants/AppConstants.dart';
import 'package:my_app/Constants/AppStrings.dart';
import 'package:my_app/Constants/AppTextStyles.dart';
import 'package:my_app/Models/AddToCartResponse.dart';
import 'package:my_app/Models/CartItemModel.dart';
import 'package:my_app/Models/CommonResponse.dart';
import 'package:my_app/Models/ProductResponse.dart';
import 'package:my_app/Utils/ApiManager.dart';
import 'package:my_app/Views/checkOutPage.dart';
import 'package:my_app/Widgets/custom_background_common_View.dart';
import 'package:my_app/Widgets/custom_button.dart';
import 'package:my_app/Models/CartResposne.dart';
import 'package:my_app/Constants/Applocalization.dart';

class Cart extends StatefulWidget {
  int pitchId, bookingId, userId;

  Cart({@required this.pitchId, this.bookingId, this.userId});

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  int qty = 1;
  int subTotal, total;
  List<CartItemModel> cartItemList = List();
  List<ServiceData> serviceList = [];
  Pitch pitchData;
  int sum = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCart();
  }

  bool isLoading = false;

  getCart() async {
    if (await ApiManager.checkInternet()) {
      if (mounted)
        setState(() {
          isLoading = true;
        });
      Map<String, dynamic> request = new HashMap();
      request["users_id"] = "${widget.userId}";
      request["bookings_id"] = "${widget.bookingId}";
      request["pitch_id"] = "${widget.pitchId}";

      CartResponse response = new CartResponse.fromJson(
        await ApiManager()
            .postCallWithHeader(AppStrings.CART_URL, request, context),
      );
      if (response != null) {
        if (mounted)
          setState(() {
            isLoading = false;
          });
        serviceList = response.service;
        pitchData = response.pitch;
        sum = 0;
        response.service.forEach((element) {
          sum += element.total;
        });
        subTotal = sum;
        total = sum + pitchData.price;
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
    } else {
      AppConstants().showToast(msg: "Internet is not available");
    }
  }

  addtocartapi({int price, int serviceId}) async {
    if (await ApiManager.checkInternet()) {
      if (mounted)
        setState(() {
          isLoading = true;
        });
      Map<String, dynamic> request = new HashMap();
      request["bookings_id"] = "${widget.bookingId}";
      request["users_id"] = "${widget.userId}";
      request["price"] = "$price";
      request["services_id"] = "$serviceId";
      AddToCartresponse response = new AddToCartresponse.fromJson(
          await ApiManager()
              .postCallWithHeader(AppStrings.ADD_TO_CART, request, context));
      if (response != null) {
        print(response.product);
        if (mounted)
          setState(() {
            isLoading = false;
          });
        getCart();

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
    } else {
      AppConstants().showToast(msg: "Internet is not available");
    }
  }

  removefromCart({int serviceId}) async {
    if (await ApiManager.checkInternet()) {
      if (mounted)
        setState(() {
          isLoading = true;
        });
      Map<String, dynamic> request = new HashMap();
      CommonResponse response = new CommonResponse.fromJson(
        await ApiManager().postCallWithHeader(
            AppStrings.DECREMENT_URL + "/$serviceId", request, context),
      );
      if (response != null) {
        // print(response.product);
        if (mounted)
          setState(() {
            isLoading = false;
          });
        getCart();

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
    } else {
      AppConstants().showToast(msg: "Internet is not available");
    }
  }

  @override
  Widget build(BuildContext context) {
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
          _header(),
          SizedBox(
            height: 13,
          ),
          Flexible(child: mainBody())
        ],
      ),
    );
  }

  _header() {
    return Container(
      padding: EdgeInsets.only(
          left: Platform.localeName == "en_US" ? 0 : 16,
          right: Platform.localeName == "en_US" ? 28 : 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppConstants().header(
              text: AppLocalizations.of(context).translate("cartText"),
              context: context),
          Stack(
            alignment: Alignment.topRight,
            overflow: Overflow.visible,
            children: [
              Image.asset(
                "assets/images/cart.png",
                width: 33,
                height: 29,
                fit: BoxFit.contain,
              ),
              Positioned(
                left: 22,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 0.8, horizontal: 5),
                  decoration:
                      BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  child: Text(
                    "3",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
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
          _headerOfListView(),
          Expanded(
            child: cartBodyView(),
          ),
          // _subTotalView(),
          SizedBox(
            height: 9,
          ),
          _totalView(),
          SizedBox(
            height: 17,
          ),
          _bottomButton(),
          SizedBox(
            height: 24,
          )
        ],
      ),
    ));
  }

  _headerOfListView() {
    return Container(
      margin: EdgeInsets.fromLTRB(17, 28, 17, 0),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        secondaryActions: <Widget>[
          Container(
            width: 59,
            height: 59,
            color: AppColors.yellowColor,
            child: Icon(
              FontAwesomeIcons.pencilAlt,
              color: Colors.white,
            ),
          ),
          Container(
            width: 59,
            height: 59,
            color: AppColors.pinkColor,
            child: Icon(
              FontAwesomeIcons.trashAlt,
              color: Colors.white,
            ),
          ),
        ],
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffD5F1F2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(7, 14, 12, 14),
            child: Row(
              children: [
                pitchData == null
                    ? Container()
                    : pitchData.pitchImage == null
                        ? Container()
                        : Image.network(
                            "${AppStrings.IMGBASE_URL + pitchData.pitchImage}",
                            height: 31,
                            width: 44,
                            fit: BoxFit.cover,
                            // loadingBuilder: (context, child, loadingProgress) =>
                            //     Padding(
                            //   padding: const EdgeInsets.all(20.0),
                            //   child: SpinKitCircle(
                            //     color: AppColors.appColor_color,
                            //     size: 20,
                            //   ),
                            // ),
                            errorBuilder: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                SizedBox(
                  width: 7,
                ),
                Expanded(
                    child: Text(
                  pitchData == null
                      ? ""
                      : pitchData.name != null
                          ? pitchData.name
                          : "",
                  style: AppTextStyles.textStyle14grey,
                )),
                Text(
                  "Qty: 1",
                  style: AppTextStyles.textStyle14grey,
                ),
                SizedBox(
                  width: 50,
                ),
                Text(
                  pitchData == null
                      ? ""
                      : pitchData.price == null
                          ? pitchData.price
                          : "\$ ${pitchData.price}",
                  style: AppTextStyles.textStyle14grey,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  cartBodyView() {
    return Container(
      child: ListView.builder(
          padding: EdgeInsets.fromLTRB(17, 10, 17, 10),
          itemCount: serviceList.length,
          itemBuilder: (BuildContext context, int index) {
            return _cartBodyItemView(serviceList[index], index);
          }),
    );
  }

  _cartBodyItemView(ServiceData item, int index) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffD5F1F2),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10))),
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.fromLTRB(7, 14, 12, 14),
      child: Row(
        children: [
          Image.network(
            "${AppStrings.IMGBASE_URL + item.image}",
            height: 31,
            width: 44,
            fit: BoxFit.contain,
            // loadingBuilder: (context, child, loadingProgress) => Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: SpinKitCircle(
            //     color: AppColors.appColor_color,
            //     size: 20,
            //   ),
            // ),
            errorBuilder: (context, url, error) => Icon(Icons.error),
          ),
          SizedBox(
            width: 7,
          ),
          Expanded(
              child: Container(
            child: Text(
              item.title,
              style: AppTextStyles.textStyle14grey,
            ),
          )),
          _quantityIncremented(item),
          SizedBox(
            width: 42,
          ),
          Text(
            "\$ ${item.total}",
            style: AppTextStyles.textStyle14grey,
          )
        ],
      ),
    );
  }

  _quantityIncremented(ServiceData qty) {
    return Container(
      child: Row(
        children: [
          Container(
            child: InkWell(
              onTap: () {
                // if (qty.qty > 1) {
                qty.qty = --qty.qty;
                removefromCart(serviceId: qty.id);
                // getCart();
                // }

                setState(() {});
              },
              child: Icon(
                FontAwesomeIcons.minus,
                size: 15,
                color: AppColors.border_color,
              ),
            ),
          ),
          SizedBox(
            width: 11,
          ),
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xffC2DCD4),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              child: Text(
                "${qty.qty}",
                style: TextStyle(fontSize: 14),
              )),
          SizedBox(
            width: 11,
          ),
          Container(
            child: InkWell(
                onTap: () {
                  setState(
                    () {
                      qty.qty = qty.qty + 1;
                      addtocartapi(serviceId: qty.servicesId, price: qty.price);
                    },
                  );
                },
                child: Icon(
                  FontAwesomeIcons.plus,
                  color: AppColors.border_color,
                  size: 15,
                )),
          ),
        ],
      ),
    );
  }

  _totalView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Row(
        children: [
          Expanded(
              child: Text(
            "Total",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          )),
          Text(
            "\$ ${total ?? 0}",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  _bottomButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: CustomButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CheckOutPage(
                          price: "$total",
                          bookingId: widget.bookingId,
                        )));
          },
          text:
              AppLocalizations.of(context).translate("proceedToCheckOutText")),
    );
  }
}
