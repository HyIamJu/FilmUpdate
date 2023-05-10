import 'package:flutter/material.dart';

import '../../../utils/color/custom_color.dart';
import '../../all_movie/screen/all_movie_screen.dart';

enum Type {
  discover,
  nowPlaying,
  popular,
  upComing,
}

class SectionTitleWidget extends StatelessWidget {
  const SectionTitleWidget({
    super.key,
    required this.screenPaddingHorizontal,
    required this.title,
    required this.type,
  });

  final EdgeInsets screenPaddingHorizontal;
  final String title;
  final Type type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: screenPaddingHorizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          TextButton(
            onPressed: () {
              switch (type) {
                case Type.discover:
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const AllMovieScreen(
                            type: MovieType.discover,
                          );
                        },
                      ),
                    );
                  }
                  break;
                case Type.popular:
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const AllMovieScreen(
                            type: MovieType.popular,
                          );
                        },
                      ),
                    );
                  }
                  break;
                case Type.nowPlaying:
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const AllMovieScreen(
                            type: MovieType.nowPlaying,
                          );
                        },
                      ),
                    );
                  }
                  break;
                case Type.upComing:
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const AllMovieScreen(
                            type: MovieType.upComing,
                          );
                        },
                      ),
                    );
                  }
                  break;
              }
            },
            child: const Text(
              "View All",
              style: TextStyle(
                  color: nicepurple, fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
