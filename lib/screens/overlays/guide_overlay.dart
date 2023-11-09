import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nana_alert/utils/helper.dart';
import 'package:nana_alert/widgets/guide_title_card.dart';

class GuideOverlay extends StatefulWidget {
  const GuideOverlay({super.key});

  @override
  State<GuideOverlay> createState() => _GuideOverlayState();
}

class _GuideOverlayState extends State<GuideOverlay> {
  TextStyle darkCardTitleStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 17,
      fontFamily: "Poppins",
      letterSpacing: 1.3);
  final TextStyle darkCardLabelStyle =
      const TextStyle(color: Colors.black, fontFamily: "Poppins");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GuideTitleCard("Guide to Childcare",
                linkLabel: "Learn More About Child Care Here >",
                titleTextStyle: darkCardTitleStyle,
                linkTextStyle: darkCardLabelStyle,
                image: Image.asset(
                  Helper.getAssetName("child-low.jpg", "images"),
                ).image),
            GuideTitleCard("First aid for Children",
                linkLabel: "Learn About First Aid For Children Here >",
                titleTextStyle: darkCardTitleStyle,
                linkTextStyle: darkCardLabelStyle,
                image: Image.asset(
                  Helper.getAssetName("first-aid-low.jpg", "images"),
                ).image),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GuideRowButton(
                    "Milk Tips",
                    assetName: Helper.getAssetName("milk.svg", "svg"),
                  ),
                  GuideRowButton(
                    "Guides",
                    assetName: Helper.getAssetName("bookmark.svg", "svg"),
                  ),
                  GuideRowButton(
                    "Help Hotline",
                    assetName: Helper.getAssetName('emergency.svg', 'svg'),
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

class GuideRowButton extends StatelessWidget {
  const GuideRowButton(
    this.title, {
    super.key,
    required this.assetName,
  });

  final String title;
  final String assetName;

  final TextStyle style = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.w500, fontFamily: 'Poppins');

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      child: Ink(
        width: MediaQuery.sizeOf(context).width * 0.28,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: const Alignment(0.8, 1),
            colors: <Color>[
              Colors.deepPurple.shade200,
              Colors.deepPurple.shade400,
            ], // Gradient from https://learnui.design/tools/gradient-generator.html
            tileMode: TileMode.mirror,
          ),
        ),
        child: InkWell(
          onTap: () => {},
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
            child: Column(
              children: <Widget>[
                SvgPicture.asset(
                  width: 60,
                  assetName,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(title,
                      overflow: TextOverflow.ellipsis, style: style),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
