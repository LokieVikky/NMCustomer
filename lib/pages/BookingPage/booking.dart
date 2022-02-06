import 'package:namma_mechanics/currentstate/currentState.dart';
import 'package:namma_mechanics/models/garage/garageModel.dart';
import 'package:namma_mechanics/models/garage/sub_models/MechanicServies.dart';
import 'package:namma_mechanics/models/orderModel.dart';
import 'package:namma_mechanics/pages/BookingPage/widget/button.dart';
import 'package:namma_mechanics/pages/HomePage/widgets/SearchBox.dart';
import 'package:namma_mechanics/pages/ShopPages/widgets/details.dart';
import 'package:namma_mechanics/pages/ShopPages/widgets/shimmerAnimation.dart';
import 'package:namma_mechanics/pages/subPages/widgets/selectCheckBox/checkBox.dart';
import 'package:namma_mechanics/values/MyColors.dart';
import 'package:namma_mechanics/values/MyTextStyle.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class BookingPageUpdated extends StatefulWidget {
  OurGarage allData;
  OrderModel orderDetails;

  BookingPageUpdated({this.allData, this.orderDetails});

  @override
  _BookingPageUpdatedState createState() => _BookingPageUpdatedState();
}

class _BookingPageUpdatedState extends State<BookingPageUpdated> {
  // List services = [
  //   MechanicServices(name: "Denting & Painting", price: 40),
  //   MechanicServices(name: "Batteries", price: 200),
  //   MechanicServices(name: "Spa & Cleaning", price: 500),
  // ];
  Future data;
  TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.allData == null) {
      // here make the call to get the data of the garage from the database
      print("The allData is empty");
      print("The allData is empty");
      print("d-gg------------------------------------------------------");
      CurrentState _instance =
          Provider.of<CurrentState>(context, listen: false);
      List uids = [];
      uids.add(widget.orderDetails.shopUID);
      data = _instance.fetchSingleGarageDetails(uids);
    }
  }

  Color colorLocation;

  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.backgroundColor,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              //Navigator.pop(context);
            },
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: Text(
            "Booking Confirmed",
            style: MyTextStyle.appBarTextSupporting,
          ),
        ),
        body: SingleChildScrollView(
          child: Builder(builder: (context) {
            if (widget.allData != null && widget.orderDetails == null) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Text(
                        "Verify Mechanic",
                        style: MyTextStyle.headingPop4,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: MyColors.lightPurple,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                child: _instance.orderData["empUrl"] != null
                                    ? NetworkImage(
                                        _instance.orderData["empUrl"])
                                    : Container(),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${_instance.orderData["empName"] == null ? "Not assigned" : _instance.orderData["empName"]}",
                                    style: MyTextStyle.time_heading,
                                  ),
                                  // Text(
                                  //   "Car Mechanic specialist",
                                  //   style: MyTextStyle.report_text,
                                  // )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: size.width,
                            height: 1.5,
                            color: MyColors.yellowish,
                          ),

                          SizedBox(
                            height: 5,
                          ),
                          AutoSizeText(
                            "Enter the OTP send to the mechanic",
                            style: MyTextStyle.otpText,
                          ),

                          Visibility(
                            visible: !_instance.orderData["otpVerified"],
                            child: Column(
                              children: [
                                Visibility(
                                  visible: _instance.orderData["empName"] == null
                                      ? false
                                      : true,
                                  child: TextField(
                                    controller: _otpController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyColors.yellowish, width: 2),
                                        ),
                                        hoverColor: MyColors.yellowish,
                                        fillColor: MyColors.yellowish,
                                        focusColor: MyColors.yellowish,
                                        border: OutlineInputBorder(
                                          //borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: MyColors.yellowish, width: 10),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                                // TextFormField(
                                //     //keyboardType: ,
                                //
                                //     ),
                                GestureDetector(
                                  onTap: () async{
                                    print("eiunsjs f");
                                    if (_otpController.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: "Please enter an otp",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    } else {
                                      String _retVal = await _instance.verifyOTP(_otpController.text);
                                      Fluttertoast.showToast(
                                          msg: _retVal,
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: 10, bottom: 10, left: 10, right: 10),
                                    padding: EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    width: size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                    ),
                                    child: Center(
                                        child: Text(
                                          "Verify",
                                          style: MyTextStyle.buttonTextU,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    Text(
                      "Billing info",
                      style: MyTextStyle.availableServicesHeading,
                    ),
                    Container(
                      // height: size.height / 4,
                      // width: size.width / 1,
                      decoration: BoxDecoration(
                          color: MyColors.detailYellow,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 115,
                                    width: 115,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: MyColors.parrotGreen),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: MyColors.blue_ribbon,
                                      borderRadius: BorderRadius.circular(100),
                                      image: DecorationImage(
                                          image: NetworkImage(widget
                                              .allData.images.profileImages),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: size.width / 2 + 20,
                                    child: AutoSizeText(
                                      widget.allData.name,
                                      style: MyTextStyle.shopHeading1,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    child: AutoSizeText(
                                      widget.allData.address.city +
                                          ", " +
                                          widget.allData.address.state,
                                      maxLines: 1,
                                      style: MyTextStyle.shopText1,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                  Container(
                                    width: size.width / 2,
                                    child: AutoSizeText(
                                      "Contact no: ${widget.allData.contacts.phone}",
                                      maxLines: 1,
                                      style: MyTextStyle.shopText1,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            width: size.width,
                            height: 1.5,
                            color: MyColors.yellowish,
                          ),
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
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: MyColors.soapStoneWhite,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: MyColors.lightYellowish,
                                      width: 1.5)),
                              child: Column(
                                children: List.generate(
                                    _instance.selectedProducts.length, (index) {
                                  return Padding(
                                      padding: EdgeInsets.only(
                                          left: 10, right: 10, bottom: 7),
                                      child: CheckBox(
                                        text: _instance.selectedProducts[index],
                                        disableCode: true,
                                      ));
                                }),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              "Other charges",
                              style: MyTextStyle.dropdown,
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.all(10),
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //         color: MyColors.soapStoneWhite,
                          //         borderRadius: BorderRadius.circular(15),
                          //         border: Border.all(
                          //             color: MyColors.lightYellowish, width: 1.5)),
                          //     child: Column(
                          //       children: List.generate(widget.allData.products.length, (index) {
                          //         return Padding(
                          //             padding: EdgeInsets.only(
                          //                 left: 10, right: 10, bottom: 7),
                          //             child: CheckBox(text: widget.allData.products[index]));
                          //       }),
                          //     ),
                          //   ),
                          // ),
                          Builder(builder: (context) {
                            double total = 0;

                            _instance.selectedProducts.forEach((element) {
                              total += element.price;
                            });
                            return OurButton(
                              textToShow: "Total Payment ₹ $total",
                            );
                          }),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, "/homescreen", (route) => false);
                            },
                            child: Container(
                              height: size.height / 15,
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                  top: 20.0, left: 10, right: 10, bottom: 20),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                color: MyColors.shopButton,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                child: Consumer<CurrentState>(
                  builder: (context, _, Widget child) {
                    return FutureBuilder(
                        future: data,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Text("loading.....");
                            case ConnectionState.waiting:
                              return ShimmerForCategories(
                                  size.height / 5.2, size.width - 20);
                            case ConnectionState.done:
                              if (_instance.singleGarage != null) {
                                return Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        child: Text(
                                          "Verify Mechanic",
                                          style: MyTextStyle.headingPop4,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),

                                      Visibility(
                                        visible: _instance.orderData["stage"] == 3 ? false : true,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 10,
                                              bottom: 10,
                                              left: 10,
                                              right: 10),
                                          decoration: BoxDecoration(
                                            color: MyColors.lightPurple,
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  // CircleAvatar(
                                                  //   radius: 30,
                                                  //   child: _instance.orderData[
                                                  //               "empUrl"] !=
                                                  //           null
                                                  //       ? NetworkImage(_instance
                                                  //           .orderData["empUrl"])
                                                  //       : Container(),
                                                  // ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "${_instance.orderData["empName"] == null ? "Not assigned" : _instance.orderData["empName"]}",
                                                        style: MyTextStyle
                                                            .time_heading,
                                                      ),
                                                      // Text(
                                                      //   "Car Mechanic specialist",
                                                      //   style: MyTextStyle.report_text,
                                                      // )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                width: size.width,
                                                height: 1.5,
                                                color: MyColors.yellowish,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Visibility(
                                                visible: !_instance.orderData["otpVerified"],
                                                child: Column(
                                                  children: [
                                                    AutoSizeText(
                                                      "Enter the OTP send to the mechanic",
                                                      style: MyTextStyle.otpText,
                                                    ),
                                                    Visibility(
                                                      visible: _instance.orderData[
                                                      "empName"] ==
                                                          null
                                                          ? false
                                                          : true,
                                                      child: TextField(
                                                        controller: _otpController,
                                                        keyboardType:
                                                        TextInputType.number,
                                                        inputFormatters: <
                                                            TextInputFormatter>[
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(r'[0-9]')),
                                                        ],
                                                        decoration: InputDecoration(
                                                            focusedBorder:
                                                            OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: MyColors
                                                                      .yellowish,
                                                                  width: 2),
                                                            ),
                                                            hoverColor:
                                                            MyColors.yellowish,
                                                            fillColor:
                                                            MyColors.yellowish,
                                                            focusColor:
                                                            MyColors.yellowish,
                                                            border: OutlineInputBorder(
                                                              //borderRadius: BorderRadius.circular(20),
                                                              borderSide: BorderSide(
                                                                  color: MyColors
                                                                      .yellowish,
                                                                  width: 10),
                                                            )),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    // TextFormField(
                                                    //     //keyboardType: ,
                                                    //
                                                    //     ),
                                                    GestureDetector(
                                                      onTap: () async{
                                                        print("eiunsjs f");
                                                        if (_otpController.text.isEmpty) {
                                                          Fluttertoast.showToast(
                                                              msg: "Please enter an otp",
                                                              toastLength: Toast.LENGTH_SHORT,
                                                              gravity: ToastGravity.BOTTOM,
                                                              timeInSecForIosWeb: 1,
                                                              backgroundColor: Colors.red,
                                                              textColor: Colors.white,
                                                              fontSize: 16.0);
                                                        } else {
                                                          String _retVal = await _instance.verifyOTP(_otpController.text);
                                                          Fluttertoast.showToast(
                                                              msg: _retVal,
                                                              toastLength: Toast.LENGTH_SHORT,
                                                              gravity: ToastGravity.BOTTOM,
                                                              timeInSecForIosWeb: 1,
                                                              backgroundColor: Colors.red,
                                                              textColor: Colors.white,
                                                              fontSize: 16.0);
                                                          setState(() {

                                                          });
                                                        }
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            top: 10, bottom: 10, left: 10, right: 10),
                                                        padding: EdgeInsets.only(
                                                          top: 10,
                                                          bottom: 10,
                                                        ),
                                                        width: size.width,
                                                        decoration: BoxDecoration(
                                                          color: Colors.black,
                                                        ),
                                                        child: Center(
                                                            child: Text(
                                                              "Verify",
                                                              style: MyTextStyle.buttonTextU,
                                                            )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                visible: _instance.orderData["otpVerified"],
                                                child: Text("OTP VERIFIED", style: MyTextStyle.appBarTitle,),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 13,
                                      ),
                                      Text(
                                        "Billing info",
                                        style: MyTextStyle
                                            .availableServicesHeading,
                                      ),
                                      SizedBox(
                                        height: 13,
                                      ),

                                      Container(
                                        padding: EdgeInsets.all(1),
                                        // height: size.height / 4,
                                        // width: size.width / 1,
                                        decoration: BoxDecoration(
                                            color: MyColors.detailYellow,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20.0),
                                            )),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Container(
                                                      height: 115,
                                                      width: 115,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color: MyColors
                                                                .parrotGreen),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 100,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        color: MyColors
                                                            .blue_ribbon,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                _instance
                                                                    .singleGarage
                                                                    .images
                                                                    .profileImages),
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width:
                                                          size.width / 2 + 20,
                                                      child: AutoSizeText(
                                                        _instance
                                                            .singleGarage.name,
                                                        style: MyTextStyle
                                                            .shopHeading1,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Container(
                                                      child: AutoSizeText(
                                                        _instance.singleGarage
                                                                .address.city +
                                                            ", " +
                                                            _instance
                                                                .singleGarage
                                                                .address
                                                                .state,
                                                        maxLines: 1,
                                                        style: MyTextStyle
                                                            .shopText1,
                                                        overflow:
                                                            TextOverflow.clip,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: size.width / 2,
                                                      child: AutoSizeText(
                                                        "Contact no: ${_instance.singleGarage.contacts.phone}",
                                                        maxLines: 1,
                                                        style: MyTextStyle
                                                            .shopText1,
                                                        overflow:
                                                            TextOverflow.clip,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Container(
                                              margin: EdgeInsets.all(10),
                                              width: size.width,
                                              height: 1.5,
                                              color: MyColors.yellowish,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                            Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        MyColors.soapStoneWhite,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    border: Border.all(
                                                        color: MyColors
                                                            .lightYellowish,
                                                        width: 1.5)),
                                                child: Column(
                                                  children: List.generate(
                                                      widget
                                                          .orderDetails
                                                          .servicesOrder
                                                          .length, (index) {
                                                    return Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10,
                                                                right: 10,
                                                                bottom: 7),
                                                        child: CheckBox(
                                                          text: widget
                                                                  .orderDetails
                                                                  .servicesOrder[
                                                              index],
                                                          disableCode: true,
                                                        ));
                                                  }),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Text(
                                                "Other charges",
                                                style: MyTextStyle.dropdown,
                                              ),
                                            ),
                                            // Padding(
                                            //   padding: EdgeInsets.all(10),
                                            //   child: Container(
                                            //     decoration: BoxDecoration(
                                            //         color: MyColors.soapStoneWhite,
                                            //         borderRadius: BorderRadius.circular(15),
                                            //         border: Border.all(
                                            //             color: MyColors.lightYellowish, width: 1.5)),
                                            //     child: Column(
                                            //       children: List.generate(widget.allData.products.length, (index) {
                                            //         return Padding(
                                            //             padding: EdgeInsets.only(
                                            //                 left: 10, right: 10, bottom: 7),
                                            //             child: CheckBox(text: widget.allData.products[index]));
                                            //       }),
                                            //     ),
                                            //   ),
                                            // ),

                                            Builder(builder: (context) {
                                              double total = 0;

                                              widget.orderDetails.servicesOrder
                                                  .forEach((element) {
                                                total += element.price;
                                              });
                                              return OurButton(
                                                textToShow:
                                                    "Total Payment ₹ $total",
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                          "Order Status",
                                          style: MyTextStyle.dropdown,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12.0,
                                                bottom: 12,
                                                left: 20,
                                                right: 20),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  "assets/images/icons/orderPlaced.png",
                                                  width: 30,
                                                  height: 30,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                              child: Container(
                                            height: 4,
                                            color: MyColors.bluishTint,
                                          )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12.0,
                                                bottom: 12,
                                                left: 20,
                                                right: 20),
                                            child: Column(
                                              children: [
                                                //SvgPicture.asset("assets/images/icons/onWayS.png",color: Colors.yellow,),
                                                Image.asset(
                                                    "assets/images/icons/onWay.png",
                                                    width: 30,
                                                    height: 30),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                              child: Container(
                                            height: 4,
                                            color: _instance
                                                        .orderData["empName"] !=
                                                    null
                                                ? MyColors.bluishTint
                                                : MyColors.lightGrey,
                                          )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12.0,
                                                bottom: 12,
                                                left: 20,
                                                right: 20),
                                            child: Column(
                                              children: [

                                                Image.asset(
                                                  "assets/images/icons/urLoc.png",
                                                  width: 30,
                                                  height: 30,
                                                  color: _instance.orderData[
                                                  "otpVerified"] ==
                                                      true ? Colors.yellow : Colors.grey,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12.0, right: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AutoSizeText(
                                              "Order\n placed",
                                              style: MyTextStyle.text6,
                                              textAlign: TextAlign.center,
                                            ),
                                            AutoSizeText(
                                              "Mechanic \n on the way",
                                              style: MyTextStyle.text6,
                                              textAlign: TextAlign.center,
                                            ),
                                            AutoSizeText(
                                              "Your \n location",
                                              style: MyTextStyle.text6,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),

                                      // confirm button at the bottom of the screen
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              "/homescreen",
                                              (route) => false);
                                        },
                                        child: Container(
                                          height: size.height / 15,
                                          width: double.infinity,
                                          margin: EdgeInsets.only(
                                              top: 20.0,
                                              left: 10,
                                              right: 10,
                                              bottom: 20),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                            color: MyColors.shopButton,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 150.0),
                                                child: Text(
                                                  "Confirm",
                                                  style:
                                                      MyTextStyle.shopButton2,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20.0),
                                                child: Icon(
                                                  Icons.arrow_forward_sharp,
                                                  color: MyColors.yellowish,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Failed to Load Pls refresh the page",
                                    style: MyTextStyle.referEarnText,
                                  ),
                                ));
                              }
                              break;
                            default:
                              return Text("Some error occured");
                          }
                        });
                  },
                  //child: ,
                ),
              );
            }
          }),
        ));
  }
}
