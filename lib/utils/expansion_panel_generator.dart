import 'package:flutter/material.dart';

List<ExpansionPanel> generateExpansionPanels(
    List<String> titles, List<Widget> bodies, List<bool> isOpen) {
  if (titles.length != bodies.length || titles.length != isOpen.length) {
    throw Exception(
        "The List of Titles, Bodies, IsOpenStates must be of the same length.");
  }

  return List<ExpansionPanel>.generate(
      titles.length,
          (i) => ExpansionPanel(
          canTapOnHeader: true,
          isExpanded: isOpen[i],
          headerBuilder: (context, isOpen) {
            return Padding(
                padding: const EdgeInsets.all(16),
                child: Text(titles[i],
                    style: isOpen
                        ? const TextStyle(fontWeight: FontWeight.bold)
                        : null));
          },
          body:
          Padding(padding: const EdgeInsets.all(16), child: bodies[i])));
}