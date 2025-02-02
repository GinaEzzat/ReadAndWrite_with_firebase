import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_firestore_project/screens/details_page.dart';
import 'package:flutter/material.dart';

class UserInputForm extends StatefulWidget {
  const UserInputForm({super.key});

  @override
  State<UserInputForm> createState() => _UserInputFormState();
}

class _UserInputFormState extends State<UserInputForm> {
  // variables for form validation
  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController favHobbyconroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  // string for the document generated ID
  String instanceID = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // heading of the form
          Text(
            "Form",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
            textAlign: TextAlign.center,
          ),
          // form inputs
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    // name field
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              controller: namecontroller,
                              decoration: InputDecoration(
                                hintText: "Type your name",
                              ),
                              validator: (value) { //validation for non empty fields
                                if (value != null && value.isEmpty) {
                                  return "field can't be empty";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    // age field
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Age",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              controller: agecontroller,
                              decoration: InputDecoration(
                                hintText: "Type your age",
                              ),
                              validator: (value) {
                                if (value != null && value.isEmpty) {//validation for non empty fields and length of age digits
                                  return "field can't be empty";
                                } else if (value != null && value.length > 2) {
                                  return "age can't be more than 2 numbers";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Favorite Hobby",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              controller: favHobbyconroller,
                              decoration: InputDecoration(
                                hintText: "Type your Favorite Hobby",
                              ),
                              validator: (value) {
                                if (value != null && value.isEmpty) {//validation for non empty
                                  return "field can't be empty";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {//checking if form fields are valid
                                    var db = FirebaseFirestore.instance; //firebasefirestore instance
                                    // Add a new document with a generated id to the collection
                                    final data = {
                                      "name": namecontroller.text,
                                      "age": agecontroller.text,
                                      "favHobby": favHobbyconroller.text
                                    };
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("data have been saved")));
                                    db
                                        .collection("info")
                                        .add(data)
                                        .then((documentSnapshot) { // clearing data after saving them
                                      namecontroller.clear();
                                      agecontroller.clear();
                                      favHobbyconroller.clear();
                                      print(
                                          "Added Data with ID: ${documentSnapshot.id}");
                                      instanceID = documentSnapshot.id;
                                      print(instanceID);
                                    });
                                  }
                                },
                                child: Text("save info")),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (instanceID.isNotEmpty) {//navigate to saved data page
                                  print("instance id = " + instanceID);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailedPage(
                                              instanceID: instanceID)));
                                } else {
                                  print("no data to show");
                                }
                              },
                              child: Text("show data"))
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
