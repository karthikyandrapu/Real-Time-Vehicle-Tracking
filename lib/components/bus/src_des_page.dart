import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:roomates/components/All_buses_button.dart';
import 'package:roomates/components/location1.dart';
import 'package:roomates/components/login/my_button.dart';
import 'dart:async'; // Import async package for debounce

import '../../pages/BusScreen.dart';
import '../../pages/live_safe.dart';
import 'date.dart';

class SrcDes extends StatefulWidget {
  @override
  State<SrcDes> createState() => _SrcDesState();
}

class _SrcDesState extends State<SrcDes> {
  DateTime selectedDate = DateTime.now();

  void _handleDateSelection(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  String source = '';
  String destination = '';

  List<String> sourceSuggestions = [];
  List<String> destinationSuggestions = [];

  final TextEditingController sourceController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();

  final FocusNode _focusNodeSource = FocusNode();
  final FocusNode _focusNodeDestination = FocusNode();
  OverlayEntry? _sourceOverlayEntry;
  OverlayEntry? _destinationOverlayEntry;
  final LayerLink _layerLink = LayerLink();

  // Add a debounce duration and timer
  final Duration _debounceDuration = Duration(milliseconds: 300);
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    // Fetch suggestions from Firestore for both source and destination fields.
    fetchNamesFromFirestore('src_name').then((data) {
      setState(() {
        sourceSuggestions = (data as List).cast<String>();
      });
    });

    fetchNamesFromFirestore('des_name').then((data) {
      setState(() {
        destinationSuggestions = (data as List).cast<String>();
      });
    });
  }

  Future<List<String>> fetchNamesFromFirestore(String fieldName) async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('buses').get();
    final List<String> names =
        querySnapshot.docs.map((doc) => doc[fieldName] as String).toList();
    return names;
  }

  OverlayEntry _createSourceOverlay(List<String> suggestions) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    double screenHeight = MediaQuery.of(context).size.height;
    double verticalOffset = (screenHeight - size.height) / 30.5;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.5, verticalOffset),
          child: Material(
            elevation: 5.0,
            child: Column(
              children: [
                for (String suggestion in suggestions)
                  ListTile(
                    title: Text(suggestion),
                    onTap: () {
                      setState(() {
                        source = suggestion;
                        sourceController.text = suggestion;
                      });
                      _sourceOverlayEntry!.remove();
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  OverlayEntry _createDestinationOverlay(List<String> suggestions) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    double screenHeight = MediaQuery.of(context).size.height;
    double verticalOffset = (screenHeight - size.height) / 10.5;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.5, verticalOffset),
          child: Material(
            elevation: 5.0,
            child: Column(
              children: [
                for (String suggestion in suggestions)
                  ListTile(
                    title: Text(suggestion),
                    onTap: () {
                      setState(() {
                        destination = suggestion;
                        destinationController.text = suggestion;
                      });
                      _destinationOverlayEntry!.remove();
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Add a debounce method
  void _onSourceChanged(String text) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(_debounceDuration, () {
      // Filter and update suggestions based on user input
      setState(() {
        source = text;
        if (source.isNotEmpty) {
          _sourceOverlayEntry?.remove();
          _sourceOverlayEntry = _createSourceOverlay(sourceSuggestions
              .where((suggestion) =>
                  suggestion.toLowerCase().contains(source.toLowerCase()))
              .toList());
          Overlay.of(context)!.insert(_sourceOverlayEntry!);
        } else {
          _sourceOverlayEntry?.remove();
          _sourceOverlayEntry = null;
        }
      });
    });
  }

  // Add a debounce method
  void _onDestinationChanged(String text) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(_debounceDuration, () {
      // Filter and update suggestions based on user input
      setState(() {
        destination = text;
        if (destination.isNotEmpty) {
          _destinationOverlayEntry?.remove();
          _destinationOverlayEntry = _createDestinationOverlay(
              destinationSuggestions
                  .where((suggestion) => suggestion
                      .toLowerCase()
                      .contains(destination.toLowerCase()))
                  .toList());
          Overlay.of(context)!.insert(_destinationOverlayEntry!);
        } else {
          _destinationOverlayEntry?.remove();
          _destinationOverlayEntry = null;
        }
      });
    });
  }

  @override
  void dispose() {
    // Dispose of the overlay entries when the widget is disposed.
    _sourceOverlayEntry?.remove();
    _destinationOverlayEntry?.remove();
    _debounceTimer?.cancel(); // Cancel the debounce timer when disposing
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // Set the background image
          image: DecorationImage(
              image: AssetImage(
                  'lib/images/background.jpeg'), // Replace with the path to your image asset
              fit: BoxFit.cover,
              opacity: 0.5 // You can choose how the image should be displayed
              ),
        ),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 320,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        const Text(
                          "Bus Information",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              CompositedTransformTarget(
                                link: _layerLink,
                                child: TextFormField(
                                  controller: sourceController,
                                  focusNode: _focusNodeSource,
                                  keyboardType: TextInputType.text,
                                  textCapitalization: TextCapitalization.words,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    filled: false,
                                    prefixIcon: Icon(
                                      Icons.business_outlined,
                                      size: 30,
                                      color: Colors.grey,
                                    ),
                                    hintText: "Enter Source",
                                    hintStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onChanged:
                                      _onSourceChanged, // Use the debounce method
                                ),
                              ),
                              CompositedTransformTarget(
                                link: _layerLink,
                                child: TextFormField(
                                  controller: destinationController,
                                  focusNode: _focusNodeDestination,
                                  keyboardType: TextInputType.text,
                                  textCapitalization: TextCapitalization.words,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    filled: false,
                                    prefixIcon: Icon(
                                      Icons.directions_bus,
                                      size: 30,
                                    ),
                                    hintText: "Enter Destination",
                                    hintStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onChanged:
                                      _onDestinationChanged, // Use the debounce method
                                ),
                              ),
                              DateSelection(
                                onDateSelected: _handleDateSelection,
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  if (source != destination) {
                                    // Handle search button click
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return BusScreen();
                                        },
                                      ),
                                    );
                                  } else {
                                    // Show an error message for the same source and destination
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Error"),
                                          content: Text(
                                            "Source and destination cannot be the same.",
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("OK"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                child: Text("Search Buses"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[500],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 80),
                Center(
                  child: Text(
                    "Near By Locations",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                LiveSafe(),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 20), // Add space at the bottom
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 90), // Add horizontal padding
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AllBuses()),
                        );
                      },
                      child: Text(
                        "Near By Buses",
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[500],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
