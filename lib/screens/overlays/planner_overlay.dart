import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nana_alert/models/task_card.dart';
import 'package:nana_alert/screens/func/create_task_screen.dart';
import 'package:nana_alert/services/document_service.dart';
import 'package:nana_alert/utils/helper.dart';
import 'package:intl/intl.dart';

class PlannerOverlay extends StatefulWidget {
  const PlannerOverlay({super.key});

  @override
  State<PlannerOverlay> createState() => _PlannerOverlayState();
}

class _PlannerOverlayState extends State<PlannerOverlay> {
  void submitPlan() {
    setState(() {});
  }

  List<TaskCard>? tasksList;
  List<TaskCard>? tasksToday;

  Future<void> getTasks() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      // Not logged in
      print("not logged in");
    } else {
      // Obtain docs related to this user
      final tasks = await DocumentService().getTasks(uid);

      if (tasks.isEmpty) {
        tasksList = null;
        tasksToday = null;
        return;
      } else {
        // Get current day
        DateTime now = DateTime.now();
        String formattedDay = DateFormat('EEEE').format(now);

        // Find the tasks for the current day
        List<Map<String, dynamic>> currentDayTasks = tasks
            .where(
              (_) => _['day'] == formattedDay,
            )
            .toList();

        List<TaskCard> todayTasksList = currentDayTasks
            .map((e) => TaskCard(
                e['title'], e['description'], e['day'], e['isComplete'],
                id: e['id']))
            .toList();
        List<TaskCard> allTasksList = tasks
            .map((e) => TaskCard(
                e['title'], e['description'], e['day'], e['isComplete'],
                id: e['id']))
            .toList();

        setState(() {
          tasksList = allTasksList;
          tasksToday = todayTasksList;
        });
      }
    }
  }

  Future<void> removeTask(String? id) async {
    try {
      // Remove from firebase
      DocumentReference docRef =
          FirebaseFirestore.instance.collection("tasks").doc(id);

      await docRef.delete();
    } catch (e) {
      print('Error deleting document!');
    }

    // setstate
    await getTasks();
  }

  Future<void> setTaskActivity(String? id, bool isComplete) async {
    // Update data
    try {
      // Remove from firebase
      DocumentReference docRef =
          FirebaseFirestore.instance.collection("tasks").doc(id);

      await docRef.update({'isComplete': isComplete});
    } catch (e) {
      print("Error updating document!");
    }

    await getTasks();
  }

  @override
  Widget build(BuildContext context) {
    List<PlannerCardExpanded>? cardsToday;
    List<PlannerCardHidden>? allCards;

    if (tasksToday != null) {
      cardsToday = tasksToday
          ?.map((e) => PlannerCardExpanded(card: e, onTap: setTaskActivity))
          .toList();
    }

    if (tasksList != null) {
      allCards = tasksList
          ?.map((e) => PlannerCardHidden(card: e, onTap: removeTask))
          .toList();
    }

    return RefreshIndicator(
      onRefresh: () async {
        await getTasks();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 50.0, left: 30.0, right: 20.0, bottom: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Good Evening!",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          fontSize: 40),
                    ),
                    const Text(
                      "User",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          fontSize: 30),
                    ),
                    const SizedBox(height: 50),
                    if (tasksToday != null)
                      const Text(
                        "Here are your plans for this day:",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )
                    else
                      const Text('You have no tasks for today. Take a break!',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                    if (cardsToday != null) ...cardsToday
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
                    if (allCards != null) ...allCards,
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, CreateTaskScreen.routeName,
                              arguments: () => submitPlan());
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
      ),
    );
  }
}

class PlannerCardExpanded extends StatelessWidget {
  const PlannerCardExpanded({super.key, this.onTap, required this.card});

  final TaskCard card;
  final void Function(String?, bool)? onTap;

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
                        title: Text(card.title),
                        content: Text(card.description),
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
                color: card.isComplete ? Colors.green : Colors.red,
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(100),
                child: InkWell(
                  onTap: onTap != null
                      ? () {
                          onTap!(card.id, !card.isComplete);
                        }
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      card.isComplete ? Icons.check : Icons.clear,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  Text(
                    card.day,
                    style: const TextStyle(
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
  const PlannerCardHidden({super.key, this.onTap, required this.card});

  final TaskCard card;
  final void Function(String?)? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(card.title),
                  content: Text(card.description),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card.title,
                      style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      card.day,
                      style:
                          const TextStyle(fontFamily: "Poppins", fontSize: 14),
                    ),
                  ],
                ),
              ),
              Material(
                color: Colors.red,
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(100),
                child: InkWell(
                  onTap: onTap != null
                      ? () {
                          onTap!(card.id);
                        }
                      : null,
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
    );
  }
}
