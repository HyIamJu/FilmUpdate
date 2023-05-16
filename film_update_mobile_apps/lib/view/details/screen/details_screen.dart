import 'package:film_update_mobile_apps/models/favorite_movie.dart';
import 'package:film_update_mobile_apps/utils/app_constant.dart';
import 'package:film_update_mobile_apps/utils/color/custom_color.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_details_movie_provider.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_language_provider.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_recomendations_movie.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_top_cast_provider.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/local_db_provider.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../utils/date_format.dart';
import '../../../utils/duration_format.dart';
import '../../../utils/finite_state.dart';
import '../../../viewmodel/services_provider/get_videos_movie_provider.dart';
import '../../all_movie/screen/all_movie_screen.dart';
import '../widget/recomendation_movies_widget.dart';
import '../widget/top_billed_cast_widget.dart';
import '../widget/trailers_movie_widget.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.movieId});

  final int movieId;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();

    context
        .read<GetDetailsMovieProvider>()
        .getDetailsMovieData(movieId: widget.movieId);

    context
        .read<GetRecomendationMovieProvider>()
        .getRecomendationMovieData(movieId: widget.movieId);

    context
        .read<GetVideosMovieProvider>()
        .getVideosMovieData(movieId: widget.movieId);

    context.read<GetTopCastProvider>().getTopCastData(movieId: widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    // final double appBarHeight = MediaQuery.of(context).padding.top;
    // final detailProvider =
    //     Provider.of<GetDetailsMovieProvider>(context, listen: false);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: _screenPaddingVertical,
        child: FloatingActionButton.small(
          elevation: 0,
          backgroundColor: Colors.black.withOpacity(0.18),
          splashColor: nicepurple,
          foregroundColor: Colors.white,
          highlightElevation: 0,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: const CircleBorder(),
          disabledElevation: 0,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
      ),
      body: Consumer<GetDetailsMovieProvider>(
        builder: (context, provider, child) {
          if (provider.state == MyState.initial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.state == MyState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.state == MyState.loaded) {
            return ListView(
              padding: const EdgeInsets.only(top: 0),
              physics: const ClampingScrollPhysics(),
              children: [
                // -- image backdrop --
                SizedBox(
                  height: screenHeight * 0.3,
                  child: Stack(
                    children: [
                      // SizedBox(
                      //     height: screenHeight * 0.3,
                      //     width: screenWidth,
                      //     child: Shimmer.fromColors(
                      //         child: Container(child: Text(" ")),
                      //         baseColor: Colors.red,
                      //         highlightColor: Colors.cyan)),
                      SizedBox(
                        width: screenWidth,
                        child: provider.getDetails.backdropPath != null
                            ? Image.network(
                                height: screenHeight * 0.3,
                                "${AppConstant.imageUrlOriginal}${provider.getDetails.backdropPath}",
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                    Center(
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
                              )
                            : Container(
                                alignment: Alignment.center,
                                height: double.infinity,
                                color: softdarkpurple,
                                child: const Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  direction: Axis.vertical,
                                  children: [
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
                      Container(
                        height: screenHeight * 0.3,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            colors: [
                              // Colors.red,
                              Colors.transparent,
                              Colors.black45,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Padding(
                          // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          padding: EdgeInsets.fromLTRB(_vertical + 8,
                              _vertical + 8, _vertical + 8, _vertical * 0.5),
                          child: Consumer<LocalDatabaseProvider>(
                              builder: (context, providerLocalDb, __) {
                            return LikeButton(
                              onTap: (isLiked) async {
                                OverlayState overlayState = Overlay.of(context);

                                if (isLiked == false) {
                                  providerLocalDb.addFavorite(
                                    FavoriteMovieModel(
                                      idMovie: provider.getDetails.id,
                                      titleMovie: provider.getDetails.title,
                                      dateMovie:
                                          provider.getDetails.releaseDate,
                                      posterPathMovie:
                                          provider.getDetails.posterPath,
                                    ),
                                  );

                                  showTopSnackBar(
                                    animationDuration: const Duration(
                                        seconds: 1, milliseconds: 500),
                                    displayDuration: const Duration(seconds: 1),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.2,
                                        vertical: screenHeight * 0.01),
                                    overlayState,
                                    CustomSnackBar.success(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .titleSmall!,
                                      borderRadius: BorderRadius.circular(30),
                                      backgroundColor: nicepurple,
                                      message:
                                          "berhasil menambahkan ${provider.getDetails.title}",
                                    ),
                                  );
                                  return true;
                                }

                                if (isLiked == true) {
                                  providerLocalDb
                                      .deleteFavorite(provider.getDetails.id);
                                  showTopSnackBar(
                                    displayDuration: const Duration(seconds: 1),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.2,
                                        vertical: screenHeight * 0.01),
                                    overlayState,
                                    CustomSnackBar.info(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .titleSmall!,
                                      borderRadius: BorderRadius.circular(30),
                                      backgroundColor: softdarkpurple.shade400,
                                      message:
                                          "Menghapus ${provider.getDetails.title}",
                                    ),
                                  );
                                  return false;
                                }

                                return null;
                              },
                              // isLiked: false,
                              isLiked: providerLocalDb
                                  .isContainThisId(widget.movieId),

                              size: 35,
                              // circleSize: 20,
                              circleColor: const CircleColor(
                                  start: softdarkpurple, end: nicepink),
                              bubblesColor: const BubblesColor(
                                  dotPrimaryColor: nicepurple,
                                  dotSecondaryColor: nicepink),
                            );
                          }),
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(
                  height: screenHeight * 0.02,
                ),

                // -- section title --
                Padding(
                  padding: EdgeInsets.only(
                      top: _vertical, right: _horizontal, left: _horizontal),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        direction: Axis.vertical,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.65,
                            child: Text(
                              provider.getDetails.originalTitle,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: screenWidth * 0.65,
                            child: provider.getDetails.genres.isNotEmpty
                                ? Text(
                                    provider.getGenres(),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  )
                                : Text(
                                    "-",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                          ),
                        ],
                      ),
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                provider.getDetails.voteAverage
                                    .toStringAsPrecision(2),
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.star,
                                size: 28,
                                color: Colors.amber,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: screenWidth * 0.2,
                            child: Text(
                                textAlign: TextAlign.center,
                                "${provider.getDetails.voteCount} votes",
                                style: Theme.of(context).textTheme.bodySmall),
                          )
                        ],
                      )
                    ],
                  ),
                ),

                SizedBox(
                  height: screenHeight * 0.04,
                ),

                // -- section release, language, duration row --
                Padding(
                  padding: _screenPaddingHorizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Release",
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              provider.getDetails.releaseDate != "" &&
                                      provider.getDetails.releaseDate != null
                                  ? formatDateMMMdyyyy(
                                      provider.getDetails.releaseDate!)
                                  : "_ ",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      SizedBox(
                        width: screenWidth * 0.25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Language",
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Consumer<GetLanguageAll>(
                              builder: (context, providerLanguage, child) {
                                if (providerLanguage.languagesList.isEmpty) {
                                  return Text(
                                    " ",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  );
                                }

                                return Text(
                                  providerLanguage.getSingleDataLanguage(
                                      provider.getDetails.originalLanguage),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      SizedBox(
                        width: screenWidth * 0.25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Duration",
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              durationFormat(
                                  runtime: provider.getDetails.runtime!),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),

                // -- section overview --
                Padding(
                  padding: _screenPaddingHorizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Overview",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        provider.getDetails.overview!,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                ),

                SizedBox(
                  height: screenHeight * 0.04,
                ),

                // -- trailers section --
                Padding(
                  padding: _screenPaddingHorizontal,
                  child: Text(
                    "Trailers",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // -- trailers listview --
                TrailersMovieWidget(
                    movieId: widget.movieId,
                    screenHeight: screenHeight,
                    horizontal: _horizontal,
                    vertical: _vertical),
                SizedBox(
                  height: screenHeight * 0.05,
                ),

                // -- top billed cast section --
                Padding(
                  padding: _screenPaddingHorizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top Billed Cast",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const Icon(
                        Icons.chevron_right,
                        size: 25,
                        color: nicepurple,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TopBilledCastWidget(
                    movieId: widget.movieId,
                    screenWidth: screenWidth,
                    horizontal: _horizontal),

                SizedBox(
                  height: screenHeight * 0.01,
                ),

                // section recomendation
                Padding(
                  padding: _screenPaddingHorizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recommendations",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Consumer<GetRecomendationMovieProvider>(
                          builder: (context, provider, child) {
                        if (provider.state == MyState.loaded) {
                          if (provider.getMovies.isNotEmpty &&
                              provider.movieLength != 0) {
                            return TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return AllMovieScreen(
                                        type: MovieType.recomendation,
                                        movieId: widget.movieId,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: const Text(
                                "View All",
                                style: TextStyle(
                                    color: nicepurple,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        } else {
                          return Container();
                        }
                      }),
                    ],
                  ),
                ),
                RecomendationMovieWidget(
                    movieId: widget.movieId,
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    paddingHorizontal: _horizontal),
              ],
            );
          } else if (provider.state == MyState.failed) {
            const Center(
              child: Text(
                "eror",
                style: TextStyle(color: Colors.amber),
              ),
            );
            return Container();
          } else {
            return const Center(
              child: Text("eror di else"),
            );
          }
        },
      ),
    );
  }
}

double _vertical = 10;
double _horizontal = 20;
final EdgeInsets _screenPaddingVertical =
    EdgeInsets.symmetric(vertical: _vertical);
EdgeInsets _screenPaddingHorizontal =
    EdgeInsets.symmetric(horizontal: _horizontal);
