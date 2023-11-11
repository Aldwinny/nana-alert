import 'package:flutter/material.dart';
import 'package:nana_alert/utils/helper.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const routename = "/about";

  final TextStyle style =
      const TextStyle(fontFamily: "Poppins", fontSize: 17, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 46, 16, 128),
        appBar: AppBar(
          title: Text(
            "About the Developer",
            style: TextStyle(color: Colors.deepPurple[50]),
          ),
          iconTheme: IconThemeData(color: Colors.deepPurple[50]),
          backgroundColor: Colors.deepPurple[300],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          actions: <Widget>[],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.deepPurple[200],
                ),
                child: GestureDetector(
                  onTap: () => launchUrlString("https://aldwinny.github.io"),
                  child: Image.asset(
                    Helper.getAssetName("wiz.png"),
                    filterQuality: FilterQuality.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0).copyWith(top: 20),
                child: Text(
                    "Hi, I'm Aldwin Dennis L. Reyes. The developer of this app.\n\nI'm an currently a 4th Year student and an aspiring Mobile Developer\n\nVisit my Portfolio by clicking on the Icon.",
                    style: style),
              ),
            ],
          ),
        ));
  }
}
