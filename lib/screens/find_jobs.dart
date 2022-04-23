import 'package:flutter/material.dart';

class FindJobsScreen extends StatefulWidget {
  static const routeName = '/jobs';
  const FindJobsScreen({Key? key}) : super(key: key);

  @override
  _FindJobsScreenState createState() => _FindJobsScreenState();
}

class _FindJobsScreenState extends State<FindJobsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: const [
            Text("Find Jobs"),
          ],
        ),
      ),
    );
  }
}
