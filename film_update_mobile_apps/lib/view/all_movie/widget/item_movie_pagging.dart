import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/local_db_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../models/movie_model.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/color/custom_color.dart';
import '../../../utils/date_format.dart';

class ItemMoviePagging extends StatelessWidget {
  const ItemMoviePagging({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.dataItemMovie,
  });

  final double screenWidth;
  final double screenHeight;
  final MovieModel dataItemMovie;

  final bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      // height: screenHeight * 0.24,
      height: 180,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: softdarkpurple),
      child: Stack(
        children: [
          // -- background --
          Stack(
            fit: StackFit.expand,
            children: [
              Container(
                color: softdarkpurple,
              ),
              dataItemMovie.backdropPath == null
                  ? Container()
                  : Image.network(
                      AppConstant.imageUrlW500 + dataItemMovie.backdropPath!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                        child: Icon(Icons.wifi_off),
                      ),
                    ),

              // -- soft transparent black --
              Container(
                color: Colors.black38,
              ),

              // -- filter blur --
              ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          nicepurple
                          // nicepurple.withOpacity(1),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // --  section content layer --
          Row(
            // direction: Axis.horizontal,
            children: [
              // -- poster --
              Container(
                clipBehavior: Clip.antiAlias,
                width: screenWidth * 0.3,
                // height: screenHeight * 0.23,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: nicepurple,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      // color: nicepink.withOpacity(0.5),
                      blurRadius: 3,
                      offset: Offset(3, 0), // Shadow position
                    ),
                  ],
                ),
                child: dataItemMovie.posterPath != null
                    ? Image.network(
                        AppConstant.imageUrlW500 + dataItemMovie.posterPath!,
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
                      )
                    : const Center(child: Text("no image")),
              ),

              // -- spacing poster dan text section
              const SizedBox(
                width: 15,
              ),

              // -- text all --
              SizedBox(
                width: 170,
                // height: screenHeight * 0.19,
                // height: screenHeight * 0.23,
                // color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // -- title --
                    AutoSizeText(
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      minFontSize: 15,
                      dataItemMovie.title!,
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: screenHeight * 0.005,
                    ),

                    // -- date release --
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      dataItemMovie.releaseDate != "" &&
                              dataItemMovie.releaseDate != null
                          ? formatDateMMMdyyyy(dataItemMovie.releaseDate!)
                          : "_",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      // height: screenHeight * 0.015,
                      height: 10,
                    ),

                    // -- rating section --
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.horizontal,
                      children: [
                        RatingBar.builder(
                          ignoreGestures: true,
                          initialRating: dataItemMovie.voteAverage != null
                              ? dataItemMovie.voteAverage! / 2
                              : 0,

                          minRating: 1,
                          maxRating: 5,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          // itemSize: screenWidth * 0.055,
                          itemSize: 21,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        SizedBox(width: screenWidth * 0.015),
                        // -- rating text --
                        // AutoSizeText(
                        //   maxLines: 1,
                        //   overflow: TextOverflow.ellipsis,
                        //   dataItemMovie.voteAverage != null
                        //       ? dataItemMovie.voteAverage!.toStringAsFixed(1)
                        //       : "0.0",
                        //   style: GoogleFonts.openSans(
                        //       color: Colors.white,
                        //       fontSize: 14,
                        //       fontWeight: FontWeight.w500),
                        // )
                      ],
                    ),

                    // -- total votes --
                    Text(
                      maxLines: 1,
                      "${dataItemMovie.voteCount ?? '0'} votes",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),

          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Consumer<LocalDatabaseProvider>(
                    builder: (_, providerdb, __) {
                  return Icon(
                    Icons.favorite,
                    size: 28,
                    color: providerdb.isContainThisId(dataItemMovie.id!)
                        ? nicepink
                        : Colors.grey,
                  );
                })),
          )
        ],
      ),
    );
  }
}
