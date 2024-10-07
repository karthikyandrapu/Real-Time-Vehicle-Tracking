import 'package:flutter/material.dart';
import 'package:roomates/components/bus/bus_card.dart';

class BusScreen extends StatefulWidget {
  const BusScreen({Key? key}) : super(key: key); // Fix the constructor

  @override
  State<BusScreen> createState() => _BusScreenState();
}

class _BusScreenState extends State<BusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Information'), // Change the title as needed
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context)
                .pop(); // Navigate back when the back button is pressed
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Expanded(child: BusCard()),
            // Expanded(child: BusCard())
            Expanded(
              child: BusCard(),
            ),
          ],
        ),
      ), // Include the BusCard widget here
    );
  }
}
