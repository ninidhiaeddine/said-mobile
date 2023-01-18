import 'package:flutter/material.dart';

navigateToRoute(BuildContext context, Widget route) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => route));
}
