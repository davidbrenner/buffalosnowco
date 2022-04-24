import 'package:buffalosnowco/widgets/app_bar.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/job_detail.dart';

class JobsDetailsScreen extends StatefulWidget {
  static const routeName = '/jobs';
  final JobDetail job;
  const JobsDetailsScreen({Key? key, required this.job}) : super(key: key);

  @override
  _JobsDetailsScreenState createState() => _JobsDetailsScreenState();
}

class _JobsDetailsScreenState extends State<JobsDetailsScreen> {
  final CollectionReference jobs =
      FirebaseFirestore.instance.collection('jobs');

  @override
  Widget build(BuildContext context) {
    final JobDetail job = widget.job;
    return SafeArea(
      child: Scaffold(
        appBar: SnowAppBar(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Theme.of(context).primaryColor.withOpacity(.1),
          padding: const EdgeInsets.all(10),
          child: Card(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(job.title ?? "Route",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Card(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(6),
                          child: Wrap(
                            direction: Axis.vertical,
                            children: [
                              Text("Description:",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(width: 2),
                              Text(job.description ?? "Preplanned route"),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DetailRow("Length", (job.length ?? "1.5") + " miles",
                          "Distance", (job.distance ?? "< 1") + " mi"),
                      DetailRow("Value", "\$" + (job.value ?? "15"), "Date",
                          (job.date ?? "Friday, Jan 3")),
                      DetailRow("Type", (job.type ?? "Standard Route"),
                          "Applicants", (job.applicants ?? "3")),
                      if (job.imageURL != null)
                        Image(
                          image: FirebaseImage(job.imageURL!),
                        )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: () {}, child: Text("Claim")),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String key1;
  final String value1;
  final String key2;
  final String value2;
  const DetailRow(
    this.key1,
    this.value1,
    this.key2,
    this.value2, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text("$key1:",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(width: 2),
              Text(value1),
            ],
          ),
          Row(
            children: [
              Text("$key2:",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(width: 2),
              Text(value2),
            ],
          ),
        ],
      ),
    );
  }
}
