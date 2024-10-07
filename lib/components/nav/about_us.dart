import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("About Us"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              elevation: 10,
              color: Color.fromARGB(255, 221, 226, 227),
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Icon(Icons.public, color: Colors.blue),
                title: Text(
                  'Websites:',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.circle,
                            size: 10,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: 'Official website:',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: 'www.website1.com\n',
                        style: TextStyle(color: Colors.blue),
                      ),
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.circle,
                            size: 10,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: 'For bus pass:',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: 'www.website2.com\n',
                        style: TextStyle(color: Colors.blue),
                      ),
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.circle,
                            size: 10,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: 'Visit our websites:\n',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: 'www.website3.com',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.open_in_new, color: Colors.blue),
                  onPressed: () {
                    // Open websites
                  },
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Card(
              elevation: 10,
              color: Color.fromARGB(255, 221, 226, 227),
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Icon(Icons.phone, color: Colors.green),
                title: Text(
                  'Call Center',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.circle,
                            size: 10,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: 'Phone Numbers1:\n',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: '+0987654321\n',
                        style: TextStyle(color: Colors.blue),
                      ),
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.circle,
                            size: 10,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: 'Phone Numbers2:\n',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: '+0987654322',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.call, color: Colors.green),
                  onPressed: () {
                    // Call call center 1
                  },
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Card(
              elevation: 10,
              color: Color.fromARGB(255, 221, 226, 227),
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Icon(Icons.mail, color: Colors.red),
                title: Text(
                  'Other Queries',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'Email: example@gmail.com',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
