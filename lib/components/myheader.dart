import 'package:flutter/material.dart';

class MyHeaderDrawer extends StatefulWidget {
  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 181, 220, 244),
      width: double.infinity,
      height: 170,
      padding: EdgeInsets.only(top: 20.0, left: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: Colors.black,
                size: 45,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "USER",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold, // Make the text bold
                    ),
                  ),
                  Text(
                    "jaikishore@gmail.com",
                    style: TextStyle(
                      color: Color.fromARGB(255, 56, 54, 54),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
