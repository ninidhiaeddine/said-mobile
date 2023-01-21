import 'package:flutter/material.dart';
import 'package:said/config/color_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/screens/home.dart';
import 'package:said/utils/navigator.dart';
import 'package:said/utils/said_session_manager.dart';

class SaidNavigationDrawer extends StatelessWidget {
  const SaidNavigationDrawer({Key? key}) : super(key: key);

  Future<void> logOut(BuildContext context) async {
    await SaidSessionManager.clearSession();
    navigateToRoute(context, const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: ColorConstants.textFieldColor,
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 64, vertical: 16),
                  child: Image(image: AssetImage('assets/images/logo.png')),
                ),
                Text(
                  AppLocalizations.of(context).menu,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).logOut),
            trailing: const Icon(Icons.login_outlined),
            onTap: () {
              logOut(context);
            },
          ),
        ],
      ),
    );
  }
}
