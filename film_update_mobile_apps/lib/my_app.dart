import 'package:film_update_mobile_apps/utils/theme.dart';
import 'package:film_update_mobile_apps/view/home/screen/home_screen.dart';
import 'package:film_update_mobile_apps/view/testApi/testApi_screen.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_discover_movie_provider.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_genre_movie_provider.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_now_playing_movie_provider.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_popular_movie_provider.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/get_top_rated_movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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
          create: (context) => GetTopRatedMovieProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: darkPurpleTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
