import 'package:flutter/material.dart';

class GuideTitleCard extends StatelessWidget {
  const GuideTitleCard(this.title,
      {super.key,
      this.titleTextStyle,
      this.linkTextStyle,
      this.description,
      this.margin = 6.0,
      required this.linkLabel,
      required this.image});

  final double margin;
  final String title;
  final String? description;
  final String linkLabel;
  final TextStyle? titleTextStyle;
  final TextStyle? linkTextStyle;
  final ImageProvider<Object> image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: margin),
      height: 170,
      width: MediaQuery.sizeOf(context).width * 0.90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Stack(children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  Text(title, style: titleTextStyle),
                  if (description != null)
                    Text(description!, style: titleTextStyle),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white),
              child: Material(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: InkWell(
                  onTap: () => {print("hello")},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8),
                    child: Text(
                      linkLabel,
                      style: linkTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
