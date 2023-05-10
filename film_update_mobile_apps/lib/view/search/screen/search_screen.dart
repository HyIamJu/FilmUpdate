import 'package:film_update_mobile_apps/utils/finite_state.dart';
import 'package:film_update_mobile_apps/utils/theme.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_search_movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/color/custom_color.dart';
import '../../details/screen/details_screen.dart';
import '../widget/item_search_widget.dart';

class SearchScreen extends SearchDelegate {
  // @override
  // ThemeData appBarTheme(BuildContext context) {
  //   return darkPurpleTheme;
  // }

  @override
  ThemeData appBarTheme(BuildContext context) {
    // You can use Theme.of(context) directly too

    final ThemeData theme = darkPurpleTheme;
    return theme.copyWith(
      appBarTheme: const AppBarTheme(
        toolbarHeight: 70,
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: darkpurple,
      ),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        hintStyle: theme.textTheme.labelSmall
            ?.copyWith(color: const Color.fromARGB(255, 228, 228, 228)),
        fillColor: softdarkpurple,
        filled: true,
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  TextStyle? get searchFieldStyle => darkPurpleTheme.textTheme.labelSmall;

  @override
  InputDecorationTheme? get searchFieldDecorationTheme =>
      const InputDecorationTheme(
        filled: true,
        fillColor: Colors.amber,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: nicepink),
        ),
      );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = "",
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        style: ButtonStyle(
            overlayColor:
                MaterialStatePropertyAll(nicepurple.withOpacity(0.5))),
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new));
  }

  @override
  Widget buildResults(BuildContext context) {
    const double vertical = 20;
    const double horizontal = 20;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (query.isNotEmpty) {
        context.read<GetSearchMovieProvider>().getSearchMovieData(query: query);
      }
    });

    return Consumer<GetSearchMovieProvider>(
        builder: (context, provider, child) {
      // if (provider.state == MyState.initial) {
      //   return const Center(
      //     child: Text(
      //       "Search movie",
      //       style: TextStyle(color: Colors.amber),
      //     ),
      //   );
      // }
      if (query == "") {
        return const Center(
          child: Text(
            "Search movie",
            // style: TextStyle(color: Colors.white),
          ),
        );
      }

      if (provider.state == MyState.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (provider.state == MyState.loaded) {
        // provider.getMovies[index].posterPath

        if (provider.getMovies.isNotEmpty) {
          return ListView.separated(
              padding: const EdgeInsets.symmetric(
                  vertical: vertical, horizontal: horizontal),
              itemBuilder: (context, index) => Stack(
                    children: [
                      ItemSearchWidget(
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        dataMovie: provider.getMovies[index],
                      ),
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            overlayColor: MaterialStatePropertyAll(
                                nicepurple.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              // close(context, null);
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
              separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                  ),
              itemCount: provider.getMovies.length);
        } else {
          return const Center(
            child: Text("Movie not found"),
          );
        }
      } else if (provider.state == MyState.failed) {
        return const Center(
          child: Text("Something went wrong"),
        );
      } else {
        return const Center(
          child: Text("Something went wrong"),
        );
      }
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // masih belum di pakai bagian sugestion
    return const SizedBox();
  }
}
