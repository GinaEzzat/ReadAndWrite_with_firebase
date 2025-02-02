# firebase_firestore_project

A new Flutter project that takes some info from the user and displays it and saves it on Firestore.

# used dependencies
cloud_firestore: https://pub.dev/packages/cloud_firestore
firebase_core: https://pub.dev/packages/firebase_core

# Form page
this widget has the UI.
a form with some validations.
it has two buttons, one for saving data on firebase and the other to navigate to a new page that shows the data the user has saved.
"db" is a firebasefirestore instance we create to save the data.

after saving data a snackbar shows a message that data have been saved and the fields get clear.

the prints are just for tracing.

firebase stores the new data with an auto generated ID.

# Detailed page
this widget shows the data the user has saved earlier.

initState() function to assign the document id to the userID variable to get the data.
and to call the getUserInformation() function.

getUserInformation() function uses the getUserFromFirebase() function from service class and get the document data by passing the document id,
and assigning the data to the UserInfo instance.

# UserInfo model
model for the user by firestore.

# UserFirebaseService
has an instance of FirebaseFirestore and the getUserFromFirebase() function

# firebase_project
we create a project on firebase and connect it with the flutter project.
we added the dependencies,
then we build firestore database and initiate a collection to add documents to it.
in rules we set read and write to true instead of false to be ble to add documents and get documents from the collection.



