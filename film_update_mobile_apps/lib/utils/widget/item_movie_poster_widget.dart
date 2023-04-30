import 'package:flutter/material.dart';

import '../app_constant.dart';
import '../color/custom_color.dart';
import '../date_format.dart';

class ItemMoviePosterWidget extends StatelessWidget {
  const ItemMoviePosterWidget({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.title,
    required this.dateRelease,
    this.poster,
  });

  final double screenWidth;
  final double screenHeight;

  final String title;
  final String? poster;
  final String dateRelease;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              child: poster == null
                  ? Container(
                      alignment: Alignment.center,
                      height: double.infinity,
                      color: softdarkpurple,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        direction: Axis.vertical,
                        children: const [
                          Icon(
                            Icons.image,
                            color: darkpurple,
                          ),
                          Text(
                            "No Image",
                            style: TextStyle(
                                color: darkpurple, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  : Image.network(
                      AppConstant.imageUrlW500 + poster!,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(
              height: 3,
            ),
            SizedBox(
              width: screenWidth * 0.37,
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(formatDateMMMdyyyy(dateRelease)),
          ],
        ));
  }
}
