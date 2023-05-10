import 'package:film_update_mobile_apps/view/all_movie/screen/all_movie_screen.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_genre_movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/color/custom_color.dart';
import '../../../utils/finite_state.dart';

class GenreMovieWidget extends StatefulWidget {
  const GenreMovieWidget({
    super.key,
    required this.screenPaddingHorizontal,
  });

  final EdgeInsets screenPaddingHorizontal;

  @override
  State<GenreMovieWidget> createState() => _GenreMovieWidgetState();
}

class _GenreMovieWidgetState extends State<GenreMovieWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Consumer<GetGenreMovieProvider>(
        builder: (context, provider, child) {
          if (provider.state == MyState.loading) {
            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: widget.screenPaddingHorizontal,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) => Container(
                width: 100,
                decoration: BoxDecoration(
                    color: softdarkpurple,
                    borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              separatorBuilder: (context, index) =>
                  SizedBox(width: MediaQuery.of(context).size.width * 0.04),
            );
          } else if (provider.state == MyState.loaded) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: widget.screenPaddingHorizontal,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: provider.genre.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return AllMovieScreen(
                              type: MovieType.byGenre,
                              genre: provider.genre[index],
                            );
                          },
                        ),
                      );
                    },
                    style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(nicepurple),
                        padding: const MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 20),
                        ),
                        backgroundColor:
                            const MaterialStatePropertyAll(softdarkpurple)),
                    child: Text(
                      provider.genre[index].name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
              ),
              separatorBuilder: (context, index) =>
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),
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
