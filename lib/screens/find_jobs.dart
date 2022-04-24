import 'package:buffalosnowco/models/job_detail.dart';
import 'package:buffalosnowco/screens/job_details_screen.dart';
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

  Route _createRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SnowAppBar(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: StreamBuilder<QuerySnapshot>(
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
                  bool completed = data['status'] == 'Completed';
                  bool standard = data['type'] == 'standard';
                  return Column(
                    children: [
                      ListTile(
                        title: Text(data['title']),
                        subtitle: Text(data['description']),
                        leading: (Icon(
                          completed
                              ? Icons.check
                              : (standard ? Icons.map : Icons.warning),
                          color: completed
                              ? Colors.green
                              : (standard ? null : Colors.yellow),
                        )),
                        onTap: () {
                          Navigator.of(context)
                              .push(_createRoute(JobsDetailsScreen(
                            job: JobDetail.fromJson(data),
                            jobDoc: document.reference,
                          )));
                        },
                      ),
                      Divider(),
                    ],
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
