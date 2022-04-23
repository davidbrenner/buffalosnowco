import 'package:buffalosnowco/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FindJobsScreen extends StatefulWidget {
  static const routeName = '/jobs';
  const FindJobsScreen({Key? key}) : super(key: key);

  @override
  _FindJobsScreenState createState() => _FindJobsScreenState();
}

class _FindJobsScreenState extends State<FindJobsScreen> {
  final CollectionReference jobs =
      FirebaseFirestore.instance.collection('jobs');
  final Stream<QuerySnapshot> _jobsStream =
      FirebaseFirestore.instance.collection('jobs').snapshots();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SnowAppBar(),
        body: StreamBuilder<QuerySnapshot>(
          stream: _jobsStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['title']),
                  subtitle: Text(data['description']),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
