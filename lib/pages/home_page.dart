import 'package:flutter/material.dart';
import 'package:roomates/components/bus/src_des_page.dart';
import 'package:roomates/components/nav1.dart';

// import '../components/drop_down.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showProgressIndicator = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: iNavigationDrawer(),
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add some spacing between existing content and BusCard
              Expanded(child: SrcDes()),
              // Expanded(
              //   child: BusCard(), // Include the BusCard widget here
              // ),
              // Include the BusCard widget here
            ],
          ),
        ),
        // bottomNavigationBar: Container(
        //   color: Colors.blue,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        //     child: GNav(
        //         backgroundColor: Colors.blue,
        //         color: Colors.white,
        //         activeColor: Colors.white,
        //         tabBackgroundColor: Colors.blue,
        //         gap: 8,
        //         padding: EdgeInsets.all(16),
        //         tabs: const [
        //           GButton(
        //             icon: Icons.home,
        //             text: 'Home',
        //           ),
        //           GButton(
        //             icon: Icons.favorite_border,
        //             text: 'Likes',
        //           ),
        //           GButton(
        //             icon: Icons.search,
        //             text: 'Search',
        //           ),
        //           GButton(
        //             icon: Icons.settings,
        //             text: 'Setting',
        //           ),
        //         ]),
        //   ),
        // ),
      ),
    );
  }
}
