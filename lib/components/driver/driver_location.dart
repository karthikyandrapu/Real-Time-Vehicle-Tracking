import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverScreen extends StatefulWidget {
  @override
  _DriverScreenState createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  final databaseReference = FirebaseDatabase.instance.reference();
  bool isTracking = false;
  String busId = "bus_001"; // Replace with the actual bus ID
  TextEditingController busIdController = TextEditingController();
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  GoogleMapController? _mapController;
  Map<String, LatLng> busCoordinates = {};
  Set<Marker> _markers = Set<Marker>();

  Future<void> addBusIcon() async {
    final icon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
          size: Size(20, 20)), // Set your desired width and height here
      'lib/images/bus-marker.png', // Replace with the correct asset path
    );
    setState(() {
      markerIcon = icon;
    });
  }

  @override
  void initState() {
    addBusIcon();
    super.initState();
    _initializeLocationTracking();
  }

  void _initializeLocationTracking() async {
    final status = await Geolocator.requestPermission();
    if (status == LocationPermission.always ||
        status == LocationPermission.whileInUse) {
      setState(() {
        isTracking = false; // Initially set to false
      });
    } else {
      // Handle permission denied
    }
  }

  void _startTracking() {
    setState(() {
      isTracking = true;
    });

    // Periodically update the location in Firebase Realtime Database
    final busLocationReference =
        databaseReference.child('bus_locations/$busId');

    // Define a function to update location and timestamp
    void updateLocation() async {
      final position = await Geolocator.getCurrentPosition();
      busLocationReference.set({
        'latitude': position.latitude,
        'longitude': position.longitude,
        'timestamp': ServerValue.timestamp,
      });

      // Update the map markers with the current driver location
      _updateMapMarker(position.latitude, position.longitude);
    }

    // Update location every second
    const Duration updateInterval = Duration(seconds: 1);
    Timer.periodic(updateInterval, (Timer timer) {
      if (!isTracking) {
        timer.cancel(); // Stop updating if tracking is disabled
      } else {
        updateLocation();
      }
    });
  }

  void _stopTracking() {
    setState(() {
      isTracking = false;
    });
  }

  void _updateMapMarker(double latitude, double longitude) {
    final List<Marker> markers = [];

    // Add the driver's marker
    final driverLocationMarker = Marker(
      markerId: MarkerId('driver_location'),
      position: LatLng(latitude, longitude),
      icon: markerIcon ?? BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(
        title: 'Driver Location',
      ),
    );
    markers.add(driverLocationMarker);

    // Add the bus markers
    busCoordinates.forEach((busId, coordinates) {
      final busMarker = Marker(
        markerId: MarkerId(busId),
        position: coordinates,
        icon: markerIcon,
        infoWindow: InfoWindow(
          title: 'Bus $busId Location',
        ),
      );
      markers.add(busMarker);
    });

    setState(() {
      _markers = markers.toSet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Driver App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // TextField for entering the bus ID
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: busIdController,
                decoration: InputDecoration(labelText: 'Bus ID'),
                onChanged: (text) {
                  setState(() {
                    busId = text;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              isTracking ? 'Tracking Enabled' : 'Tracking Disabled',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isTracking ? _stopTracking : _startTracking,
              child: Text(isTracking ? 'Stop Tracking' : 'Start Tracking'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(16.5449, 81.5212), // Initial map position
                  zoom: 15.0, // You can adjust the initial zoom level
                ),
                onMapCreated: (controller) {
                  setState(() {
                    _mapController = controller;
                  });
                },
                markers: _markers, // Use the updated markers
              ),
            ),
          ],
        ),
      ),
    );
  }
}
