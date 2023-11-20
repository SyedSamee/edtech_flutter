import 'package:edtech_flutter/config/utils.dart';
import 'package:flutter/widgets.dart';

class BookmarkWidget extends StatelessWidget {
  const BookmarkWidget({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * .85,
      height: screenHeight * .4,
      decoration: BoxDecoration(
        color: Utils().secColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: [
        SizedBox(
          height: screenHeight * .02,
        ),
        Text(
          "Bookmarks",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: screenHeight * .04,
        ),
        Container(
            width: screenWidth * .35,
            height: screenHeight * .25,
            // color: Colors.white,
            alignment: Alignment.center,
            child: ListView.builder(itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(14.0),
                child: Center(
                    child: Text(
                  "1:00",
                )),
              );
            }))
      ]),
    );
  }
}
