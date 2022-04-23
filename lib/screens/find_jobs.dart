import 'package:buffalosnowco/widgets/app_bar.dart';
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
        appBar: SnowAppBar(),
        body: Column(
          children: const [
            Text("Find Jobs"),
          ],
        ),
      ),
    );
  }
}
