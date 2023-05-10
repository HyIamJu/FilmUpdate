import 'package:film_update_mobile_apps/utils/finite_state.dart';
import 'package:flutter/material.dart';

import '../../models/configuration_language.dart';
import '../../services/services_tmdb.dart';

class GetLanguageAll extends ChangeNotifier {
  List<LanguangeModel> languagesList = [];
  final tmdbServices = ServicesTmdb();

  MyState state = MyState.loading;

  void getLanguageData() async {
    try {
      final response = await tmdbServices.getLanguage();

      languagesList.addAll(response);

      state = MyState.loaded;
      notifyListeners();
      if (languagesList.isNotEmpty) {}
    } catch (e) {
      state = MyState.failed;
    }
  }

  String getSingleDataLanguage(String iso6391) {
    if (languagesList.isNotEmpty) {
      LanguangeModel tes =
          languagesList.where((data) => data.iso6391 == iso6391).first;

      return tes.englishName!;
    }

    return iso6391;
    // return language[0].;
  }
}
