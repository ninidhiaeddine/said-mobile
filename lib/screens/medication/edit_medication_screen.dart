import 'package:flutter/material.dart';
import 'package:said/services/models/user.dart';

class EditMedicationScreen extends StatefulWidget {
  const EditMedicationScreen({Key? key, required this.authenticatedUser}) : super(key: key);

  final User authenticatedUser;

  @override
  State<EditMedicationScreen> createState() => _EditMedicationScreenState();
}

class _EditMedicationScreenState extends State<EditMedicationScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
