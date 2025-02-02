import 'package:firebase_firestore_project/firebase_model/userInfo.dart';
import 'package:firebase_firestore_project/firebase_services/user_firebase_service.dart';
import 'package:flutter/material.dart';

class DetailedPage extends StatefulWidget {
   const DetailedPage({super.key,
   required this.instanceID});
  final String instanceID; //to get the generated ID

  @override
  State<DetailedPage> createState() => _DetailedPageState();
}

class _DetailedPageState extends State<DetailedPage> {
  UserInfo? userData; //instance of UserInfo
  late String userID; //variable to take the instance ID value
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    userID = widget.instanceID;
    print(userID);
    getUserInformation();
  }
  

  // getting document's fields
  Future<void> getUserInformation() async{
  var userDataFirebase = await UserFirebaseService().getUserFromFirebase(userID);
  setState(() {
    userData = userDataFirebase;
    isLoading = false; 
  });
   print(userData);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(userData != null ? "${userData!.name} Info" : "Loading..."),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())  // Show loading indicator 
          : userData != null
              ? ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        child: Row(
                          children: [
                            Text("Name: "),
                            Text("${userData!.name}")
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        child: Row(
                          children: [
                            Text("Age: "),
                            Text("${userData!.age}")
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        child: Row(
                          children: [
                            Text("Favorite Hobby: "),
                            Text("${userData!.favHobby}")
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Center(child: Text("No data found.")),  
    );
  }
}