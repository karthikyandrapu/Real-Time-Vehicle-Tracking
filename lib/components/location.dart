import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:roomates/components/bus/bus_status.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  DatabaseReference _driverLocationRef =
      FirebaseDatabase.instance.reference().child('bus_locations');

  GoogleMapController? _mapController;
  LatLng? _userLocation; // Initialize to null
  LatLng? _driverLocation; // Initialize to null
  bool _isLoading = false;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor userMarkerIcon = BitmapDescriptor.defaultMarker;
  Location _location = Location();
  double _panelHeight = 100.0;

  void addBusIcon() async {
    final icon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
          size: Size(20, 20)), // Set your desired width and height here
      'lib/images/bus-marker.png', // Replace with the correct asset path
    );
    setState(() {
      markerIcon = icon;
    });
  }

  void addUserMarkerIcon() async {
    final icon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(10, 10)), // Adjust the size as needed
      'lib/images/user-marker.png', // Adjust the path to your image
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
    _listenToDriverLocation();

    // Start a periodic timer to update driver location every 1 second (adjust as needed)
    // Timer.periodic(Duration(seconds: 1), (Timer timer) {
    //   _refreshDriverLocation();
    // });

    // Start listening for the user's location updates
    _listenForUserLocation();
  }

  // Listen to changes in the driver's location
  void _listenToDriverLocation() {
    _driverLocationRef.child('bus1').onValue.listen((event) {
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<String, dynamic>?;
        final double? latitude = data?['latitude'] as double?;
        final double? longitude = data?['longitude'] as double?;
        if (latitude != null && longitude != null) {
          setState(() {
            _driverLocation = LatLng(latitude, longitude);
            _updateCameraPosition();
          });
        }
      }
    });
  }

  // Method to update the camera position based on driver's location
  void _updateCameraPosition() {
    if (_mapController != null && _driverLocation != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLng(_driverLocation!));
    }
  }

  void _refreshDriverLocation() {
    setState(() {
      _isLoading = true;
    });

    _driverLocationRef.child('bus1').get().then((DataSnapshot snapshot) {
      final data = snapshot.value;

      if (data is Map<dynamic, dynamic>) {
        final double? latitude = data['latitude'] as double?;
        final double? longitude = data['longitude'] as double?;

        if (latitude != null && longitude != null) {
          setState(() {
            _driverLocation = LatLng(latitude, longitude);
            _isLoading = false;
            _updateCameraPosition();
          });
        } else {
          print(
              'Latitude or longitude is null or not double: $latitude, $longitude');
        }
      } else {
        print('Data from Firebase is not in the expected format: $data');
      }
    }).catchError((error) {
      print('Error fetching data from Firebase: $error');
      setState(() {
        _isLoading = false;
      });
    });
  }

  // Listen for the user's location updates
  void _listenForUserLocation() {
    _location.onLocationChanged.listen((LocationData locationData) {
      setState(() {
        _userLocation = LatLng(locationData.latitude!, locationData.longitude!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Location'),
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
                      target: _driverLocation ??
                          LatLng(28.6139, 77.2090), // New Delhi coordinates
                      zoom: 15.0,
                    ),
                    markers: {
                      if (_userLocation != null)
                        Marker(
                          markerId: MarkerId('userMarker'),
                          position: _userLocation!,
                          icon: userMarkerIcon, // Blue marker for user
                        ),
                      if (_driverLocation != null)
                        Marker(
                          markerId: MarkerId('driverMarker'),
                          position: _driverLocation!,
                          icon: markerIcon, // Red marker for driver
                        ),
                    },
                  ),
                  if (_isLoading)
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
            SlidingUpPanel(
              minHeight: 70,
              collapsed: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height:
                            8.0), // Adjust the spacing between the circle and text
                    Text(
                      "Bus Status",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              panel: Center(
                child: Expanded(child: BusStatusApp()),
              ),
              borderRadius: BorderRadius.circular(16.0),
            )
          ],
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: UserScreen()));
}
