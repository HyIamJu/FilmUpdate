import 'package:film_update_mobile_apps/utils/app_constant.dart';
import 'package:film_update_mobile_apps/utils/finite_state.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_top_cast_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/color/custom_color.dart';

class TopBilledCastWidget extends StatelessWidget {
  const TopBilledCastWidget({
    super.key,
    required this.screenWidth,
    required this.horizontal,
    required this.movieId,
  });

  final double screenWidth;
  final double horizontal;

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return Consumer<GetTopCastProvider>(
      builder: (context, provider, child) {
        if (provider.state == MyState.initial) {}

        if (provider.state == MyState.loaded) {
          if (provider.getCastLength == 0) {
            return Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: horizontal, vertical: 0),
              child: const Text(
                "No videos for this movie",
                style: TextStyle(),
              ),
            );
          }

          return SizedBox(
            height: screenWidth * 0.58,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding:
                  EdgeInsets.symmetric(horizontal: horizontal, vertical: 0),
              shrinkWrap: true,
              itemCount:
                  provider.getCastLength <= 15 ? provider.getCastLength : 15,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: provider.getCast[index].profilePath != null
                            ? Image.network(
                                width: screenWidth * 0.38,
                                height: screenWidth * 0.375,
                                "${AppConstant.imageUrlW500}${provider.getCast[index].profilePath}",
                                fit: BoxFit.fitWidth,
                                errorBuilder: (context, error, stackTrace) =>
                                    SizedBox(
                                  width: screenWidth * 0.38,
                                  height: screenWidth * 0.375,
                                  child: Center(
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      direction: Axis.vertical,
                                      children: [
                                        const Icon(Icons.wifi_off),
                                        Text(
                                          "connection eror",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                alignment: Alignment.center,
                                width: screenWidth * 0.38,
                                height: screenWidth * 0.375,
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
                              ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        width: screenWidth * 0.4,
                        child: RichText(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: <TextSpan>[
                              // TextSpan(
                              //   text:
                              //       "asdadadadadadadadadaasdasdadadasdasdasdasd",
                              //   style: Theme.of(context)
                              //       .textTheme
                              //       .titleSmall,
                              // ),
                              TextSpan(
                                text: provider.getCast[index].name,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const TextSpan(text: "\n"),
                              TextSpan(
                                text: provider.getCast[index].character,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  SizedBox(width: screenWidth * 0.02),
            ),
          );
        } else if (provider.state == MyState.loading) {
          return LimitedBox(
            maxHeight: 240,
            // maxHeight: screenHeight * 0.35,
            // maxHeight: screenHeight * 0.4,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding:
                  EdgeInsets.symmetric(horizontal: horizontal, vertical: 0),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  color: softdarkpurple.shade800,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                              // borderRadius: BorderRadius.circular(25),
                              child: SizedBox(
                            width: screenWidth * 0.36,
                            height: screenWidth * 0.375,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )),
                          const SizedBox(
                            height: 7,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            width: screenWidth * 0.15,
                            height: 10,
                            decoration: BoxDecoration(
                                color: softdarkpurple.shade500,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            width: screenWidth * 0.2,
                            height: 10,
                            decoration: BoxDecoration(
                                color: softdarkpurple.shade500,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  SizedBox(width: screenWidth * 0.015),
            ),
          );
        } else {
          return const Center(
            child: Text("Something went wrong"),
          );
        }
      },
    );
  }
}
