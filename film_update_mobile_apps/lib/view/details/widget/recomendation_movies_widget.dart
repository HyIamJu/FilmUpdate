import 'package:film_update_mobile_apps/viewmodel/services_provider/get_recomendations_movie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/color/custom_color.dart';
import '../../../utils/finite_state.dart';
import '../../../utils/widget/item_movie_poster_loading_widget.dart';
import '../../../utils/widget/item_movie_poster_widget.dart';
import '../screen/details_screen.dart';

class RecomendationMovieWidget extends StatefulWidget {
  const RecomendationMovieWidget(
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.paddingHorizontal,
      required this.movieId});

  final double screenHeight;
  final double screenWidth;
  final double paddingHorizontal;
  final int movieId;

  @override
  State<RecomendationMovieWidget> createState() =>
      _RecomendationMovieWidgetState();
}

class _RecomendationMovieWidgetState extends State<RecomendationMovieWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: widget.screenHeight * 0.38),
      child: Consumer<GetRecomendationMovieProvider>(
        builder: (context, provider, child) {
          if (provider.state == MyState.loading) {
            return ItemMoviePosterLoadingWidget(
                screenPaddingHorizontal:
                    EdgeInsets.symmetric(horizontal: widget.paddingHorizontal),
                screenWidth: widget.screenWidth,
                screenHeight: widget.screenHeight);
          } else if (provider.state == MyState.loaded) {
            if (provider.getMovies.isEmpty) {
              return Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: widget.paddingHorizontal),
                child: const Wrap(
                  direction: Axis.vertical,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "No recomendation for this movie",
                      // style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              );
            }

            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding:
                  EdgeInsets.symmetric(horizontal: widget.paddingHorizontal),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: provider.movieLength,
              itemBuilder: (context, index) => Stack(
                children: [
                  ItemMoviePosterWidget(
                    movieId: provider.getMovies[index].id!,
                    screenWidth: widget.screenWidth,
                    screenHeight: widget.screenHeight,
                    dateRelease: provider.getMovies[index].releaseDate!,
                    title: provider.getMovies[index].title!,
                    poster: provider.getMovies[index].posterPath,
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        overlayColor: MaterialStatePropertyAll(
                            nicepurple.withOpacity(0.15)),
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return DetailsScreen(
                                  movieId: provider.getMovies[index].id!,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              separatorBuilder: (context, index) =>
                  SizedBox(width: widget.screenWidth * 0.04),
            );
          } else if (provider.state == MyState.failed) {
            return Container();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
