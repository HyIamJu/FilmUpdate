import 'package:carousel_slider/carousel_slider.dart';
import 'package:film_update_mobile_apps/utils/color/custom_color.dart';
import 'package:film_update_mobile_apps/utils/finite_state.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_discover_movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_constant.dart';

class DiscoverMovieComponent extends StatefulWidget {
  const DiscoverMovieComponent({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  State<DiscoverMovieComponent> createState() => _DiscoverMovieComponentState();
}

class _DiscoverMovieComponentState extends State<DiscoverMovieComponent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<GetDiscoverMovieProvider>().getDiscoverMovieData();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<GetDiscoverMovieProvider>(
        builder: (context, provider, child) {
          if (provider.state == MyState.loading) {
            return CarouselSlider.builder(
              itemCount: 3,
              options: CarouselOptions(
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                // enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                autoPlay: true,
                viewportFraction: 0.75,
                height: widget.screenHeight * 0.28,
                enlargeCenterPage: true,
              ),
              itemBuilder: (context, index, _) {
                return Container(
                  decoration: BoxDecoration(
                    color: softdarkpurple,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            );
          } else if (provider.state == MyState.loaded) {
            return CarouselSlider.builder(
              itemCount: provider.movieLength,
              options: CarouselOptions(
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                // enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                autoPlay: true,
                viewportFraction: 0.75,
                height: widget.screenHeight * 0.28,
                enlargeCenterPage: true,
              ),
              itemBuilder: (context, index, _) {
                return _ItemDiscoverMovie(
                    screenWidth: widget.screenWidth,
                    backdropPath: provider.getMovies[index].backdropPath,
                    title: provider.getMovies[index].title,
                    voteAverage: provider.getMovies[index].voteAverage);
              },
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

class _ItemDiscoverMovie extends StatelessWidget {
  const _ItemDiscoverMovie({
    // super.key,
    required this.screenWidth,
    this.backdropPath,
    required this.title,
    required this.voteAverage,
  });

  final double screenWidth;
  final String? backdropPath;
  final String title;
  final double voteAverage;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(40),
      child: Stack(children: [
        backdropPath == null
            ? Container(
                alignment: Alignment.center,
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
                AppConstant.imageUrlW500 + backdropPath!,
                fit: BoxFit.cover,
                height: double.maxFinite,
              ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                // Colors.red,
                Colors.transparent,
                Colors.black87,
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, vertical: screenWidth * 0.05),
            child: SizedBox(
              width: screenWidth * 0.65,
              // color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 20,
                        color: Colors.amber,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        voteAverage.toString(),
                        style: Theme.of(context).textTheme.labelLarge,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
