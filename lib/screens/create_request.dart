import 'dart:io';

import 'package:buffalosnowco/widgets/app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class CreateRequestScreen extends StatefulWidget {
  static const routeName = '/jobs/create';
  const CreateRequestScreen({Key? key}) : super(key: key);

  @override
  _CreateRequestScreenState createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  final CollectionReference jobs =
      FirebaseFirestore.instance.collection('jobs');
  final _formKey = GlobalKey<FormBuilderState>();
  final ImagePicker _picker = ImagePicker();
  Reference? storageRef;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: SnowAppBar(),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  Text(
                    "Create Request",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        FormBuilderTextField(
                          name: 'title',
                          decoration: const InputDecoration(
                            labelText: 'Title description of issue',
                          ),
                          onChanged: (String? string) {},
                          // valueTransformer: (text) => num.tryParse(text),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.max(70),
                          ]),
                          keyboardType: TextInputType.number,
                        ),
                        FormBuilderTextField(
                          name: 'description',
                          decoration: const InputDecoration(
                            labelText:
                                'A more detailed description of the request/problem',
                          ),
                          onChanged: (String? string) {},
                          // valueTransformer: (text) => num.tryParse(text),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.max(70),
                          ]),
                          keyboardType: TextInputType.number,
                        ),
                        FormBuilderTextField(
                          name: 'address',
                          decoration: const InputDecoration(
                            labelText: 'The location of the request',
                          ),
                          onChanged: (String? string) {},
                          // valueTransformer: (text) => num.tryParse(text),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.max(70),
                          ]),
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton(
                      onPressed: () async {
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        if (image != null) {
                          storageRef =
                              FirebaseStorage.instance.ref().child(image.name);
                          try {
                            TaskSnapshot task =
                                await storageRef!.putFile(File(image.path));
                            print("DONE");
                            print(task.bytesTransferred);
                          } on FirebaseException catch (e) {
                            /// todo: handle upload exception
                          }
                        }
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.image),
                          const Text("Select an image from gallery"),
                        ],
                      )),
                  OutlinedButton(
                      onPressed: () async {
                        final XFile? photo =
                            await _picker.pickImage(source: ImageSource.camera);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.camera_alt),
                          Text("Capture image from camera"),
                        ],
                      )),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: MaterialButton(
                          color: Theme.of(context).colorScheme.primary,
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            _formKey.currentState!.save();

                            if (_formKey.currentState!.validate()) {
                              print(_formKey.currentState!.value);
                              await jobs.add({
                                'title': _formKey.currentState!.value['title'],
                                'description':
                                    _formKey.currentState!.value['description'],
                                'address':
                                    _formKey.currentState!.value['address'],
                                'createdAt': DateTime.now(),
                                'owner':
                                    FirebaseAuth.instance.currentUser?.uid ??
                                        "Anonymous",
                                'imageURL': storageRef != null
                                    ? ('gs://' +
                                        storageRef!.bucket +
                                        '/' +
                                        storageRef!.fullPath)
                                    : null,
                                'createdBy':
                                    FirebaseAuth.instance.currentUser?.uid ??
                                        "Anonymous",
                              });
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Job submitted'),
                                      content:
                                          Text('Thanks for submitting a job'),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Close')),
                                      ],
                                    );
                                  });
                            } else {
                              print("validation failed");
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: MaterialButton(
                          color: Theme.of(context).colorScheme.secondary,
                          child: Text(
                            "Reset",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            _formKey.currentState!.reset();
                          },
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            ),
          )),
    );
  }
}
