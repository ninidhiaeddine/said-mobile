import 'package:flutter/material.dart';
import 'package:said/screens/user_account.dart';
import 'package:said/screens/user_club.dart';
import 'package:said/screens/user_home.dart';
import 'package:said/screens/user_info.dart';
import 'package:said/screens/user_announcements.dart';
import 'package:said/services/models/user.dart';
import 'package:said/utils/said_session_manager.dart';
import 'package:said/widgets/nav/said_bottom_nav_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserNavigatorParent extends StatefulWidget {
  const UserNavigatorParent({super.key});

  @override
  State<StatefulWidget> createState() => _UserNavigatorParentState();
}

class _UserNavigatorParentState extends State<UserNavigatorParent> {
  int _selectedIndex = 2;

  late Future<User> _user;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _user = SaidSessionManager.getUser();
  }

  @override
  Widget build(BuildContext context) {
    // prepare icons:
    List<Icon> icons = const [
      Icon(Icons.groups_rounded),
      Icon(Icons.info_rounded),
      Icon(Icons.home_rounded),
      Icon(Icons.notifications_rounded),
      Icon(Icons.account_circle_rounded),
    ];

    // prepare labels:
    List<String> labels = [
      AppLocalizations
          .of(context)
          .club,
      AppLocalizations
          .of(context)
          .info,
      AppLocalizations
          .of(context)
          .home,
      AppLocalizations
          .of(context)
          .announcements,
      AppLocalizations
          .of(context)
          .account,
    ];

    // prepare views:
    List<Widget> views = [
      const UserClubPage(),
      UserInfoPage(authenticatedUser: _user),
      UserHomePage(authenticatedUser: _user),
      const UserAnnouncementsPage(),
      UserAccountPage(authenticatedUser: _user)
    ];

    // return scaffold with bottom navigation bar and corresponding view
    return Scaffold(
        bottomNavigationBar: SaidBottomNavigationBar(
          icons: icons,
          labels: labels,
          selectedIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        body: SafeArea(
            child: views[_selectedIndex]
        )
    );
  }
}
