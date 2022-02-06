import 'package:namma_mechanics/currentstate/currentState.dart';
import 'package:namma_mechanics/pages/ShopPages/widgets/shimmerAnimation.dart';
import 'package:namma_mechanics/pages/Usage/widgets/CustomCard.dart';
import 'package:namma_mechanics/values/MyColors.dart';
import 'package:namma_mechanics/values/MyTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Sidebar/SideDrawer.dart';

class BookingStatus extends StatefulWidget {
  @override
  _BookingStatusState createState() => _BookingStatusState();
}

class _BookingStatusState extends State<BookingStatus> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  Future data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);
    data = _instance.currentOrdersFetch();
  }

  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);
    //print(_instance.currentOrders);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.backgroundColor,
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(11.5),
            child: Image.asset('assets/images/icons/sidebar.png'),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline_outlined),
            onPressed: () {},
            color: MyColors.blue_ribbon,
          )
        ],
        //title: Text("Booking Status", ),
      ),
      drawer: SideDrawer(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(
                left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Booking Status",
                    style: MyTextStyle.usageAge,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Booking status of the mechanics and repairing live status ",
                    style: MyTextStyle.booking_text,
                    maxLines: 10,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Consumer<CurrentState>(
                  builder: (context, _, Widget child) {
                    print(
                        "this is building again that means that the notify is called now ---------------------------------");
                    return FutureBuilder(
                        future: data,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Text("loading.....");
                            case ConnectionState.waiting:
                              return ShimmerForCategories(
                                  size.height / 6, size.width - 25);
                            case ConnectionState.done:
                              if (_instance.currentOrders.isNotEmpty) {
                                return Column(
                                  children: [
                                    ...List.generate(
                                        _instance.currentOrders.length,
                                        (index) {
                                      return CustomCard(
                                        name: _instance
                                            .currentOrders[index].shopName,
                                        type: "Garage",
                                        date: "12-10-2019",
                                        amount: 520.0,
                                        button_text2: "Details",
                                        path2: "ListOfServices",
                                        fullDetails:
                                            _instance.currentOrders[index],
                                      );
                                    })
                                  ],
                                );
                              } else {
                                return Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Nothing to show here",
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

                Text("Past Orders", style: MyTextStyle.appBarTitle,),
                Consumer<CurrentState>(
                  builder: (context, _, Widget child) {
                    print(
                        "this is building again that means that the notify is called now ---------------------------------");
                    return FutureBuilder(
                        future: data,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Text("loading.....");
                            case ConnectionState.waiting:
                              return ShimmerForCategories(
                                  size.height / 6, size.width - 25);
                            case ConnectionState.done:
                              if (_instance.pastOrders.isNotEmpty) {
                                return Column(
                                  children: [
                                    ...List.generate(
                                        _instance.pastOrders.length,
                                            (index) {
                                          return CustomCard(
                                            name: _instance
                                                .pastOrders[index].shopName,
                                            type: "Garage",
                                            date: "12-10-2019",
                                            amount: 520.0,
                                            button_text2: "Details",
                                            path2: "ListOfServices",
                                            fullDetails:
                                            _instance.pastOrders[index],
                                          );
                                        })
                                  ],
                                );
                              } else {
                                return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "No past orders",
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
