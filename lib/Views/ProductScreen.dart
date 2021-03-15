import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Constants/AppColors.dart';
import 'package:my_app/Constants/AppConstants.dart';
import 'package:my_app/Constants/AppStrings.dart';
import 'package:my_app/Constants/AppTextStyles.dart';
import 'package:my_app/Models/AddToCartResponse.dart';
import 'package:my_app/Views/Cart.dart';
import 'package:my_app/Widgets/custom_background_common_View.dart';
import 'package:my_app/Widgets/custom_button.dart';
import 'dart:collection';
import 'package:my_app/Utils/ApiManager.dart';
import 'package:my_app/Models/ProductResponse.dart';


class ProductScreen extends StatefulWidget {
  int bookingId, userId, pitchId,courtId;

  ProductScreen(
      {@required this.bookingId,
      @required this.userId,
        @required this.courtId,
      @required this.pitchId});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<ProductData> products = [];

  bool isLoading = false;
  int service = 0;

  getProduct() async {
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
      // request["booking_date"] = "${requestDateFormate.format(booking_date)}";
      // TimeSlotResponse response = new TimeSlotResponse.fromJson(
      //     await ApiManager().postCallWithHeader(
      //         AppStrings.PITCH_TIME_SLOT_URL + "/$id", request, context)); //
      // print(response.timeslots.length);
      // api call
      ProductResponse response = new ProductResponse.fromJson(
        await ApiManager()
            .postCallWithHeader(AppStrings.PRODUCT_URL + "/${widget.courtId}", request, context),
      );
      if (response != null) {
        if (response.status == 200) {
          if (mounted)
            setState(() {
              isLoading = false;
            });

          products = response.result;
          setState(() {});
        }
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
              .postCallWithHeader(AppStrings.ADD_TO_CART, request, context),);
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
        print(response.product);
        if (mounted)
          setState(() {
            isLoading = false;
          });
        service = response.product.id;



        setState(() {});

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

  removefromCart({int serviceId}) async {
    if (await ApiManager.checkInternet()) {
      if (mounted)
        setState(() {
          isLoading = true;
        });
      Map<String, dynamic> request = new HashMap();
      // request["bookings_id"] = "${widget.bookingId}";
      // request["users_id"] = "${widget.userId}";
      // request["price"] = "$price";
      // request["services_id"] = "$serviceId";
      AddToCartresponse response = new AddToCartresponse.fromJson(
        await ApiManager().postCallWithHeader(
            AppStrings.DECREMENT_URL + "/$service", request, context),
      );
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
        print(response.product);
        if (mounted)
          setState(() {
            isLoading = false;
          });

        setState(() {});

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
    }else {
      AppConstants().showToast(msg:"Internet is not available");
    }
  }

  void initState() {
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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

  mainBody() {
    return BackgroundCurvedView(
        widget: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: _productGridView(),
          )
        ],
      ),
    ));
  }

  _header() {
    return Container(
      padding: EdgeInsets.only(left: 0, right: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppConstants()
              .header(text: AppStrings.productsText, context: context),
          Stack(
            alignment: Alignment.topRight,
            overflow: Overflow.visible,
            children: [
              Image.asset(
                "assets/images/cart.png",
                width: 33,
                height: 29,
              ),
              Positioned(
                left: 22,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 0.8, horizontal: 5),
                  decoration:
                      BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  child: Text(
                    "1",
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

  _productGridView() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        products != null
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20),
                padding: EdgeInsets.fromLTRB(17, 24, 17, 80),
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.16),
                            blurRadius: 9,
                            offset: Offset(0, 0)),
                      ]),
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: AppConstants.imageLoader(
                                "${products[index].image}",
                                "",
                              ),
                            ),
                          ),
                          // SizedBox(height: 14),
                          Text(
                            "${products[index].title}",
                            style: AppTextStyles.textStyle12medium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$ ${products[index].price}",
                                style: AppTextStyles.smallTextStyleWithColor14,
                              ),
                              // _quantitySelector(),

                              products[index].qty == 0
                                  ? _addtoCartButton(
                                      text: "Add to Cart", qty: products[index])
                                  : _quantitySelector(products[index])
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ));
                })
            : Center(child: Text("No products available\nbut you can continue",textAlign: TextAlign.center,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
        _bottomContinueButton()
      ],
    );
  }

  _addtoCartButton({text, ProductData qty}) {
    return Container(
      child: Material(
        // onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: AppColors.lightGreenText_color,
        // height: 30,
        // minWidth: 82,
        child: InkWell(
          onTap: () {
            print(qty.qty);
            addtocartapi(price: qty.price, serviceId: qty.id);

            setState(() {
              qty.qty = ++qty.qty;
            });
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
            child: Text(
              text,
              style: AppTextStyles.textStyle12regular,
            ),
          ),
        ),
        // padding: const EdgeInsets.fromLTRB(11, 4, 10, 4),
      ),
    );
  }

  _bottomContinueButton() {
    return Visibility(
      visible: products.length == 0 ? false : true,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(21.0, 0.0, 21.0, 20.0),
        child: CustomButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Cart(
                            pitchId: widget.pitchId,
                            bookingId: widget.bookingId,
                            userId: widget.userId,
                          )));
            },
            text: AppStrings.continueText),
      ),
    );
  }

  _quantitySelector(ProductData qty) {
    return Row(
      children: [
        Material(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: AppColors.lightGreenText_color,
          child: InkWell(
            onTap: () {
              addtocartapi(price: qty.price, serviceId: qty.id);

              setState(() {
                qty.qty = qty.qty - 1;

                removefromCart(serviceId: qty.id);
                // widget.item.decrement();
                //
                // widget.fn();
              });
            },
            highlightColor: AppColors.lightGreenText_color,
            child: Container(
              padding: EdgeInsets.all(6),
              child: Icon(
                Icons.remove,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "${qty.qty}",
          textAlign: TextAlign.left,
          maxLines: 2,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 0.27,
            color: AppColors.lightGreenText_color,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Material(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: AppColors.lightGreenText_color,
          child: InkWell(
            onTap: () {
              addtocartapi(price: qty.price, serviceId: qty.id);

              setState(() {
                qty.qty = qty.qty + 1;
                // widget.item.increment();
                //
                // widget.fn();
              });
            },
            highlightColor: AppColors.appColor_color,
            child: Container(
              padding: EdgeInsets.all(6),
              child: Icon(
                Icons.add,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
