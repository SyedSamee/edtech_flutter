import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: screenWidth * .85,
          height: screenHeight * .3,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(20)),
        ),
        SizedBox(
          height: screenHeight * .04,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Course 101",
                style: TextStyle(fontSize: 17),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.bookmark_outline,
                    size: 30,
                    color: Colors.black,
                  ))
            ],
          ),
        )
      ],
    );
  }
}
