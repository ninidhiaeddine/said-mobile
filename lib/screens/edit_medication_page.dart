import 'package:flutter/material.dart';
import 'package:said/services/models/user.dart';

class EditMedicationPage extends StatefulWidget {
  const EditMedicationPage({Key? key, required this.authenticatedUser}) : super(key: key);

  final User authenticatedUser;

  @override
  State<EditMedicationPage> createState() => _EditMedicationPageState();
}

class _EditMedicationPageState extends State<EditMedicationPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
