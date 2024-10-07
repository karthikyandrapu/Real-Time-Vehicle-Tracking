import 'package:flutter/material.dart';
import 'package:roomates/components/driver/driver_location.dart';

class setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the second page when the button is pressed
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DriverScreen()),
            );
          },
          child: Text('Are you a driver'),
        ),
      ),
    );
  }
}
