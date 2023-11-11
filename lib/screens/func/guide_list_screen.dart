import 'package:flutter/material.dart';
import 'package:nana_alert/screens/func/guide_item_screen.dart';
import 'package:nana_alert/services/document_service.dart';

class GuideListScreen extends StatefulWidget {
  const GuideListScreen({super.key});

  static const routename = '/guide';

  @override
  State<GuideListScreen> createState() => _GuideListScreenState();
}

class _GuideListScreenState extends State<GuideListScreen> {
  Future<String> _fetchData() async {
    await Future.delayed(Duration(seconds: 2));
    return 'Data loaded successfully!';
  }

  @override
  Widget build(BuildContext context) {
    final dbAddress = ModalRoute.of(context)!.settings.arguments as String;

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
        actions: <Widget>[],
      ),
      backgroundColor: Colors.deepPurple[50],
      body: FutureBuilder(
        future: DocumentService().getDocument(dbAddress),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError) {
                print(snapshot.error);
                return Text("An Error has occurred in fetching your data..");
              }

              List<Widget> widgets = [];

              print(snapshot.data!['list']);

              Map<String, dynamic> listSnapshotData = snapshot.data!['list'];

              listSnapshotData.forEach((key, value) {
                widgets.add(ListTile(
                  title: Text(key),
                  onTap: () {
                    Navigator.pushNamed(context, GuideItemScreen.routename,
                        arguments: value);
                  },
                  trailing: Icon(Icons.arrow_forward_ios),
                ));
              });

              // final listSnapshot =
              //     snapshot.data!['list'] as List<Map<String, String>>;

              // print(listSnapshot);

              return Column(children: widgets);
          }
        },
      ),
    );
  }
}
