import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:film_update_mobile_apps/utils/color/custom_color.dart';
import 'package:film_update_mobile_apps/view/search/screen/search_screen.dart';
import 'package:film_update_mobile_apps/viewmodel/home_viewmodel/home_screen_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../viewmodel/services_provider/get_discover_movie_provider.dart';
import '../../../viewmodel/services_provider/get_genre_movie_provider.dart';
import '../../../viewmodel/services_provider/get_now_playing_movie_provider.dart';
import '../../../viewmodel/services_provider/get_popular_movie_provider.dart';
import '../../../viewmodel/services_provider/get_up_coming_movie_provider.dart';
import '../../contact_me/contact_me_screen.dart';
import '../../favorite/screen/favorite_screen.dart';
import '../widget/discover_movie_widget.dart';
import '../widget/genre_movie_widget.dart';
import '../widget/now_playing_widget.dart';

import '../widget/title_section_widget.dart';
import '../widget/up_coming_widget.dart';
import '../widget/whats_popular_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// double _vertical = 10;
double _horizontal = 20;
// EdgeInsets _screenPaddingVertical = EdgeInsets.symmetric(vertical: _vertical);
EdgeInsets _screenPaddingHorizontal =
    EdgeInsets.symmetric(horizontal: _horizontal);

class _HomeScreenState extends State<HomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();
  @override
  void initState() {
    context.read<GetDiscoverMovieProvider>().getDiscoverMovieData();
    context.read<GetGenreMovieProvider>().getAllGenreList();
    context.read<GetNowPlayingMovieProvider>().getNowPlayingMovieData();
    context.read<GetUpComingMovieProvider>().getUpComingMovieData();
    context.read<GetPopularMovieProvider>().getPopularMovieData();

    super.initState();

    // context.read<GetLanguageAll>().getLanguageData();
  }

  @override
  Widget build(BuildContext context) {
    // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final double appBarHeight = MediaQuery.of(context).padding.top;

    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          // color: darkpurple.shade800,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 43, 21, 121),
              nicepurple.shade700,
            ],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOutQuad,
      animationDuration: const Duration(milliseconds: 400),
      animateChildDecoration: true,
      rtlOpening: true,
      // openScale: 1.0,
      disabledGestures: true,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(8, 8),
            color: Colors.black26,
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: DrawerCustomWidget(
        screenHeight: screenHeight,
        controller: _advancedDrawerController,
      ),

      // ----------------scaffold --------------------------------
      child: Scaffold(
        // ----------------body --------------------------------
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // ----------------appBar --------------------------------
            SliverAppBar(
              floating: true,
              // pinned: true,
              foregroundColor: nicepink,
              shadowColor: Colors.transparent,
              surfaceTintColor: nicepurple,
              backgroundColor: Colors.transparent,

              title: SizedBox(
                  height: appBarHeight,
                  child: Image.asset(
                    "assets/logoFilm.png",
                    // "assets/gif/about_animation.gif",
                    fit: BoxFit.fitHeight,
                  )),

              actions: [
                IconButton(
                  onPressed: _handleMenuButtonPressed,
                  icon: ValueListenableBuilder<AdvancedDrawerValue>(
                    valueListenable: _advancedDrawerController,
                    builder: (_, value, __) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: Icon(
                          value.visible ? Icons.clear : Icons.menu,
                          key: ValueKey<bool>(value.visible),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            // ----------------body content --------------------------------
            Consumer<HomeScreenProvider>(
              builder: (_, provider, __) {
                // -------- home section --------------
                if (provider.pageSection == PageSection.home) {
                  return HomeScreens(
                      screenWidth: screenWidth, screenHeight: screenHeight);

                  // -------- favorite section --------------
                } else if (provider.pageSection == PageSection.favorite) {
                  return FavoriteScreen(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      horizontal: _horizontal);

                  // -------- about section --------------
                } else {
                  return ContactMeScreen(screenHeight: screenHeight);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}

class HomeScreens extends StatelessWidget {
  const HomeScreens({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        // explore text------------
        Container(
          padding: _screenPaddingHorizontal,
          width: screenWidth * 0.6,
          child: Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.02,
            ),

            child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: 90,
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.titleLarge!,
                  child: AnimatedTextKit(
                    pause: const Duration(seconds: 10),
                    repeatForever: true,
                    animatedTexts: [
                      TypewriterAnimatedText(
                          speed: const Duration(milliseconds: 150),
                          'Explore\nThe Newest\nTrending Movies'),
                    ],
                  ),
                ),
              ),
            ),
            // child: Text(
            //   "Explore\nThe Newest\nTrending Movies",
            //   style: Theme.of(context).textTheme.titleLarge,
            // ),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.03,
        ),

        // Search field------------
        Padding(
          padding: _screenPaddingHorizontal,
          child: TextField(
            readOnly: true,
            onTap: () => showSearch(
              context: context,
              delegate: SearchScreen(),
            ),
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
        SizedBox(height: screenHeight * 0.03),

        // Genre text------------
        Padding(
          padding: _screenPaddingHorizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Genre",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const Icon(
                Icons.chevron_right,
                size: 30,
                color: nicepurple,
              )
            ],
          ),
        ),
        // genre content----------
        GenreMovieWidget(screenPaddingHorizontal: _screenPaddingHorizontal),

        // -- Text discover movie
        _SpacingWidget(height: screenHeight * 0.03),
        SectionTitleWidget(
            screenPaddingHorizontal: _screenPaddingHorizontal,
            title: "Discover Movie",
            type: Type.discover),
        _SpacingWidget(height: screenHeight * 0.01),
        // -- carousel discover movie
        DiscoverMovieComponent(
            screenHeight: screenHeight, screenWidth: screenWidth),
        _SpacingWidget(height: screenHeight * 0.03),
        SectionTitleWidget(
            screenPaddingHorizontal: _screenPaddingHorizontal,
            title: "Now Playing",
            type: Type.nowPlaying),
        _SpacingWidget(height: screenHeight * 0.005),

        // -- now playing --
        NowPlaying(
            screenHeight: screenHeight,
            screenPaddingHorizontal: _screenPaddingHorizontal,
            screenWidth: screenWidth),

        SectionTitleWidget(
            screenPaddingHorizontal: _screenPaddingHorizontal,
            title: "What's Popular",
            type: Type.popular),
        _SpacingWidget(height: screenHeight * 0.005),

        // -- What's Popular --
        WhatsPopular(
            screenHeight: screenHeight,
            screenPaddingHorizontal: _screenPaddingHorizontal,
            screenWidth: screenWidth),
        SectionTitleWidget(
            screenPaddingHorizontal: _screenPaddingHorizontal,
            title: "Up Coming",
            type: Type.upComing),
        _SpacingWidget(height: screenHeight * 0.005),

        // -- top rated --
        UpComing(
            screenHeight: screenHeight,
            screenPaddingHorizontal: _screenPaddingHorizontal,
            screenWidth: screenWidth),
        SizedBox(
          height: screenHeight * 0.005,
        )
      ]),
    );
  }
}

class DrawerCustomWidget extends StatelessWidget {
  const DrawerCustomWidget({
    super.key,
    required this.screenHeight,
    required this.controller,
  });

  final AdvancedDrawerController controller;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 128.0,
                height: 128.0,
                margin: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 64.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colors.black12,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 20, 18, 20),
                  child: Image.asset(
                    width: 50,
                    height: 50,
                    "assets/logoFilmNoText.png",
                  ),
                ),
              ),
              Consumer<HomeScreenProvider>(builder: (_, provider, __) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    color: provider.pageSection == PageSection.home
                        ? nicepurple
                        : Colors.transparent,
                    child: Material(
                      color: Colors.transparent,
                      child: ListTile(
                        onTap: () {
                          if (context.read<HomeScreenProvider>().pageSection !=
                              PageSection.home) {
                            controller.hideDrawer();
                            context
                                .read<HomeScreenProvider>()
                                .changeSection(PageSection.home);
                          }
                        },
                        leading: const Icon(Icons.home_rounded),
                        title: const Text('Home'),
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(
                height: 10,
              ),
              Consumer<HomeScreenProvider>(builder: (_, provider, __) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    color: provider.pageSection == PageSection.favorite
                        ? nicepurple
                        : Colors.transparent,
                    child: Material(
                      color: Colors.transparent,
                      child: ListTile(
                        onTap: () {
                          if (context.read<HomeScreenProvider>().pageSection !=
                              PageSection.favorite) {
                            controller.hideDrawer();
                            context
                                .read<HomeScreenProvider>()
                                .changeSection(PageSection.favorite);
                          }
                        },
                        leading: const Icon(Icons.favorite_rounded),
                        title: const Text('Favorite'),
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(
                height: 10,
              ),
              Consumer<HomeScreenProvider>(builder: (_, provider, __) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    color: provider.pageSection == PageSection.contactMe
                        ? nicepurple
                        : Colors.transparent,
                    child: Material(
                      color: Colors.transparent,
                      child: ListTile(
                        onTap: () {
                          if (context.read<HomeScreenProvider>().pageSection !=
                              PageSection.contactMe) {
                            controller.hideDrawer();
                            context
                                .read<HomeScreenProvider>()
                                .changeSection(PageSection.contactMe);
                          }
                        },
                        leading: const Icon(Icons.message_rounded),
                        title: const Text('Contact Me'),
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(
                height: 10,
              ),
              Consumer<HomeScreenProvider>(builder: (_, provider, __) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Material(
                    color: Colors.transparent,
                    child: ListTile(
                      onTap: () {
                        QuickAlert.show(
                          backgroundColor: nicepurple,
                          widget: SizedBox(
                            height: 130,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Film Update Alpha 1.0",
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text:
                                            "To see the source code for this app, please visit the ",
                                      ),
                                      TextSpan(
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 102, 186, 255)),
                                        text: "FilmUpdate Github Repository",
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            String url =
                                                "https://github.com/HyIamJu/FilmUpdate";

                                            if (!await launchUrl(
                                                Uri.parse(url))) {
                                              throw Exception(
                                                  'Could not launch $url');
                                            }
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text("© 2023 HyIamJu"),
                              ],
                            ),
                          ),
                          customAsset: "assets/about_animation.gif",
                          animType: QuickAlertAnimType.scale,
                          title: " ",
                          confirmBtnColor: nicepink,
                          context: context,
                          type: QuickAlertType.info,
                        );
                      },
                      leading: const Icon(Icons.info),
                      title: const Text('About'),
                    ),
                  ),
                );
              }),
              SizedBox(
                height: screenHeight * 0.2,
              ),
              DefaultTextStyle(
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: const Text('Made with love  ❤'),
                ),
              ),
            ],
          ),
        ),
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
    return SizedBox(
      height: height,
    );
  }
}
