import 'package:flutter/material.dart';
import 'package:flutter_app/shared/views/items_list_view.dart';
import 'package:flutter_app/shared/views/sales_list_view.dart';
import 'package:flutter_app/shared/views/profile_view.dart';
import 'package:flutter_app/utils/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_app/shared/views/edit_item_view.dart';

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
        title: Text(
          "Hello, Ari!",
        ),
        trailingActions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: PlatformIconButton(
                icon: Icon(
              Icons.notifications_none_outlined,
              color: Colors.white,
            )),
          )
        ],
        material: (_, __) => MaterialAppBarData(elevation: 0),
        // trailingActions: <Widget>[
        //   PlatformIconButton(
        //     padding: EdgeInsets.zero,
        //     icon: Icon(context.platformIcons.search),
        //     onPressed: _openFiltersScreen,
        //   ),
        // ],
      ),
      backgroundColor: const Color(0xfffffbf4),
      body: SafeArea(child: _buildPage(_selectedIndex)),
      bottomNavBar: _buildBottomNavigationBar() as PlatformNavBar?,
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return SalesListView();
      case 3:
        return ProfileView();
      default:
        return const Center(
          child: Text("Coming Soon"),
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
          backgroundColor: Color(0xff333333),
          icon: Icon(context.platformIcons.home, color: Colors.grey),
          activeIcon: Icon(context.platformIcons.home, color: Colors.white),
          label: AppLocalizations.of(context)!.discoverBurgers,
        ),
        BottomNavigationBarItem(
          backgroundColor: Color(0xff333333),
          icon: Icon(context.platformIcons.bookmark, color: Colors.grey),
          activeIcon: Icon(context.platformIcons.bookmark, color: Colors.white),
          label: AppLocalizations.of(context)!.discoverQuests,
        ),
        BottomNavigationBarItem(
          backgroundColor: Color(0xff333333),
          icon: Icon(context.platformIcons.search, color: Colors.grey),
          activeIcon: Icon(context.platformIcons.search, color: Colors.white),
          label: AppLocalizations.of(context)!.discoverLists,
        ),
        BottomNavigationBarItem(
          backgroundColor: Color(0xff333333),
          icon: Icon(context.platformIcons.personOutline, color: Colors.grey),
          activeIcon:
              Icon(context.platformIcons.personOutline, color: Colors.white),
          label: AppLocalizations.of(context)!.userProfile,
        ),
      ],
      currentIndex: _selectedIndex,
      itemChanged: _onItemTapped,
      backgroundColor: const Color(0xff333333),
    );
  }
}
