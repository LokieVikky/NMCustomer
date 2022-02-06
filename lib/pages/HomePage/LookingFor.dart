import 'package:namma_mechanics/currentstate/currentState.dart';
import 'package:namma_mechanics/data/data.dart';
import 'package:namma_mechanics/pages/AvailableServices/Car/car.dart';
import 'package:namma_mechanics/pages/HomePage/widgets/Available_services.dart';
import 'package:namma_mechanics/values/MyColors.dart';
import 'package:namma_mechanics/values/MyTextStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './widgets/ServiceCards.dart';

class LookingFor extends StatefulWidget {
  @override
  _LookingForState createState() => _LookingForState();
}

class _LookingForState extends State<LookingFor> {
  double _height, _width;

  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          // alignment: Alignment.centerLeft,
          // padding: EdgeInsets.only(top:20),
          margin: EdgeInsets.only(
            top: 20.0,
            left: 20.0,
            right: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Available Services",
                style: MyTextStyle.headingTitle,
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 5.0,
                  right: 5.0,
                  bottom: 10.0,
                  top: 10.0,
                ),
                decoration: BoxDecoration(
                  color: MyColors.lightgrey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Vehicle repairing & \nServices",
                      style: MyTextStyle.text9,
                      // textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _instance.vehicleType = "car";
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectCarBrand(
                                          brands: carBrands,
                                        )));
                            // Navigator.pushNamed(
                            //     context, "/availableServices/car");
                          },
                          child: Available_services(
                            height: _height,
                            width: _width,
                            icon_path: "av_car.png",
                            card_text: "Car",
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _instance.vehicleType = "bike";
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectCarBrand(
                                          brands: bikeBrands,
                                        )));
                          },
                          child: Available_services(
                            height: _height,
                            width: _width,
                            icon_path: "av_bike.png",
                            card_text: "Bike",
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _instance.vehicleType = "rickshaw";
                            //Navigator.pushNamed(context, "/nearByGarageAll");
                            //_instance.vehicleType = "bike";
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectCarBrand(
                                      brands: autoBrands,
                                    )));
                          },
                          child: Available_services(
                            height: _height,
                            width: _width,
                            icon_path: "av_rickshaw.png",
                            card_text: "Auto \n rickshaw",
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _instance.vehicleType = "truck";
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectCarBrand(
                                      brands: truckBrands,
                                    )));
                            //Navigator.pushNamed(context, "/nearByGarageAll");
                          },
                          child: Available_services(
                            height: _height,
                            width: _width,
                            icon_path: "av_truck.png",
                            card_text: "Truck",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _instance.vehicleType = "cycle";
                            //Navigator.pushNamed(context, "/nearByGarageAll");
                            //_instance.vehicleType = "bike";
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectCarBrand(
                                      brands: cycleBrands,
                                    )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Available_services(
                              height: _height,
                              width: _width,
                              icon_path: "cycle.png",
                              card_text: "Cycle",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 20.0,
          ),
          width: double.infinity,
          color: MyColors.lightgrey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.0,
              ),
              FittedBox(
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _instance.vehicleType = "laptop";
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectCarBrand(
                                      brands: laptopBrands,
                                    )));
                      },
                      child: ServiceCards(
                        card_text: "Laptop",
                        image_path: 'laptop.png',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _instance.vehicleType = "mobile";
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectCarBrand(
                                      brands: mobileBrands,
                                    )));
                      },
                      child: ServiceCards(
                        card_text: "Mobile",
                        image_path: 'mobile.png',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _instance.vehicleType = "printer";
                        Navigator.pushNamed(context, "/nearByGarageAll");
                      },
                      child: ServiceCards(
                        card_text: "Printer",
                        image_path: 'printer.png',
                      ),
                    ),
                  ],
                ),
              ),
              FittedBox(
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _instance.vehicleType = "television";
                        //_instance.vehicleType = "cycle";
                        //Navigator.pushNamed(context, "/nearByGarageAll");
                        //_instance.vehicleType = "bike";
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectCarBrand(
                                  brands: tv,
                                )));
                      },
                      child: ServiceCards(
                        card_text: "Television",
                        image_path: 'television.png',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _instance.vehicleType = "water purifier";
                        Navigator.pushNamed(context, "/nearByGarageAll");
                      },
                      child: ServiceCards(
                        card_text: "Water Purifier",
                        image_path: 'waterPurifier.png',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _instance.vehicleType = "refrigerator";
                        //Navigator.pushNamed(context, "/nearByGarageAll");
                        //_instance.vehicleType = "cycle";
                        //Navigator.pushNamed(context, "/nearByGarageAll");
                        //_instance.vehicleType = "bike";
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectCarBrand(
                                  brands: refrigerator,
                                )));
                      },
                      child: ServiceCards(
                        card_text: "Refrigerator",
                        image_path: 'fridge.png',
                      ),
                    ),
                  ],
                ),
              ),
              FittedBox(
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _instance.vehicleType = "ac";
                        //Navigator.pushNamed(context, "/nearByGarageAll");
                        //_instance.vehicleType = "cycle";
                        //Navigator.pushNamed(context, "/nearByGarageAll");
                        //_instance.vehicleType = "bike";
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectCarBrand(
                                  brands: ac,
                                )));
                      },
                      child: ServiceCards(
                        card_text: "Air \n Conditioner",
                        image_path: 'ac.png',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _instance.vehicleType = "washing machine";
                        //Navigator.pushNamed(context, "/nearByGarageAll");
                        //_instance.vehicleType = "cycle";
                        //Navigator.pushNamed(context, "/nearByGarageAll");
                        //_instance.vehicleType = "bike";
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectCarBrand(
                                  brands: washingMachine,
                                )));
                      },
                      child: ServiceCards(
                        card_text: "Washing \n Machine",
                        image_path: 'washingMachine.png',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _instance.vehicleType = "microwave";
                        Navigator.pushNamed(context, "/nearByGarageAll");
                      },
                      child: ServiceCards(
                        card_text: "Microwave \n",
                        image_path: 'microwave.png',
                      ),
                    ),
                  ],
                ),
              ),
              FittedBox(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _instance.vehicleType = "chimney";
                        Navigator.pushNamed(context, "/nearByGarageAll");
                      },
                      child: ServiceCards(
                        card_text: "Chimney",
                        image_path: 'chimney.png',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _instance.vehicleType = "watch";
                        Navigator.pushNamed(context, "/nearByGarageAll");
                      },
                      child: ServiceCards(
                        card_text: "Watch",
                        image_path: 'watchS.png',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _instance.vehicleType = "grinder";
                        //Navigator.pushNamed(context, "/nearByGarageAll");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectCarBrand(
                                  brands: mixerBrands,
                                )));
                      },
                      child: ServiceCards(
                        card_text: "Grinder",
                        image_path: 'mixerS.png',
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _instance.vehicleType = "invertor";
                      Navigator.pushNamed(context, "/nearByGarageAll");
                    },
                    child: ServiceCards(
                      card_text: "Inverter",
                      image_path: 'invertorS.png',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
