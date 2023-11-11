import 'package:flutter/material.dart';

class GuideItemScreen extends StatelessWidget {
  const GuideItemScreen({super.key});

  static const routename = "/guide/item";

  @override
  Widget build(BuildContext context) {
    final infoData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    var sortedKeys = infoData.keys.toList()..sort();
    var sortedMap = <String, dynamic>{};

    for (var key in sortedKeys) {
      sortedMap[key] = infoData[key];
    }

    final finalMap = {};

    sortedMap.forEach((key, value) {
      String modifiedKey = key.replaceAll("Ω", "");
      finalMap[modifiedKey] = value;
    });

    List<Widget> widgets = [];

    finalMap.forEach((key, value) {
      widgets.add(
        Text(
          key,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );

      if (value.runtimeType == String) {
        widgets.add(Text(
          value,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 17,
          ),
        ));
      } else {
        List<dynamic> mappedValue = value as List<dynamic>;
        mappedValue.forEach((element) {
          widgets.add(Text(
            element,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 17,
            ),
          ));
        });
      }
      widgets.add(
        const SizedBox(
          height: 10,
        ),
      );
    });

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Nana Alert Guides",
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widgets,
            ),
          ),
        ));
  }
}
