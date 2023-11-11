import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nana_alert/models/task_card.dart';
import 'package:nana_alert/screens/func/create_task_screen.dart';
import 'package:nana_alert/utils/helper.dart';

class PlannerOverlay extends StatefulWidget {
  const PlannerOverlay({super.key});

  @override
  State<PlannerOverlay> createState() => _PlannerOverlayState();
}

class _PlannerOverlayState extends State<PlannerOverlay> {
  void submitPlan(TaskCard card) {
    // Update firebase with the card
    // Reload the state
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(
                  top: 50.0, left: 30.0, right: 20.0, bottom: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Good Evening!",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins",
                        fontSize: 40),
                  ),
                  Text(
                    "User",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins",
                        fontSize: 30),
                  ),
                  SizedBox(height: 50),
                  Text(
                    "Here are your plans for this day:",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  PlannerCardExpanded(),
                  PlannerCardExpanded()
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "Plan a task:",
                      style: TextStyle(
                          color: Colors.deepPurple[900],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins"),
                    ),
                  ),
                  Material(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Feed the Baby",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Tuesday",
                                    style: TextStyle(
                                        fontFamily: "Poppins", fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            Material(
                              color: Colors.red,
                              clipBehavior: Clip.hardEdge,
                              borderRadius: BorderRadius.circular(100),
                              child: InkWell(
                                onTap: () {},
                                child: const Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, CreateTaskScreen.routeName);
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Create a new plan"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlannerCardExpanded extends StatelessWidget {
  const PlannerCardExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.darken),
            image: Image.asset(
              Helper.getAssetName("milk-high.jpg", "images"),
            ).image),
      ),
      child: Stack(
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Make Milk For Venice"),
                        content: const Text(
                            "This is the description added to firebase and lets see how long it can be "),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          )
                        ],
                      );
                    });
              },
              splashColor: Colors.purple.shade300.withOpacity(0.5),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Material(
                color: Colors.white,
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(100),
                child: InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.question_mark_rounded,
                      color: Colors.purple,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Make Milk For Venice",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  Text(
                    "Monday - Venice",
                    style: TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PlannerCardHidden extends StatelessWidget {
  const PlannerCardHidden({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
