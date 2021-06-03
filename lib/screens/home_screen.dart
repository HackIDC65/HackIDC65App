import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter_app/utils/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        cupertino: (_, __) =>
            CupertinoNavigationBarData(transitionBetweenRoutes: false),
        title: Text("HackIDC65"),
        trailingActions: <Widget>[
          PlatformIconButton(
            padding: EdgeInsets.zero,
            icon: Icon(context.platformIcons.search),
            onPressed: () {
              Navigator.of(context).push(platformPageRoute(
                context: context,
                builder: (BuildContext context) {
                  return LoginScreen();
                },
              ));
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xfffffbf4),
      body: SafeArea(child: _buildPage(_selectedIndex)),
      bottomNavBar: _buildBottomNavigationBar() as PlatformNavBar?,
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return Center(child: Text("hello"));
      case 3:
        return Center(child: Text("hello 2"));
      default:
        return const Center(
          child: Text("בקרוב"),
        );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBottomNavigationBar() {
    return PlatformNavBar(
      material: (_, __) => MaterialNavBarData(showUnselectedLabels: true),
      // selectedItemColor: Colors.white,
      // unselectedItemColor: Colors.grey,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          backgroundColor: Colors.black,
          icon: Icon(context.platformIcons.home, color: Colors.grey),
          activeIcon: Icon(context.platformIcons.home, color: Colors.white),
          label: AppLocalizations.of(context)!.discoverBurgers,
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.black,
          icon: Icon(context.platformIcons.bookmark, color: Colors.grey),
          activeIcon: Icon(context.platformIcons.bookmark, color: Colors.white),
          label: AppLocalizations.of(context)!.discoverQuests,
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.black,
          icon: Icon(context.platformIcons.search, color: Colors.grey),
          activeIcon: Icon(context.platformIcons.search, color: Colors.white),
          label: AppLocalizations.of(context)!.discoverLists,
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.black,
          icon: Icon(context.platformIcons.personOutline, color: Colors.grey),
          activeIcon:
              Icon(context.platformIcons.personOutline, color: Colors.white),
          label: AppLocalizations.of(context)!.userProfile,
        ),
      ],
      currentIndex: _selectedIndex,
      itemChanged: _onItemTapped,
    );
  }
}
