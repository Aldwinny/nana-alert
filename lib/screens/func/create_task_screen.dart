import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  static const routeName = "/task";
  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _dayController =
      TextEditingController(text: "Monday");
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final formButtonTextStyle =
      const TextStyle(fontFamily: "Poppins", fontSize: 15);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Create a Plan",
            style: TextStyle(color: Colors.deepPurple[50]),
          ),
          iconTheme: IconThemeData(color: Colors.deepPurple[50]),
          backgroundColor: Colors.deepPurple[300],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          actions: const <Widget>[],
        ),
        backgroundColor: Colors.deepPurple[50],
        body: Container(
          padding: EdgeInsets.all(20.0),
          width: MediaQuery.sizeOf(context).width,
          child: SingleChildScrollView(
              child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                DropdownMenu(
                    dropdownMenuEntries: const <DropdownMenuEntry>[
                      DropdownMenuEntry(value: 'Monday', label: 'Monday'),
                      DropdownMenuEntry(value: 'Tuesday', label: 'Tuesday'),
                      DropdownMenuEntry(value: 'Wednesday', label: 'Wednesday'),
                      DropdownMenuEntry(value: 'Thursday', label: 'Thursday'),
                      DropdownMenuEntry(value: 'Friday', label: 'Friday'),
                      DropdownMenuEntry(value: 'Saturday', label: 'Saturday'),
                      DropdownMenuEntry(value: 'Sunday', label: 'Sunday'),
                    ],
                    controller: _dayController,
                    label: Text("Select the day for this plan")),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: "Title"),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length > 20) {
                      return "Please enter your title";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: "Description",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length > 20) {
                      return "Please enter your description";
                    } else {
                      return null;
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        // Check if user exists
                        if (FirebaseAuth.instance.currentUser == null) {
                          Navigator.popUntil(context, (route) => route.isFirst);
                          return;
                        }

                        User? user = FirebaseAuth.instance.currentUser;

                        if (user == null) {
                          return Navigator.popUntil(
                              context, (route) => route.isFirst);
                        } else {}

                        // If valid, submit to Firebase Firestore

                        // Call the callback then pop
                      }
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.person,
                              color: Colors.deepPurple[50],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 5.0),
                            child: Text(
                              'Login',
                              style: formButtonTextStyle.copyWith(
                                  color: Colors.deepPurple[50]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ));
  }
}
