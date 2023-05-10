import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:film_update_mobile_apps/utils/color/custom_color.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:page_transition/page_transition.dart';
import 'package:film_update_mobile_apps/utils/theme.dart';
import 'package:film_update_mobile_apps/view/home/screen/home_screen.dart';
import 'package:film_update_mobile_apps/viewmodel/home_viewmodel/home_screen_provider.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_details_movie_provider.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_discover_movie_provider.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_genre_movie_provider.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_now_playing_movie_provider.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_popular_movie_provider.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_recomendations_movie.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_search_movie_provider.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_top_cast_provider.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_up_coming_movie_provider.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_videos_movie_provider.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/local_db_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewmodel/services_provider/get_language_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetDiscoverMovieProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetGenreMovieProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetNowPlayingMovieProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetPopularMovieProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetUpComingMovieProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetLanguageAll()..getLanguageData(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetDetailsMovieProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetVideosMovieProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetRecomendationMovieProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetSearchMovieProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetTopCastProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalDatabaseProvider()..getAllFavorite(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Film Update',
        theme: darkPurpleTheme,
        home: AnimatedSplashScreen(
            curve: Curves.bounceOut,
            animationDuration: const Duration(seconds: 1),
            duration: 2000,
            splash: Image.asset("assets/logoFilm.png"),
            // splash: Image.asset("assets/about_animation.gif"),
            nextScreen: const HomeScreen(),
            splashTransition: SplashTransition.scaleTransition,
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: darkpurple),
      ),
    );
  }
}
