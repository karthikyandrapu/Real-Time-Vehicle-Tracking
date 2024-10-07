import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:roomates/components/bus/setting.dart';
import 'package:roomates/components/feedback.dart';
import 'package:roomates/components/nav.dart';
import 'package:roomates/components/nav/about_us.dart';
import 'package:roomates/components/nav/favourite.dart';
import 'package:roomates/components/sos.dart';
import 'package:roomates/pages/auth_page.dart';
import 'package:roomates/pages/home_page.dart';

//import 'package:nav_bar/drawer_item.dart';

// ignore: camel_case_types
class iNavigationDrawer extends StatefulWidget {
  const iNavigationDrawer({Key? key}) : super(key: key);

  @override
  State<iNavigationDrawer> createState() => _iNavigationDrawerState();
}

class _iNavigationDrawerState extends State<iNavigationDrawer> {
  bool showProgressIndicator = false;

  Future<void> _handleLogout() async {
    await signUserOut();
    Navigator.pop(context); // Close the drawer
  }

  Future<void> signUserOut() async {
    setState(() {
      showProgressIndicator = true;
    });

    await Future.delayed(Duration(seconds: 2)); // Introduce a 2-second delay

    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print("Sign out error: $e");
    } finally {
      setState(() {
        showProgressIndicator = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Color.fromARGB(255, 224, 228, 230),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 80, 24, 0),
          child: Column(
            children: [
              headerWidget(),
              const SizedBox(
                height: 30,
              ),
              const Divider(
                thickness: 1,
                height: 10,
                color: Color.fromARGB(255, 243, 237, 237),
              ),
              const SizedBox(
                height: 40,
              ),
              DrawerItem(
                name: 'Home',
                icon: Icons.people,
                onPressed: () => onItemPressed(context, index: 0),
              ),
              const SizedBox(
                height: 20,
              ),
              DrawerItem(
                  name: 'Change Language',
                  icon: Icons.message_outlined,
                  onPressed: () => onItemPressed(context, index: 1)),
              const SizedBox(
                height: 20,
              ),
              DrawerItem(
                  name: 'Favourites',
                  icon: Icons.favorite_outline,
                  onPressed: () => onItemPressed(context, index: 2)),
              const SizedBox(
                height: 20,
              ),
              DrawerItem(
                  name: 'SOS',
                  icon: Icons.notifications_outlined,
                  onPressed: () => onItemPressed(context, index: 3)),
              const SizedBox(
                height: 20,
              ),
              DrawerItem(
                  name: 'Feedback',
                  icon: Icons.feedback,
                  onPressed: () => onItemPressed(context, index: 4)),
              const SizedBox(
                height: 20,
              ),
              DrawerItem(
                  name: 'AboutUs',
                  icon: Icons.person_search,
                  onPressed: () => onItemPressed(context, index: 5)),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 1,
                height: 10,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 20,
              ),
              DrawerItem(
                  name: 'Setting',
                  icon: Icons.settings,
                  onPressed: () => onItemPressed(context, index: 6)),
              const SizedBox(
                height: 20,
              ),
              DrawerItem(
                name: 'Log out',
                icon: Icons.logout,
                onPressed: () =>
                    _handleLogout(), // Call _handleLogout when Log out is pressed
              )
            ],
          ),
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);

    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => favour()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => favour()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SOSPage()));
        break;
      case 4:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FeedbackPage()));
        break;
      case 5:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => About()));
        break;
      case 6:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => setting()));
        break;
    }
  }

  Widget headerWidget() {
    return Row(
      children: [
        Container(
          width: 80, // Adjust the width as needed
          height: 80, // Adjust the height as needed
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'lib/images/user.png',
              ),
              fit: BoxFit.contain, // Adjust the fit property as needed
            ),
            // To make it a circular container
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('USER',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 51, 50, 50),
                )),
            SizedBox(
              height: 10,
            ),
            Text('person@email.com',
                style: TextStyle(
                    fontSize: 14, color: Color.fromRGBO(63, 63, 63, 0.949)))
          ],
        )
      ],
    );
  }
}
