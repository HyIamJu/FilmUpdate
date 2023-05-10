import 'package:film_update_mobile_apps/models/movie_model.dart';
import 'package:film_update_mobile_apps/utils/color/custom_color.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_discover_movie_provider.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_genre_movie_provider.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_now_playing_movie_provider.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_popular_movie_provider.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_recomendations_movie.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_up_coming_movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import '../../../models/movie_genre.dart';
import '../../details/screen/details_screen.dart';
import '../widget/item_movie_pagging.dart';

enum MovieType {
  discover,
  nowPlaying,
  popular,
  upComing,
  recomendation,
  byGenre
}

class AllMovieScreen extends StatefulWidget {
  const AllMovieScreen(
      {super.key, this.movieId, this.genre, required this.type});

  final MovieType type;
  final int? movieId;
  final GenreModel? genre;

  @override
  State<AllMovieScreen> createState() => _AllMovieScreenState();
}

double _vertical = 20;
double _horizontal = 20;
// EdgeInsets _screenPaddingVertical = EdgeInsets.symmetric(vertical: _vertical);
// EdgeInsets _screenPaddingHorizontal =
//     EdgeInsets.symmetric(horizontal: _horizontal);

int pageKeys = 1;

class _AllMovieScreenState extends State<AllMovieScreen> {
  final PagingController<int, MovieModel> _pagingController =
      PagingController(firstPageKey: pageKeys);
  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((page) {
      switch (widget.type) {
        case MovieType.byGenre:
          {
            context.read<GetGenreMovieProvider>().getMovieByeGenrePagging(
                  context: context,
                  pageControler: _pagingController,
                  pageKey: page,
                  genreId: widget.genre!.id,
                );
          }
          break;
        case MovieType.discover:
          {
            context.read<GetDiscoverMovieProvider>().getDiscoverWithPagging(
                context: context,
                pageKey: page,
                pageControler: _pagingController);
          }
          break;

        case MovieType.nowPlaying:
          {
            context.read<GetNowPlayingMovieProvider>().getNowPlayingWithPagging(
                context: context,
                pageKey: page,
                pageControler: _pagingController);
          }
          break;

        case MovieType.popular:
          {
            context.read<GetPopularMovieProvider>().getMoviePopularWithPagging(
                context: context,
                pageKey: page,
                pageControler: _pagingController);
          }
          break;
        case MovieType.upComing:
          {
            context.read<GetUpComingMovieProvider>().getUpComingWithPagging(
                context: context,
                pageKey: page,
                pageControler: _pagingController);
          }
          break;
        case MovieType.recomendation:
          {
            context
                .read<GetRecomendationMovieProvider>()
                .getRecomendationWithPagging(
                    movieId: widget.movieId!,
                    context: context,
                    pageKey: page,
                    pageControler: _pagingController);
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    // final double appBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          // systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: nicepurple),
          surfaceTintColor: Colors.transparent,
          backgroundColor: darkpurple,
          // title: const Text("Discover Movie"),
          title: Builder(builder: (_) {
            switch (widget.type) {
              case MovieType.discover:
                return Text(
                  'Discover Movies',
                  style: Theme.of(context).textTheme.titleMedium,
                );
              case MovieType.popular:
                return Text(
                  'Popular Movies',
                  style: Theme.of(context).textTheme.titleMedium,
                );
              case MovieType.nowPlaying:
                return Text(
                  'Now Playing Movies',
                  style: Theme.of(context).textTheme.titleMedium,
                );
              case MovieType.upComing:
                return Text(
                  'Upcoming Movies',
                  style: Theme.of(context).textTheme.titleMedium,
                );
              case MovieType.byGenre:
                return Text(
                  widget.genre!.name,
                  style: Theme.of(context).textTheme.titleMedium,
                );
              case MovieType.recomendation:
                return Text(
                  'Recomendation Movies',
                  style: Theme.of(context).textTheme.titleMedium,
                );
            }
          }),
          leading: IconButton(
              style: ButtonStyle(
                  overlayColor:
                      MaterialStatePropertyAll(nicepurple.withOpacity(0.5))),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
        ),
        body: PagedListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            vertical: _vertical,
            horizontal: _horizontal,
          ),
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<MovieModel>(
            itemBuilder: (context, data, index) => Stack(
              children: [
                ItemMoviePagging(
                    dataItemMovie: data,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight),
                Positioned.fill(
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          overlayColor: MaterialStatePropertyAll(
                              nicepurple.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(40),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return DetailsScreen(
                                    movieId: data.id!,
                                  );
                                },
                              ),
                            );
                          },
                        )))
              ],
            ),
          ),
          separatorBuilder: (context, index) =>
              SizedBox(height: screenHeight * 0.04),
        ));
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
