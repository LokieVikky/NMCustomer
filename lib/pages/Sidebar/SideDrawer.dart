import 'package:namma_mechanics/currentstate/currentState.dart';
import 'package:namma_mechanics/pages/Sidebar/widgets/Tile_Container.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:namma_mechanics/values/MyTextStyle.dart';
import 'package:namma_mechanics/values/MyColors.dart';
import 'package:provider/provider.dart';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  int currentSelectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(currentSelectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of(context, listen:false);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    // currentSelectedIndex = 0;
    //print(_instance.currentUser);
    //print(_instance.currentUser.uid);
    double width = mediaQueryData.size.width;
    double height = mediaQueryData.size.height;
    return Container(
      width: height > 720 ? width / 1.2 : width / 1.1,
      child: Drawer(
        child: Column(
          children: [
            Container(
              height: height > 720 ? height / 3.8 : height / 2.5,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: MyColors.black_light_01,
                  image: DecorationImage(
                    image: AssetImage("assets/images/sidebar/Vector2.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: width > 360 ? 10 : 5,
                      bottom: height > 360 ? 20 : 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: height > 360 ? 30 : 15,
                        backgroundImage:  _instance.currentUser!= null ? _instance.currentUser.profileImg!= null ?  NetworkImage(_instance.currentUser.profileImg,) : AssetImage("assets/images/sidebar/profile.jpg") :AssetImage("assets/images/sidebar/profile.jpg"),
                      ),
                      SizedBox(height: 2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _instance.currentUser!= null ?_instance.currentUser.fullName!= null ? _instance.currentUser.fullName : "Enter Name" : "Enter Name",
                                  style: MyTextStyle.sidebartext1,
                                ),
                                // SizedBox(height: height/199,),
                                AutoSizeText(
                                  _instance.currentUser != null? _instance.currentUser.email!=null ? _instance.currentUser.email : 'enter your email': 'enter your email',
                                  style: MyTextStyle.sidebartext2,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context)
                                .pushNamed('/profileScreen'),
                            child: Container(
                              height: height / 17,
                              width: width / 5,
                              child: Material(
                                color: MyColors.soapStoneWhite,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.blueAccent, width: 1),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                elevation: 5.0,
                                child: Center(
                                  child: Text(
                                    "Profile",
                                    style: MyTextStyle.sidebarbuttontext1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TileContainer(),
          ],
        ),
      ),
    );
  }
}
