import 'package:flutter/material.dart';

import '../app_constant.dart';
import '../color/custom_color.dart';
import '../date_format.dart';

class ItemMoviePosterWidget extends StatelessWidget {
  const ItemMoviePosterWidget({
    super.key,
    required this.movieId,
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
  final int movieId;

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                width: screenWidth * 0.37,
                height: screenHeight * 0.27,
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
                                  color: darkpurple,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    : Image.network(
                        AppConstant.imageUrlW500 + poster!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            direction: Axis.vertical,
                            children: [
                              const Icon(Icons.wifi_off),
                              Text(
                                "connection eror",
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            ],
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 3,
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.02),
                child: SizedBox(
                  width: screenWidth * 0.35,
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.02),
                child: (dateRelease.isEmpty)
                    ? const Text("-")
                    : Text(formatDateMMMdyyyy(dateRelease)),
              ),
            ],
          ),
          // Positioned.fill(
          //     child: Material(
          //   color: Colors.transparent,
          //   child: InkWell(
          //     overlayColor:
          //         MaterialStatePropertyAll(nicepurple.withOpacity(0.15)),
          //     borderRadius: BorderRadius.circular(20),
          //     onTap: () {

          //       // providerGetDetail.getDetailsMovieData(movieId: movieId);

          //       // Navigator.push(
          //       //   context,
          //       //   MaterialPageRoute(
          //       //     builder: (context) {

          //       //       return DetailsScreen(
          //       //         movieId: movieId,
          //       //       );
          //       //     },
          //       //   ),
          //       // );
          //     },
          //   ),
          // )),
        ],
      ),
    );
  }
}
