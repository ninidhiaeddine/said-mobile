import 'package:flutter/material.dart';
import 'package:said/config/color_constants.dart';
import 'package:said/fragments/account_fragment.dart';
import 'package:said/fragments/club_fragment.dart';
import 'package:said/fragments/home_fragment.dart';
import 'package:said/fragments/info_fragment.dart';
import 'package:said/fragments/announcements_fragment.dart';
import 'package:said/screens/refresh_user_interface.dart';
import 'package:said/services/models/user.dart';
import 'package:said/utils/said_session_manager.dart';
import 'package:said/widgets/nav/said_bottom_nav_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/widgets/nav/said_navigation_drawer.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<StatefulWidget> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen>
    implements RefreshUserInterface {
  int _selectedIndex = 2;
  late Future<void> initAsync;

  late List<Icon> icons = const [
    Icon(Icons.groups_rounded),
    Icon(Icons.info_rounded),
    Icon(Icons.home_rounded),
    Icon(Icons.notifications_rounded),
    Icon(Icons.account_circle_rounded),
  ];
  late List<String> labels;
  late List<Widget> fragments;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<User?> _loadUserAsync() async {
    var user = await SaidSessionManager.getUser();
    return user;
  }

  Future<void> init() async {
    // wait on loading the user:
    User? user = await _loadUserAsync();

    // prepare views:
    fragments = [
      const ClubFragment(),
      InfoFragment(authenticatedUser: user!),
      HomeFragment(authenticatedUser: user),
      const AnnouncementsFragment(),
      AccountFragment(
        authenticatedUser: user,
        onRefreshUser: onRefreshUser,
      )
    ];
  }

  @override
  void initState() {
    super.initState();
    initAsync = init();
    initAsync;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // init strings:
    labels = [
      AppLocalizations.of(context).club,
      AppLocalizations.of(context).info,
      AppLocalizations.of(context).home,
      AppLocalizations.of(context).announcements,
      AppLocalizations.of(context).account,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initAsync,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: Text(AppLocalizations.of(context).loading),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: ColorConstants.backgroundColor,
                  elevation: 0,
                ),
                drawer: const SaidNavigationDrawer(),
                bottomNavigationBar: SaidBottomNavigationBar(
                  icons: icons,
                  labels: labels,
                  selectedIndex: _selectedIndex,
                  onTap: _onItemTapped,
                ),
                body: fragments[_selectedIndex]);
          } else {
            return Scaffold(
                body: Center(
              child: Text(AppLocalizations.of(context).unexpectedError),
            ));
          }
        });
  }

  Future<void> _saveUserToSessionAsync(User updatedUser) async {
    SaidSessionManager.storeUser(
        id: updatedUser.id!,
        username: updatedUser.username,
        email: updatedUser.email,
        firstName: updatedUser.firstName,
        lastName: updatedUser.lastName,
        sex: updatedUser.sex,
        age: updatedUser.age);
  }

  @override
  void onRefreshUser(User updatedUser) {
    _saveUserToSessionAsync(updatedUser);
    // reinitialize the screen:
    init();
  }
}
