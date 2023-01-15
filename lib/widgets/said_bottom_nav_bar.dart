import 'package:flutter/material.dart';
import 'package:said/config/color_constants.dart';

class SaidBottomNavigationBar extends StatelessWidget {
  const SaidBottomNavigationBar(
      {Key? key,
      required this.icons,
      required this.labels,
      required this.selectedIndex,
      required this.onTap})
      : super(key: key);

  final List<Icon> icons;
  final List<String> labels;
  final int selectedIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        selectedItemColor: ColorConstants.secondaryColor,
        unselectedItemColor: Colors.blueGrey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.shifting,
        items: List<BottomNavigationBarItem>.generate(
            icons.length,
            (i) => BottomNavigationBarItem(
                icon: icons[i],
                label: labels[i],
                backgroundColor: ColorConstants.backgroundColor)),
        currentIndex: selectedIndex,
        onTap: onTap);
  }
}
