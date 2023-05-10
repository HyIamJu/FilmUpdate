import 'package:auto_size_text/auto_size_text.dart';
import 'package:film_update_mobile_apps/models/favorite_movie.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_constant.dart';
import '../../../utils/color/custom_color.dart';
import '../../../utils/date_format.dart';

class ItemFavoriteWidget extends StatelessWidget {
  const ItemFavoriteWidget({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.dataMovie,
  });
  final FavoriteMovieModel dataMovie;
  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: softdarkpurple,
      ),
      height: 130,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,

                  nicepurple.shade800
                  // nicepurple.withOpacity(1),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                width: screenWidth * 0.27,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: nicepurple.shade800,
                ),
                child: dataMovie.posterPathMovie != null
                    ? Image.network(
                        AppConstant.imageUrlW500 + dataMovie.posterPathMovie!,
                        fit: BoxFit.cover)
                    : const Center(
                        child: Text("no image"),
                      ),
              ),
              SizedBox(
                width: screenWidth * 0.03,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: screenWidth * 0.44,
                      child: AutoSizeText(
                        minFontSize: 15,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        dataMovie.titleMovie != null
                            ? dataMovie.titleMovie!
                            : "_",
                        style: Theme.of(context).textTheme.displaySmall,
                      )),
                  SizedBox(
                    height: screenHeight * 0.012,
                  ),
                  SizedBox(
                      width: screenWidth * 0.44,
                      child: Text(
                        dataMovie.dateMovie != "" && dataMovie.dateMovie != null
                            ? formatDateMMMdyyyy(dataMovie.dateMovie!)
                            : "_",
                        style: Theme.of(context).textTheme.bodyMedium,
                      )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
