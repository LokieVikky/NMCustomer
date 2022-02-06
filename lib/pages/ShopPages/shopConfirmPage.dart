import 'package:namma_mechanics/currentstate/currentState.dart';
import 'package:namma_mechanics/models/garage/garageModel.dart';
import 'package:namma_mechanics/models/garage/sub_models/MechanicServies.dart';
import 'package:namma_mechanics/pages/BookingPage/booking.dart';
import 'package:namma_mechanics/pages/BookingPage/widget/screenDisableCode.dart';
import 'package:namma_mechanics/pages/ShopPages/widgets/problem.dart';
import 'package:namma_mechanics/pages/ShopPages/widgets/selectAddress.dart';
import 'package:namma_mechanics/pages/subPages/widgets/selectCheckBox/checkBox.dart';
import 'package:namma_mechanics/values/MyColors.dart';
import 'package:namma_mechanics/values/MyTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'widgets/details.dart';

class ShopConfirmPage extends StatefulWidget {
  OurGarage allData;

  ShopConfirmPage({this.allData});

  @override
  _ShopConfirmPageState createState() => _ShopConfirmPageState();
}

class _ShopConfirmPageState extends State<ShopConfirmPage> {
  bool allowAddress = true;
  int total;
  List<MechanicServices> selectedServices = [];
  bool pickup = false;
  @override
  void initState() {
    super.initState();
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);

    if (_instance.selectedProducts.isNotEmpty) {
      if (widget.allData.uid == _instance.selectedProducts[0].id) {
        _instance.totalAmount = 0;
        _instance.selectedProducts.forEach((element) {
          _instance.totalAmount += element.price;
        });
        // do nothing
      } else {
        widget.allData.products.forEach((element) {
          if (element.selected == true) {
            element.selected = false;
          }
        });
        _instance.selectedProducts.clear();
        _instance.totalAmount = 0;
      }
    } else {
      _instance.totalAmount = 0;
      widget.allData.products.forEach((element) {
        if (element.selected == true) {
          element.selected = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MyColors.purewhite,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: _instance.isScreenDisable
              ? NeverScrollableScrollPhysics()
              : AlwaysScrollableScrollPhysics(),
          child: Container(
              margin: EdgeInsets.only(
                top: 20.0,
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Details(
                        shopName: widget.allData.name,
                        profileImg: widget.allData.images.profileImages,
                        allData: widget.allData,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Select the services",
                              style: MyTextStyle.headingTitle),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Repairement & \n Services",
                                  style: MyTextStyle.dropdown,
                                ),
                                Text(
                                  "Price Rate",
                                  style: MyTextStyle.dropdown,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    width: 2, color: MyColors.yellowish),
                                //color: MyColors.yellowish,
                              ),
                              child: Column(
                                children: [
                                  ...List.generate(
                                      widget.allData.products.length, (index) {
                                    return Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 7),
                                        child: CheckBox(
                                          text: widget.allData.products[index],
                                        ));
                                  })
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: size.height / 15,
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 20.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.all(
                                //   Radius.circular(10.0),
                                // ),
                                color: MyColors.shopButton,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "Total",
                                    style: MyTextStyle.shopButton2,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Consumer<CurrentState>(
                                    builder: (context, _, Widget child) {
                                      return Text(
                                      "₹" + _instance.totalAmount.toString(),
                                        style: MyTextStyle.shopButton2,
                                      );
                                    },
                                    //child: ,
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(right: 20.0),
                                  //   child: Icon(
                                  //     Icons.arrow_forward_sharp,
                                  //     color: MyColors.yellowish,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Problem(),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 1),
                              child: Text(
                                'Pickup',
                                style: MyTextStyle.referEarnText,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 7, bottom: 28),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          pickup = true;
                                          //gender = "male";
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: pickup ? MyColors.yellowish : null,
                                          border: !pickup
                                              ? Border.all(width: 2, color: Colors.grey)
                                              : null,
                                        ),
                                        child: Center(
                                            child: Text(
                                              'Pickup',
                                              style: pickup
                                                  ? MyTextStyle.text4
                                                  : MyTextStyle.text3,
                                            )),
                                        height: 50,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          pickup = false;
                                          //gender = "female";
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: !pickup ? MyColors.yellowish : null,
                                          border: pickup
                                              ? Border.all(width: 2, color: Colors.grey)
                                              : null,
                                        ),
                                        height: 50,
                                        child: Center(
                                            child: Text(
                                              'drop off',
                                              style: !pickup
                                                  ? MyTextStyle.text4
                                                  : MyTextStyle.text3,
                                            )),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Builder(
                        builder: (context) {
                          if(pickup == true)  {
                            if((_instance.currentUser.street!= null && _instance.currentUser.pincode != null && _instance.currentUser.houseNo!=null && _instance.currentUser.city!=null)) {
                              allowAddress = true;
                              return Container(
                                margin: EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                  bottom: 20.0,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Select address",
                                        style: MyTextStyle.shopHeading1,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${_instance.currentUser.houseNo}, ${_instance.currentUser.street}, ${_instance.currentUser.city}, ${_instance.currentUser.pincode},",
                                          style: MyTextStyle.shopText1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        // Container(
                                        //   height: _height / 15,
                                        //   width: _width / 3,
                                        //   alignment: Alignment.center,
                                        //   decoration: BoxDecoration(
                                        //     borderRadius: BorderRadius.all(
                                        //       Radius.circular(10.0),
                                        //     ),
                                        //     color: MyColors.shopButton,
                                        //   ),
                                        //   child: Text(
                                        //     "Change address",
                                        //     style: MyTextStyle.shopButton1,
                                        //   ),
                                        // ),
                                      ],
                                    ),

                                  ],
                                ),
                              );
                            } else {
                              allowAddress = false;
                              return Container(
                                child: GestureDetector(
                                  onTap: () {

                                  },
                                  child: Text("Please enter your address details in profile section"),
                                ),
                              );
                            }
                          } else {
                            allowAddress = true;
                            return Container();
                          }
                        },
                      ),
                      AbsorbPointer(
                        absorbing: false,
                        child: GestureDetector(
                          onTap: () async {
                            if (_instance.selectedProducts.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "you have not selected any service",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                            else if(allowAddress == false) {
                              Fluttertoast.showToast(
                                  msg: "Enter address details or select the drop off option",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                            else {
                              String _retVal = await _instance.order(
                                  shopData: widget.allData);
                              if (_retVal == "success") {
                                //Navigator.pushName(context, "/bookPage");
                                Navigator.push(context, MaterialPageRoute(builder: (context) => BookingPageUpdated(allData: widget.allData,orderDetails: null,)));

                              } else {
                                Fluttertoast.showToast(
                                    msg: "someThing went wrong",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 20.0,
                              right: 20.0,
                              bottom: 20.0,
                            ),
                            height: size.height / 15,
                            width: double.infinity,
                            //margin: EdgeInsets.only(top: 20.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              color: MyColors.shopButton,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 150.0),
                                  child: Text(
                                    "Confirm",
                                    style: MyTextStyle.shopButton2,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Icon(
                                    Icons.arrow_forward_sharp,
                                    color: MyColors.yellowish,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ScreenDisableCode(),
                ],
              )),
        ),
      ),
    );
  }
}
