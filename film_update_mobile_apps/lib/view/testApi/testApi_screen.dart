import 'package:film_update_mobile_apps/viewmodel/services_provider/get_discover_movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/finite_state.dart';

class TestApi extends StatefulWidget {
  const TestApi({super.key});

  @override
  State<TestApi> createState() => _TestApiState();
}

class _TestApiState extends State<TestApi> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                context.read<GetDiscoverMovieProvider>().getDiscoverMovieData();
              },
              child: Text("Get Data"),
            ),
            Consumer<GetDiscoverMovieProvider>(
              builder: (context, provider, _) {
                if (provider.state == MyState.initial) {
                  return Container(
                    height: 200,
                    color: Colors.amber,
                  );
                } else if (provider.state == MyState.loaded) {
                  return ListView.builder(
                    itemCount: provider.movieLength,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final movie = provider.getMovies[index];
                      return ListTile(
                        title: Text(movie.title),
                        subtitle: Text(movie.overview),
                      );
                    },
                  );
                } else if (provider.state == MyState.loading) {
                  return const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (provider.state == MyState.failed) {
                  return const Center(
                    child: Text("eror disini"),
                  );
                } else {
                  return const Center(
                    child: Text("Error ngab"),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
