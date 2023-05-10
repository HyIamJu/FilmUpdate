import 'package:film_update_mobile_apps/utils/finite_state.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_now_playing_movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/color/custom_color.dart';
import '../../../utils/widget/item_movie_poster_loading_widget.dart';
import '../../../utils/widget/item_movie_poster_widget.dart';
import '../../details/screen/details_screen.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({
    super.key,
    required this.screenHeight,
    required this.screenPaddingHorizontal,
    required this.screenWidth,
  });

  final double screenHeight;
  final EdgeInsets screenPaddingHorizontal;
  final double screenWidth;

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: widget.screenHeight * 0.38),
      child: Consumer<GetNowPlayingMovieProvider>(
        builder: (context, provider, child) {
          if (provider.state == MyState.loading) {
            return ItemMoviePosterLoadingWidget(
                screenPaddingHorizontal: widget.screenPaddingHorizontal,
                screenWidth: widget.screenWidth,
                screenHeight: widget.screenHeight);
          } else if (provider.state == MyState.loaded) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: widget.screenPaddingHorizontal,
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
                          Navigator.push(
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
