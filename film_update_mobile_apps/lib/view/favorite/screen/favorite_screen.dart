import 'package:film_update_mobile_apps/view/favorite/widget/item_favorite_widget.dart';
import 'package:film_update_mobile_apps/viewmodel/services_provider/local_db_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../utils/color/custom_color.dart';
import '../../details/screen/details_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.horizontal,
  });

  final double screenHeight;
  final double screenWidth;
  final double horizontal;

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalDatabaseProvider>(builder: (_, providerLocalDb, __) {
      if (providerLocalDb.favoriteModels.isEmpty) {
        return SliverToBoxAdapter(
          child: Container(
            alignment: Alignment.center,
            height: screenHeight,
            child: const Text("data is empty"),
          ),
        );
      }

      return SliverList(
        delegate: SliverChildBuilderDelegate(
            childCount: providerLocalDb.favoriteLength,
            (context, index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontal),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          Stack(
                            children: [
                              // -----------  item -------------
                              ItemFavoriteWidget(
                                  screenWidth: screenWidth,
                                  screenHeight: screenHeight,
                                  dataMovie: providerLocalDb
                                      .favoriteModels.reversed
                                      .toList()[index]),

                              // ----------- inkwell item -------------
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
                                              movieId: providerLocalDb
                                                  .favoriteModels.reversed
                                                  .toList()[index]
                                                  .idMovie!,
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
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),

                      // ----------- button item -------------
                      Positioned.fill(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                  splashRadius: 60,
                                  iconSize: 30,
                                  onPressed: () {
                                    providerLocalDb.deleteFavorite(
                                        providerLocalDb.favoriteModels.reversed
                                            .toList()[index]
                                            .idMovie!);
                                    OverlayState overlayState =
                                        Overlay.of(context);

                                    showTopSnackBar(
                                      displayDuration:
                                          const Duration(seconds: 1),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.2,
                                          vertical: screenHeight * 0.01),
                                      overlayState,
                                      CustomSnackBar.info(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .titleSmall!,
                                        borderRadius: BorderRadius.circular(30),
                                        backgroundColor: softdarkpurple,
                                        message:
                                            "Menghapus ${providerLocalDb.favoriteModels.reversed.toList()[index].titleMovie}",
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.delete_rounded)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
      );
    });
  }
}
