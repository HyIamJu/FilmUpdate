import 'package:flutter/material.dart';

import '../color/custom_color.dart';

class ItemMoviePosterLoadingWidget extends StatelessWidget {
  const ItemMoviePosterLoadingWidget({
    super.key,
    required this.screenPaddingHorizontal,
    required this.screenWidth,
    required this.screenHeight,
  });

  final EdgeInsets screenPaddingHorizontal;
  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: screenPaddingHorizontal,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.fromLTRB(0, 8, screenWidth * 0.05, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              width: screenWidth * 0.37,
              height: screenHeight * 0.28,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Container(
                  alignment: Alignment.center,
                  height: double.infinity,
                  color: softdarkpurple,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  )),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              height: 10,
              width: screenWidth * 0.1,
              decoration: BoxDecoration(
                  color: softdarkpurple,
                  borderRadius: BorderRadius.circular(20)),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              height: 10,
              width: screenWidth * 0.2,
              decoration: BoxDecoration(
                  color: softdarkpurple,
                  borderRadius: BorderRadius.circular(20)),
            ),
          ],
        ),
      ),
    );
  }
}
