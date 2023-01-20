import 'dart:convert';

import 'package:flat/flat.dart';

/// Utility function that flattens Strapi API response
List<Map<String, dynamic>> flattenApiResponse(apiResponse) {
  var parsed = jsonDecode(apiResponse);
  var data = parsed['data'];

  List<Map<String, dynamic>> newList = [];
  for(var d in data) {
    var flatMap = flatten(d);
    Map<String, dynamic> newMap = {};

    flatMap.forEach((key, value) {
      String keyWithoutParent = key;
      if (key.contains('attributes')) {
        keyWithoutParent = key.split('.')[1];
      }

      newMap[keyWithoutParent] = value;
    });

    newList.add(newMap);
  }

  return newList;
}
