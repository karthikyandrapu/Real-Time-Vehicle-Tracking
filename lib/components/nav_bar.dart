import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roomates/components/kishore.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final user = FirebaseAuth.instance.currentUser;
  double opacity = 0.0;
  int selectedIndex = -1;

  bool showProgressIndicator = false; // Declare this global variable

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
      child: ListView(
        padding: const EdgeInsets.only(top: 0),
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'USER',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
            ),
            accountEmail: Text(
              "Logged In As: ${user?.email ?? 'Unknown'}",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 45.0,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(62, 118, 121, 122),
            ),
          ),

          AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: opacity,
            child: GestureDetector(
              onTap: () {
                print("Context: $context");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Kishore();
                    },
                  ),
                );
              },
              child: buildMenuItem(
                icon: Icons.language_outlined,
                text: 'Change Language',
                index: 0,
              ),
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: opacity,
            child: GestureDetector(
              onTap: () {
                // Handle 'Settings' click action here
                // You can implement settings functionality here
              },
              child: buildMenuItem(
                icon: Icons.settings,
                text: 'Settings',
                index: 1,
              ),
            ),
          ),
          // ... Other menu items ...
          AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: opacity,
            child: buildMenuItem(
              icon: Icons.favorite,
              text: 'Favorites',
              index: 2,
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: opacity,
            child: buildMenuItem(
              icon: Icons.notifications_active,
              text: 'SOS',
              index: 3,
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: opacity,
            child: buildMenuItem(
              icon: Icons.feedback,
              text: 'Feedback',
              index: 4,
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: opacity,
            child: buildMenuItem(
              icon: Icons.person_search_rounded,
              text: 'About Us',
              index: 5,
            ),
          ),
          const Divider(
            height: 170,
          ),

          // Logout menu item using GestureDetector
          GestureDetector(
            onTap: () {
              _handleLogout();
            },
            child: Container(
              decoration: BoxDecoration(
                border: selectedIndex == 6
                    ? Border.all(color: Colors.blue, width: 2)
                    : null,
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: selectedIndex == 6 ? Colors.blue : Colors.red,
                  size: 30,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    color: selectedIndex == 6 ? Colors.blue : null,
                  ),
                ),
                tileColor:
                    selectedIndex == 6 ? Colors.grey[200] : Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem({
    required IconData icon,
    required String text,
    required int index,
  }) {
    bool isActive = index == selectedIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: isActive ? Colors.white : Colors.blue,
            size: 30,
          ),
          title: Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.white : null,
            ),
          ),
          tileColor:
              isActive ? Color.fromARGB(255, 74, 148, 209) : Colors.transparent,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        opacity = 1.0;
      });
    });
  }
}
