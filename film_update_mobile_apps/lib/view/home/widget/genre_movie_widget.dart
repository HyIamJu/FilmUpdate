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
    // TODO: implement initState
    super.initState();
    context.read<GetGenreMovieProvider>().getAllGenreList();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 55,
        child: Consumer<GetGenreMovieProvider>(
          builder: (context, provider, child) {
            if (provider.state == MyState.loading) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: widget.screenPaddingHorizontal,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                        color: softdarkpurple,
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
              );
            } else if (provider.state == MyState.loaded) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: widget.screenPaddingHorizontal,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        backgroundColor: softdarkpurple,
                      ),
                      child: Text(
                        provider.genre[index].name,
                        style: Theme.of(context).textTheme.labelSmall,
                      )),
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
