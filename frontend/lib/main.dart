import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AutiSenseApp());
}

class AutiSenseApp extends StatelessWidget {
  const AutiSenseApp({super.key});

  Future<Map<String, dynamic>> fetchBackendMessage() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/'));
    return jsonDecode(response.body);
  }

  Future<String> fetchFirebaseStatus() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('test_connection')
        .get();
    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first['status'];
    }
    return 'no data found';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutiSense',
      home: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: Future.wait([
              fetchBackendMessage(),
              fetchFirebaseStatus(),
            ]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              final backendMessage = snapshot.data![0]['message'];
              final firebaseStatus = snapshot.data![1];

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome to AutiSense',
                    style: TextStyle(fontSize: 28),
                  ),
                  const SizedBox(height: 20),
                  Text('Backend says: $backendMessage'),
                  const SizedBox(height: 10),
                  Text('Firebase status: $firebaseStatus'),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}