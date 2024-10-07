import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roomates/components/location.dart';
import 'package:roomates/components/location1.dart';

Stream<QuerySnapshot<Map<String, dynamic>>> fetchDataFromFirestore() {
  // Replace 'buses' with the name of your Firestore collection
  return FirebaseFirestore.instance.collection('buses').snapshots();
}

class BusCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: fetchDataFromFirestore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final documents = snapshot.data!.docs;

          return Expanded(
            child: ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final data = documents[index].data() as Map<String, dynamic>;

                return GestureDetector(
                  onTap: () {
                    // Determine which page to navigate based on the card data
                    if (index == 0) {
                      // Navigate to Location1Page
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UserScreen(),
                      ));
                    } else if (index == 1) {
                      // Navigate to Location2Page
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UserScreen(),
                      ));
                    }
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue[700],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'SOURCE',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  Text(
                                    data['src_name'] ?? 'Unknown',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    data?['src_town'] ?? 'Unknown',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                '→',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'DESTINATION',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  Text(
                                    data?['des_name'] ?? 'Unknown',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    data?['des_town'] ?? 'Unknown',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.directions,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  data?['distance'] + ' KM, via '.toString() ??
                                      'Unknown' +
                                          ' KM, via ' +
                                          (data?['inter_towns'] ?? 'Unknown'),
                                  maxLines: 2,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.directions_bus,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                (data?['brand'] ?? 'Unknown') +
                                    ', ' +
                                    (data?['chair_count']?.toString() ??
                                        'Unknown') +
                                    ' seater, ' +
                                    ['Non-AC', 'AC'][data?['ac'] ?? 0],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time_rounded,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                data['start_time'] ?? 'Unknown',
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              const Icon(
                                Icons.timelapse_rounded,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                data['duration'] ?? 'Unknown',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
