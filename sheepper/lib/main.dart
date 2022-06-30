import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sheepper/screens/history_order.dart';
import 'package:sheepper/screens/order_detail.dart';
import 'package:sheepper/screens/history_orders.dart';
import 'package:sheepper/screens/orderlist.dart';
import 'package:sheepper/screens/product.dart';
import 'package:sheepper/screens/profile.dart';
import 'package:sheepper/screens/sign_in.dart';
import 'package:sheepper/services/dio.dart';
import 'package:sheepper/services/provider/history_order_detail_list.dart';
import 'package:sheepper/services/provider/history_order_list.dart';
import 'package:sheepper/services/provider/order_detail_list.dart';
import 'package:sheepper/services/provider/product_of_order_list.dart';
import 'package:sheepper/services/provider/order_list.dart';
import 'package:sheepper/services/share_preference.dart';
import 'package:thebrioflashynavbar/thebrioflashynavbar.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'services/provider/order_list.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UpdateProductOfOrder()),
        ChangeNotifierProvider(create: (_) => OrderDetailListProvider()),
        ChangeNotifierProvider(create: (_) => OrderListProvider()),
        ChangeNotifierProvider(create: (_) => HistoryOrderDetailListProvider()),
        ChangeNotifierProvider(create: (_) => HistoryOrderListProvider()),
        ChangeNotifierProvider(create: (_) => OrderListProvider())
      ],
      builder: (context, child) => const MyApp(),
    ),
  );
  SharePreference.init();
  DioInstance.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sheepper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF24577A),
          secondary: const Color.fromARGB(255, 84, 156, 160),
          tertiary: const Color.fromARGB(255, 240, 241, 243),
        ),
        // iconTheme: const IconThemeData(
        //   color: Color.fromARGB(255, 84, 156, 160),
        // ),
        textTheme: TextTheme(
          //     headline3: GoogleFonts.poppins(
          //       fontSize: 24,
          //       fontWeight: FontWeight.w600,
          //       color: const Color(0xFF24577A),
          //     ),
          caption: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w300,
              color: const Color(0xFF24577A)),
          headline2: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF24577A)),
          headline1: GoogleFonts.poppins(
              fontSize: 38,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF323B69)),
          //     headline4: GoogleFonts.poppins(
          //         fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          //     headline5: GoogleFonts.poppins(
          //       fontSize: 20,
          //       fontWeight: FontWeight.w600,
          //       color: const Color.fromARGB(255, 5, 5, 5),
          //     ),
          //     headline6: GoogleFonts.poppins(
          //       fontSize: 16,
          //       fontWeight: FontWeight.w500,
          //       color: const Color.fromARGB(80, 0, 0, 0),
          //     ),
          //     bodyText1: GoogleFonts.poppins(
          //         fontSize: 16,
          //         fontWeight: FontWeight.w500,
          //         color: const Color(0xff0E2B39)),
          //     bodyText2: GoogleFonts.poppins(
          //       fontSize: 14,
          //       color: const Color(0xFF022B3A),
          //       fontWeight: FontWeight.w600,
        ),
        //     subtitle1: GoogleFonts.poppins(fontSize: 14)),
      ),
      home: Scaffold(
        body: AnimatedSplashScreen(
          duration: 2000,
          centered: true,
          splash: 'assets/sheepper_logo.png',
          nextScreen: SignIn(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
        ),
      ),
      routes: {
        Product.routeName: (context) => const Product(),
        MyHomePage.routeName: (context) => const MyHomePage(),
        SignIn.routeName: (context) => const SignIn(),
        OrderDetail.routeName: (context) => const OrderDetail(),
        HistoryOrder.routeName: (context) => const HistoryOrder(),
        OrderList.routeName: (context) => const OrderList(),
        HistoryOrderList.routeName: (context) => const HistoryOrderList()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);
  static const String routeName = "/homepage";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  bool isSwapRight = true;
  void _onItemTapped(int index) {
    setState(() {
      if (_selectedIndex > index) {
        isSwapRight = false;
      } else if (_selectedIndex < index) {
        isSwapRight = true;
      }
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screen = <Widget>[
      OrderDetail(),
      OrderDetail(),
      OrderDetail(),
      OrderDetail(),
    ];
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   elevation: 0,
      //   flexibleSpace: Container(
      //     decoration: _selectedIndex == 3
      //         ? const BoxDecoration(
      //             gradient: LinearGradient(
      //               begin: Alignment.centerLeft,
      //               end: Alignment.centerRight,
      //               colors: [
      //                 Color(0xff173550),
      //                 Color(0xff24577a),
      //               ],
      //             ),
      //           )
      //         : const BoxDecoration(color: Colors.white),
      //   ),
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text("willy"),
      // ),

      body: AnimatedSwitcher(
        layoutBuilder: (currentChild, previousChildren) =>
            currentChild as Widget,
        switchInCurve: Curves.easeOutExpo,
        transitionBuilder: (child, animation) => SlideTransition(
          position: isSwapRight
              ? Tween<Offset>(
                      begin: const Offset(2, 0), end: const Offset(0, 0))
                  .animate(animation)
              : Tween<Offset>(
                      begin: const Offset(-2, 0), end: const Offset(0, 0))
                  .animate(animation),
          child: child,
        ),
        child: screen.elementAt(_selectedIndex),
        duration: const Duration(milliseconds: 500),
      ),
      bottomNavigationBar: Thebrioflashynavbar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => _onItemTapped(index),
        items: [
          ThebrioflashynavbarItem(
            icon: const Icon(Icons.person),
            title: const Text('PROFILE'),
          ),
          ThebrioflashynavbarItem(
            icon: const Icon(Icons.restaurant),
            title: const Text('FOOD'),
          ),
          ThebrioflashynavbarItem(
            icon: const Icon(Icons.list_alt),
            title: const Text('LIST'),
          ),
          ThebrioflashynavbarItem(
            icon: const Icon(Icons.shopping_cart),
            title: const Text('CART'),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// class Nevbar extends StatefulWidget {
//   const Nevbar({Key? key}) : super(key: key);

//   @override
//   State<Nevbar> createState() => _NevbarState();
// }

// class _NevbarState extends State<Nevbar> {
//   var _selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Thebrioflashynavbar(
//       selectedIndex: _selectedIndex,
//       showElevation: true,
//       onItemSelected: (index) => setState(() {
//         _selectedIndex = index;
//       }),
//       items: [
//         ThebrioflashynavbarItem(
//           icon: const Icon(Icons.person),
//           title: const Text('PROFILE'),
//         ),
//         ThebrioflashynavbarItem(
//           icon: const Icon(Icons.restaurant),
//           title: const Text('FOOD'),
//         ),
//         ThebrioflashynavbarItem(
//           icon: const Icon(Icons.list_alt),
//           title: const Text('LIST'),
//         ),
//         ThebrioflashynavbarItem(
//           icon: const Icon(Icons.shopping_cart),
//           title: const Text('CART'),
//         ),
//       ],
//     );
//   }
// }
