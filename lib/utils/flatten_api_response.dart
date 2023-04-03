import 'dart:convert';

import 'package:flat/flat.dart';

Map<String, dynamic> _dataToMap(data) {
  // preventing empty array to cause infinite loop here!
  if (data.toString() == "[]") {
    return {};
  }

  var flatMap = flatten(data as Map<String, dynamic>, maxDepth: 2);
  Map<String, dynamic> newMap = {};

  flatMap.forEach((key, value) {
    String keyWithoutParent = key;
    if (key.contains('attributes')) {
      // update key without parent:
      List<String> split = key.split('.');
      keyWithoutParent = split[1];
    }

    // is value clean?
    if (value.toString().contains("data")) {
      print("Doing a recursive call on $value of type ${value.runtimeType}");
      value = _dataToMap(value['data']);
    }

    newMap[keyWithoutParent] = value;
  });
  return newMap;
}

/// Utility function that flattens Strapi API response
List<Map<String, dynamic>> flattenApiResponse(String apiResponse) {
  var parsed = jsonDecode(apiResponse);
  var data = parsed['data'];

  List<Map<String, dynamic>> newList = [];
  for (var d in data) {
    var newMap = _dataToMap(d);
    newList.add(newMap);
  }

  return newList;
}
