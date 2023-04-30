import 'package:film_update_mobile_apps/utils/finite_state.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_now_playing_movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/widget/item_movie_poster_loading_widget.dart';
import '../../../utils/widget/item_movie_poster_widget.dart';

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
    // TODO: implement initState
    super.initState();
    context.read<GetNowPlayingMovieProvider>().getNowPlayingMovieData();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: widget.screenHeight * 0.38),
        child: Consumer<GetNowPlayingMovieProvider>(
          builder: (context, provider, child) {
            if (provider.state == MyState.loading) {
              return ItemMoviePosterLoadingWidget(
                  screenPaddingHorizontal: widget.screenPaddingHorizontal,
                  screenWidth: widget.screenWidth,
                  screenHeight: widget.screenHeight);
            } else if (provider.state == MyState.loaded) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: widget.screenPaddingHorizontal,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (context, index) => ItemMoviePosterWidget(
                  screenWidth: widget.screenWidth,
                  screenHeight: widget.screenHeight,
                  dateRelease: provider.getMovies[index].releaseDate,
                  title: provider.getMovies[index].title,
                  poster: provider.getMovies[index].posterPath,
                ),
              );
            } else if (provider.state == MyState.failed) {
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
