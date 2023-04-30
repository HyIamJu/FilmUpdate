import 'package:film_update_mobile_apps/utils/color/custom_color.dart';

import 'package:flutter/material.dart';

import '../widget/discover_movie_widget.dart';
import '../widget/genre_movie_widget.dart';
import '../widget/now_playing_widget.dart';
import '../widget/top_rated_widget.dart';
import '../widget/whats_popular_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final double appBarHeight = MediaQuery.of(context).padding.top;
    double vertical = 10;
    double horizontal = 15;
    EdgeInsets screenPaddingVertical = EdgeInsets.symmetric(vertical: vertical);
    EdgeInsets screenPaddingHorizontal =
        EdgeInsets.symmetric(horizontal: horizontal);
    return Scaffold(
      endDrawer: const Drawer(),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            // pinned: true,
            foregroundColor: nicepink,
            shadowColor: Colors.transparent,
            surfaceTintColor: nicepurple,
            backgroundColor: Colors.transparent,

            title: SizedBox(
                height: appBarHeight * 0.56,
                child: Image.asset(
                  "assets/logoFilm.png",
                  fit: BoxFit.fitHeight,
                )),

            // actions: [
            //   TextButton(
            //     onPressed: () {
            //       Scaffold.of(context).openDrawer();
            //     },
            //     child: const Icon(Icons.menu, color: nicepink),
            //   ),
            // ],
          ),

          //--text explore the--
          SliverToBoxAdapter(
            child: Container(
              padding: screenPaddingHorizontal,
              width: screenWidth * 0.6,
              child: Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.02,
                ),
                child: Text(
                  "Explore\nThe Newest\nTrending Movies",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ),
          _SpacingWidget(height: screenHeight * 0.03),
          // --search button--
          SliverToBoxAdapter(
            child: Padding(
              padding: screenPaddingHorizontal,
              child: TextField(
                style: Theme.of(context).textTheme.labelSmall,
                decoration: InputDecoration(
                  hintText: "Search Movie",
                  hintStyle: Theme.of(context).textTheme.labelSmall,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 30, right: 10),
                    child: Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  filled: true,
                  fillColor: softdarkpurple,
                ),
              ),
            ),
          ),
          _SpacingWidget(height: screenHeight * 0.04),

          // -- genre text --
          SliverToBoxAdapter(
            child: Padding(
              padding: screenPaddingHorizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Genre",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Icon(
                    Icons.chevron_right,
                    size: 30,
                    color: nicepurple,
                  )
                ],
              ),
            ),
          ),
          // -- list view genre button --
          GenreMovieWidget(screenPaddingHorizontal: screenPaddingHorizontal),
          _SpacingWidget(height: screenHeight * 0.02),

          // -- discover movie
          _SectionTitleWidget(
              screenPaddingHorizontal: screenPaddingHorizontal,
              title: "Discover Movie"),
          _SpacingWidget(height: screenHeight * 0.01),
          // -- carousel discover movie
          DiscoverMovieComponent(
              screenHeight: screenHeight, screenWidth: screenWidth),
          _SpacingWidget(height: screenHeight * 0.02),
          _SectionTitleWidget(
              screenPaddingHorizontal: screenPaddingHorizontal,
              title: "Now Playing"),

          // -- now playing --
          NowPlaying(
              screenHeight: screenHeight,
              screenPaddingHorizontal: screenPaddingHorizontal,
              screenWidth: screenWidth),

          _SectionTitleWidget(
              screenPaddingHorizontal: screenPaddingHorizontal,
              title: "What's Popular"),

          // -- What's Popular --
          WhatsPopular(
              screenHeight: screenHeight,
              screenPaddingHorizontal: screenPaddingHorizontal,
              screenWidth: screenWidth),
          _SectionTitleWidget(
              screenPaddingHorizontal: screenPaddingHorizontal,
              title: "Top Rated"),

          // -- top rated --
          TopRated(
              screenHeight: screenHeight,
              screenPaddingHorizontal: screenPaddingHorizontal,
              screenWidth: screenWidth),
        ],
      ),
    );
  }
}

class _SpacingWidget extends StatelessWidget {
  const _SpacingWidget({
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: height,
      ),
    );
  }
}

class _SectionTitleWidget extends StatelessWidget {
  const _SectionTitleWidget({
    super.key,
    required this.screenPaddingHorizontal,
    required this.title,
  });

  final EdgeInsets screenPaddingHorizontal;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: screenPaddingHorizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                "View All",
                style: TextStyle(
                    color: nicepurple,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
