import 'package:namma_mechanics/models/garage/garageModel.dart';
import 'package:namma_mechanics/values/MyColors.dart';
import 'package:namma_mechanics/values/MyTextStyle.dart';
import 'package:auto_size_text/auto_size_text.dart';
import "package:flutter/material.dart";
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Details extends StatefulWidget {
  String profileImg;
  String shopName;
  OurGarage allData;
  Details({this.shopName,this.profileImg, this.allData});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Container(
      height: _height / 4,
      width: width / 1,
      margin: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        bottom: 20.0,
      ),
      decoration: BoxDecoration(
          color: MyColors.detailYellow,
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 1,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 115,
                  width: 115,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: MyColors.parrotGreen),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    //color: MyColors.blue_ribbon,
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      image: NetworkImage(widget.profileImg),
                      fit: BoxFit.cover
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width/2 + 20,
                  child: AutoSizeText(
                    widget.shopName,
                    style: MyTextStyle.shopHeading1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                Flexible(
                  child: Container(
                    child: AutoSizeText(
                      "${widget.allData.address.shopNo} ${widget.allData.address.street} ${widget.allData.address.state} ${widget.allData.address.pincode}",
                      maxLines: 1,
                      style: MyTextStyle.shopText1,
                      overflow: TextOverflow.clip,

                    ),
                  ),
                ),
                Flexible(
                  child: Row(
                    children: [
                      RatingBar.builder(
                        initialRating: 3.5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20.0,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      // Text(
                      //   "4.5 out of 5",
                      //   style: MyTextStyle.shopText2,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
