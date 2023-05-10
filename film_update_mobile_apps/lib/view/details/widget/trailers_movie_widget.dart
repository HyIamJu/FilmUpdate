import 'package:film_update_mobile_apps/utils/color/custom_color.dart';
import 'package:film_update_mobile_apps/utils/finite_state.dart';
import 'package:film_update_mobile_apps/view/details/screen/youtube_player_screen.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_videos_movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailersMovieWidget extends StatefulWidget {
  const TrailersMovieWidget(
      {super.key,
      required this.screenHeight,
      required this.horizontal,
      required this.vertical,
      required this.movieId});

  final double screenHeight;
  // ignore: prefer_typing_uninitialized_variables
  final vertical;
  // ignore: prefer_typing_uninitialized_variables
  final horizontal;
  final int movieId;

  @override
  State<TrailersMovieWidget> createState() => _TrailersMovieWidgetState();
}

class _TrailersMovieWidgetState extends State<TrailersMovieWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetVideosMovieProvider>(
      builder: (context, provider, child) {
        if (provider.state == MyState.loading) {
          return SizedBox(
            height: widget.screenHeight * 0.2,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                  horizontal: widget.horizontal, vertical: 0),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        color: softdarkpurple,
                        child: const Center(
                            child: CircularProgressIndicator(
                          color: darkpurple,
                        )),
                      )),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 15),
            ),
          );
        } else if (provider.state == MyState.loaded) {
          if (provider.getMovieVideos.isEmpty) {
            return SizedBox(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.horizontal),
              child: Row(
                children: const [
                  Text(
                    "No videos for this movie",
                    style: TextStyle(),
                  ),
                ],
              ),
            ));
          }

          return SizedBox(
            height: widget.screenHeight * 0.2,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                  horizontal: widget.horizontal, vertical: 0),
              shrinkWrap: true,
              itemCount: provider.getMovieVideosLength,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          YoutubePlayer.getThumbnail(
                              videoId: provider.getMovieVideos[index].key),
                          fit: BoxFit.fitWidth,
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
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, 0, widget.vertical, widget.vertical),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                // providerGetDetail.getDetailsMovieData(movieId: movieId);
                                return YoutubePlayerScreen(
                                  ytKey: provider.getMovieVideos[index].key,
                                );
                              },
                            ));
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                            shape: const CircleBorder(),
                            // backgroundColor: nicepurple.withOpacity(0.5),
                            backgroundColor: Colors.black45,
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            size: 27,
                            color: Color.fromARGB(255, 226, 226, 226),
                            // color: Color.fromARGB(255, 200, 39, 28),
                            // color: nicepink,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 15),
            ),
          );
        } else if (provider.state == MyState.failed) {
          return const Center(
            child: Text("Something went wrong"),
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
