import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Constants/AppColors.dart';
import '../Constants/AppConstants.dart';
import '../Constants/AppStrings.dart';
import '../Constants/AppTextStyles.dart';
import '../Views/Confirmation.dart';
import '../Widgets/custom_background_common_View.dart';
import '../Widgets/custom_button.dart';

class CheckOutPage extends StatefulWidget {
  String price;

  CheckOutPage({this.price});

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  int _current = 0;
  List<Widget> cardList = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cardAdd();
  }

  _cardAdd() {
    cardList.add(Stack(
      children: [
        Container(
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/images/Clipped.png",
              width: 146,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 23, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("HOLDER NAME", style: _style(fontSize: 11)),
              SizedBox(height: 3),
              Text("YOUR NAME HERE", style: _style(fontSize: 16)),
              SizedBox(height: 27),
              Text("CARD NUMBER", style: _style(fontSize: 23)),
              SizedBox(height: 17),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("EXPRIRES DATE", style: _style(fontSize: 11)),
                      SizedBox(height: 9),
                      Text("**/**", style: _style(fontSize: 16)),
                    ],
                  ),
                  SizedBox(width: 88),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("CVV", style: _style(fontSize: 11)),
                      SizedBox(height: 9),
                      Text("* * *", style: _style(fontSize: 16)),
                    ],
                  ),
                ],
              )
            ],
          ),
        )
      ],
    ));
    cardList.add(Stack(
      children: [
        Container(
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/images/Clipped.png",
              width: 146,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 23, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("HOLDER NAME", style: _style(fontSize: 11)),
              SizedBox(height: 3),
              Text("YOUR NAME HERE", style: _style(fontSize: 16)),
              SizedBox(height: 27),
              Text("CARD NUMBER", style: _style(fontSize: 23)),
              SizedBox(height: 17),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("EXPRIRES DATE", style: _style(fontSize: 11)),
                      SizedBox(height: 9),
                      Text("**/**", style: _style(fontSize: 16)),
                    ],
                  ),
                  SizedBox(width: 88),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("CVV", style: _style(fontSize: 11)),
                      SizedBox(height: 9),
                      Text("* * *", style: _style(fontSize: 16)),
                    ],
                  ),
                ],
              )
            ],
          ),
        )
      ],
    ));
    cardList.add(Stack(
      children: [
        Container(
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/images/Clipped.png",
              width: 146,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 23, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("HOLDER NAME", style: _style(fontSize: 11)),
              SizedBox(height: 3),
              Text("YOUR NAME HERE", style: _style(fontSize: 16)),
              SizedBox(height: 27),
              Text("CARD NUMBER", style: _style(fontSize: 23)),
              SizedBox(height: 17),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("EXPRIRES DATE", style: _style(fontSize: 11)),
                      SizedBox(height: 9),
                      Text("**/**", style: _style(fontSize: 16)),
                    ],
                  ),
                  SizedBox(width: 88),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("CVV", style: _style(fontSize: 11)),
                      SizedBox(height: 9),
                      Text("* * *", style: _style(fontSize: 16)),
                    ],
                  ),
                ],
              )
            ],
          ),
        )
      ],
    ));
  }

  _style({double fontSize}) {
    return TextStyle(
      fontSize: fontSize,
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(context),
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
          AppConstants()
              .header(text: AppStrings.checkOutText, context: context),
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
      width: double.infinity,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 24,
              ),
              _carouselSlider(),
              _cardView()
            ],
          ),
          _bottomContinueButton()
        ],
      ),
    ));
  }

  _cardView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add new payment method",
            style: AppTextStyles.textStyle18black,
          ),
          SizedBox(height: 28),
          _cardPaymentView(text: "VISA", url: "assets/images/Rectangle1.png"),
          Divider(color: Color(0xffDBDBDE)),
          _cardPaymentView(
              text: "MasterCard", url: "assets/images/Rectangle2.png"),
          Divider(color: Color(0xffDBDBDE)),
          _cardPaymentView(
              text: "Local Debit", url: "assets/images/Rectangle.png"),
          Divider(color: Color(0xffDBDBDE)),
        ],
      ),
    );
  }

  _cardPaymentView({String url, String text}) {
    return ListTile(
      leading: Image.asset(
        "$url",
        height: 20,
        width: 35,
        fit: BoxFit.fitHeight,
      ),
      title: Text(
        text,
        style: AppTextStyles.textStyle14grey,
      ),
      trailing: Icon(
        Icons.add,
        color: Color(0xffDBDBDE),
        size: 20,
      ),
    );
  }

  _carouselSlider() {
    return Column(
      children: [
        Container(
          child: CarouselSlider(
            items: cardList,
            options: CarouselOptions(
                autoPlay: false,
                aspectRatio: 2,
                // aspectRatio: 2.0,
                viewportFraction: 0.9,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: cardList.map((url) {
            int index = cardList.indexOf(url);
            return Container(
              width: 9.0,
              height: 9.0,
              // margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              margin: EdgeInsets.fromLTRB(0, 15, 16, 15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? AppColors.lightGreenText_color
                    : Color.fromRGBO(236, 235, 237, 100),
              ),
            );
          }).toList(),
        )
      ],
    );
  }

  _bottomContinueButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(21.0, 0.0, 21.0, 20.0),
        child: CustomButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConfirmationScreen(
                            price: widget.price,
                          )));
            },
            text: AppStrings.payText),
      ),
    );
  }
}
