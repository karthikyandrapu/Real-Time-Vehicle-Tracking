import 'package:flutter/material.dart';
import 'package:order_tracker_zen/order_tracker_zen.dart';

enum BusStatus { Arrived, Departed, Upcoming }

class BusStation {
  final String name;
  final double distanceInKm;
  final String exactTime;
  final String approxTime;
  final BusStatus status;

  BusStation(this.name, this.distanceInKm, this.exactTime, this.approxTime,
      this.status);
}

class BusStatusApp extends StatefulWidget {
  const BusStatusApp({Key? key}) : super(key: key);

  @override
  State<BusStatusApp> createState() => _BusStatusAppState();
}

class _BusStatusAppState extends State<BusStatusApp> {
  List<BusStation> busStations = [
    BusStation(
        "Station 1", 5.2, "10:00 AM", "Approx. 10:15 AM", BusStatus.Departed),
    BusStation(
        "Station 2", 8.7, "10:30 AM", "Approx. 10:45 AM", BusStatus.Departed),
    BusStation(
        "Station 3", 12.3, "11:00 AM", "Approx. 11:15 AM", BusStatus.Upcoming),
    BusStation(
        "Station 4", 15.8, "11:30 AM", "Approx. 11:45 AM", BusStatus.Upcoming),
    BusStation(
        "Station 5", 20.0, "12:00 PM", "Approx. 12:15 PM", BusStatus.Upcoming),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center, // Align the text to the center
                child: Text(
                  'Bus Status',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              OrderTrackerZen(
                tracker_data: busStations.map((station) {
                  return TrackerData(
                    title: station.name,
                    date: "${station.exactTime} - ${station.approxTime}",
                    tracker_details: [
                      TrackerDetails(
                        title: "Status: ${getStatusText(station.status)}",
                        datetime: "Status updated at ${station.exactTime}",
                      ),
                      TrackerDetails(
                        title: "Distance: ${station.distanceInKm} km",
                        datetime:
                            "Estimated arrival time: ${station.approxTime}",
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getStatusText(BusStatus status) {
    switch (status) {
      case BusStatus.Arrived:
        return "Arrived";
      case BusStatus.Departed:
        return "Departed";
      case BusStatus.Upcoming:
        return "Upcoming";
      default:
        return "Unknown";
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: BusStatusApp(),
  ));
}
