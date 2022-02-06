import 'package:namma_mechanics/currentstate/currentState.dart';
import 'package:namma_mechanics/pages/AvailableServices/Car/car.dart';
import 'package:namma_mechanics/pages/BookingPage/booking.dart';
import 'package:namma_mechanics/pages/HomePage/HomeScreen.dart';
import 'package:namma_mechanics/pages/ReferEarn.dart';
import 'package:namma_mechanics/pages/ShopPages/shopConfirmPage.dart';
import 'package:namma_mechanics/pages/ShopPages/shopPage.dart';
import 'package:namma_mechanics/pages/Vehicles/myvehicles.dart';
import 'package:namma_mechanics/pages/authentication/screen/Login.dart';
import 'package:namma_mechanics/pages/authentication/screen/LoginScreen.dart';
import 'package:namma_mechanics/pages/authentication/screen/Register.dart';
import 'package:namma_mechanics/pages/authentication/screen/SignupScreen.dart';
import 'package:namma_mechanics/pages/authentication/screen/Verification.dart';
import 'package:namma_mechanics/pages/loading.dart';
import 'package:namma_mechanics/pages/subPages/NearByGarage/AllNearByGarage.dart';
import 'package:namma_mechanics/pages/subPages/NearByMechanics/AllNearByMechanics.dart';
import 'package:namma_mechanics/pages/subPages/NearByMechanics/detailsPageMechanic.dart';
import 'package:namma_mechanics/provider/selectServices.dart';
import 'package:namma_mechanics/services/privacyPolicy.dart';
import 'package:namma_mechanics/services/root.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:namma_mechanics/pages/authentication/screen/ForgotPassword.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:namma_mechanics/currentstate/currentState.dart';
import 'package:provider/provider.dart';
import 'models/ourUser.dart';
import 'pages/SplashScreen/SplashPage.dart';
import 'pages/subPages/NearByMechanics/DescribeScreen.dart';
import 'pages/subPages/NearByMechanics/Track_page.dart';
import 'pages/subPages/profileScreen.dart';
import 'package:namma_mechanics/pages/subPages/NearByGarage/detailGaragePage.dart';
import 'pages/Usage/usagePage.dart';
import 'pages/BookingStatus/booking_status.dart';
import 'pages/Report/Report.dart';
import 'pages/AboutUs.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory =await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(OurUserHiveGen());

  await Firebase.initializeApp();

  print('gotcha');
  runApp(MyApp(),);
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   systemNavigationBarColor: Colors.black, // navigation bar color
  //   statusBarColor: Colors.black, // status bar color
  // ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrentState>(
          create: (context) => CurrentState(),
        ),
        ChangeNotifierProvider<SelectServices>(
          create: (context) => SelectServices(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xff000000),
          buttonColor: Color(0xff3E5BFB),
          textSelectionColor: Color(0xff1F1F1F),
          backgroundColor: Color(0xffE5E5E5),
          fontFamily: 'Roboto',
          iconTheme: IconThemeData(color: Colors.white),
        ),
        //initialRoute: '/homescreen',
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {

            // if (userSnapshot.connectionState == ConnectionState.waiting) {
            //   return LoginScreen();
            // }
            if (userSnapshot.hasData) {
              FocusScope.of(context).unfocus();
              var ph = FirebaseAuth.instance.currentUser.phoneNumber;
              //print(ph);
              // var token = FirebaseAuth.instance.currentUser.getIdToken();
              // print(token);
              return Register();
            }
            // return AdminScreen();
            return Register();
          },
        ),
        routes: {
          //'/registe': (context) => Register(),
          // "/loginPage": (context) => OurLoginPage(),
          "/login": (context) => Login(), //new Login Page
          "/register": (context) => Register(), //new Registeration Page
          "/verify": (context) => Verification(), // New Verify page
          // "/forgotPage": (context) => ForgotPasswordPage(),
          "/homescreen": (context) => HomeScreen(),
          "/profileScreen": (context) => ProfileScreen(),
          "/nearbygarage": (context) => DetailGaragePage(),
          "detailsMechanic": (context) => OurMechanicDetails(),
          "/nearByMechanicsAll": (context) => AllNearByMechanics(),
          "/nearByGarageAll": (context) => AllNearByGarage(),
          "/describePage": (context) => DescribePage(),
          "/trackPage": (context) => TrackPage(),
          "/usagePage": (context) => UsagePage(),
          "/bookingStatus": (context) => BookingStatus(),
          "/reportPage": (context) => ReportPage(),
          "/myVehicles": (context) => MyVehicles(),
          "/referEarnPage": (context) => ReferEarnPage(),
          "/aboutUs": (context) => AboutUs(),
          "/loading": (context) => Loading(),
          "/availableServices/car": (context) => SelectCarBrand(),
          "/shopPage": (context) => ShopPage(),
          "/shopConfirmPage": (context) => ShopConfirmPage(),
          "/bookPage": (context) => BookingPageUpdated(),
          "/tandc":(context) => PrivacyPolicy(),
        },
      ),
    );
  }
}
