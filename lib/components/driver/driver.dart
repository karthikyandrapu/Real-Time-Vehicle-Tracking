// import 'dart:async';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';

// class DriverScreen extends StatefulWidget {
//   @override
//   _DriverScreenState createState() => _DriverScreenState();
// }

// class _DriverScreenState extends State<DriverScreen> {
//   DatabaseReference? _driverLocationRef;
//   bool isSharingLocation = false;
//   StreamSubscription<Position>? locationStream;
//   String? selectedBusNumber;

//   @override
//   void dispose() {
//     super.dispose();
//     locationStream?.cancel();
//   }

//   void startSharingLocation() {
//     setState(() {
//       isSharingLocation = true;
//     });

//     locationStream = Geolocator.getPositionStream(
//       desiredAccuracy: LocationAccuracy.high,
//     ).listen((Position position) {
//       if (isSharingLocation) {
//         updateLocation(
//             selectedBusNumber!, position.latitude, position.longitude);
//       }
//     });
//   }

//   void stopSharingLocation() {
//     setState(() {
//       isSharingLocation = false;
//     });
//   }

//   void updateLocation(String busNumber, double latitude, double longitude) {
//     _driverLocationRef =
//         FirebaseDatabase.instance.reference().child('bus_locations/$busNumber');
//     _driverLocationRef!.set({
//       'latitude': latitude,
//       'longitude': longitude,
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Driver App'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               onChanged: (value) {
//                 selectedBusNumber = value;
//               },
//               decoration: InputDecoration(labelText: 'Enter Bus Number'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: isSharingLocation ? null : startSharingLocation,
//               child: Text('Start Sharing'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: stopSharingLocation,
//               child: Text('Stop Sharing'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
