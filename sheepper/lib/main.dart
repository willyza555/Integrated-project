import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sheepper/screens/product.dart';
import 'package:sheepper/screens/sign_in.dart';
import 'package:sheepper/services/dio.dart';
import 'package:sheepper/services/provider/product_list.dart';
import 'package:sheepper/services/share_preference.dart';
import 'package:thebrioflashynavbar/thebrioflashynavbar.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:sheepper/screens/productlist.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UpdateProduct()),
      ],
      child: const MyApp(),
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
          nextScreen: const productlist(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
        ),
      ),
      routes: {
        Product.routeName: (context) => const Product(),
        MyHomePage.routeName: (context) => const MyHomePage(
              title: '',
            ),
        SignIn.routeName: (context) => const SignIn(),
        productlist.routeName: (context) => const productlist(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);
  static const String routeName = "/homepage";

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      bottomNavigationBar: const Nevbar(),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Nevbar extends StatefulWidget {
  const Nevbar({Key? key}) : super(key: key);

  @override
  State<Nevbar> createState() => _NevbarState();
}

class _NevbarState extends State<Nevbar> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Thebrioflashynavbar(
      selectedIndex: _selectedIndex,
      showElevation: true,
      onItemSelected: (index) => setState(() {
        _selectedIndex = index;
      }),
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
    );
  }
}
