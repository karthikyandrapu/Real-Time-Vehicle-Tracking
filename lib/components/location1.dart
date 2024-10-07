import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: AllBuses()));
}

class AllBuses extends StatefulWidget {
  @override
  _AllBusesState createState() => _AllBusesState();
}

class _AllBusesState extends State<AllBuses> {
  DatabaseReference _driverLocationRef =
      FirebaseDatabase.instance.reference().child('bus_locations');

  GoogleMapController? _mapController;
  Location _location = Location();
  Map<String, LatLng> _busLocations = {};
  LatLng? _userLocation; // Add this line
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor userMarkerIcon = BitmapDescriptor.defaultMarker;
  @override
  void dispose() {
    // Cancel stream subscriptions here
    super.dispose();
  }

  void addBusIcon() async {
    final icon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        size: Size(20, 20),
      ),
      'lib/images/bus-marker.png',
    );
    setState(() {
      markerIcon = icon;
    });
  }

  void addUserMarkerIcon() async {
    final icon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(10, 10)),
      'lib/images/user-marker.png',
    );
    setState(() {
      userMarkerIcon = icon;
    });
  }

  @override
  void initState() {
    addBusIcon();
    addUserMarkerIcon();
    super.initState();
    _listenToDriverLocations();

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _refreshDriverLocations();
    });

    _listenForUserLocation();
  }

  void _listenToDriverLocations() {
    _driverLocationRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<String, dynamic>;
        final Map<String, LatLng> busLocations = {};

        data.forEach((busKey, busData) {
          final double? latitude = busData['latitude'] as double?;
          final double? longitude = busData['longitude'] as double?;

          if (latitude != null && longitude != null) {
            busLocations[busKey] = LatLng(latitude, longitude);
          }
        });

        setState(() {
          _busLocations = busLocations;
        });
      }
    });
  }

  void _refreshDriverLocations() {
    _driverLocationRef.get().then((DataSnapshot snapshot) {
      final data = snapshot.value;

      if (data is Map<dynamic, dynamic>) {
        final Map<String, LatLng> busLocations = {};

        data.forEach((busKey, busData) {
          final double? latitude = busData['latitude'] as double?;
          final double? longitude = busData['longitude'] as double?;

          if (latitude != null && longitude != null) {
            busLocations[busKey] = LatLng(latitude, longitude);
          }
        });

        setState(() {
          _busLocations = busLocations;
        });
      }
    }).catchError((error) {
      print('Error fetching data from Firebase: $error');
    });
  }

  void _listenForUserLocation() {
    _location.onLocationChanged.listen((LocationData locationData) {
      setState(() {
        _userLocation = LatLng(locationData.latitude!, locationData.longitude!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Buses App'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: (controller) {
                      setState(() {
                        _mapController = controller;
                      });
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(16.5449, 81.5212),
                      zoom: 15.0,
                    ),
                    markers: {
                      if (_userLocation != null)
                        Marker(
                          markerId: MarkerId('userMarker'),
                          position: _userLocation!,
                          icon: userMarkerIcon,
                        ),
                      for (final busKey in _busLocations.keys)
                        Marker(
                          markerId: MarkerId(busKey),
                          position: _busLocations[busKey]!,
                          icon: markerIcon,
                          infoWindow: InfoWindow(
                            title: busKey, // Display the bus ID as the title
                          ),
                        ),
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
