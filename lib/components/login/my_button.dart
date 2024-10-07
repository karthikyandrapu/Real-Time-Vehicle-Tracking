import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color color;

  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.color,
  });
  Future<Map<String, dynamic>> fetchDataFromFirestore() async {
    try {
      // Replace 'buses' with the name of your Firestore collection
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('buses')
              .doc('your_document_id')
              .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() ?? {};
        return data;
      } else {
        return {};
      }
    } catch (e) {
      print('Error fetching data from Firestore: $e');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
