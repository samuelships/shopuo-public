import 'package:flutter/material.dart';
import 'package:shopuo/Components/BottomNavComponent.dart';
import 'package:shopuo/Router.dart';
import 'package:shopuo/Screens/Categories.dart';
import 'package:shopuo/Screens/OnSale.dart';
import 'package:shopuo/Services/NavigationService.dart';

import '../locator.dart';
import 'Cart.dart';
import 'Settings.dart';

class NestedNavigation extends StatefulWidget {
  @override
  _NestedNavigationState createState() => _NestedNavigationState();
}

class _NestedNavigationState extends State<NestedNavigation> {
  final NavigationService navigationService = locator<NavigationService>();

  _selectTab(TabItem tabItem) {
    if (navigationService.currentTab == tabItem) {
      navigationService.tabKey[navigationService.currentTab].currentState
          .popUntil((route) => route.isFirst);
    }
    setState(() {
      navigationService.currentTab = tabItem;
    });
  }

  Map<TabItem, Widget> tabContent = {
    TabItem.One: OnSale(),
    TabItem.Two: Categories(),
    TabItem.Three: Cart(),
    TabItem.Four: Settings(),
  };

  _buildNavigator({TabItem tab}) {
    return Offstage(
      offstage: navigationService.currentTab != tab,
      child: Navigator(
        key: navigationService.tabKey[tab],
        onGenerateRoute: (settings) {
          if (settings.name == "/")
            return MaterialPageRoute(
              builder: (context) => tabContent[tab],
            );
          return generateRoute(settings);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool isCurrentRoutePoppable = await navigationService
            .tabKey[navigationService.currentTab].currentState
            .maybePop();

        if (isCurrentRoutePoppable) {
          return await Future.value(false);
        } else {
          if (navigationService.currentTab != TabItem.One) {
            setState(() {
              navigationService.currentTab = TabItem.One;
            });

            return await Future.value(false);
          }
        }

        return await Future.value(true);
      },
      child: Scaffold(
        body: Stack(
          children: [
            _buildNavigator(tab: TabItem.One),
            _buildNavigator(tab: TabItem.Two),
            // _buildNavigator(tab: TabItem.Three),
            _buildNavigator(tab: TabItem.Four),
          ],
        ),
        bottomNavigationBar: BottomNavComponent(
          currentIndex: navigationService.currentTab.index,
          onChange: (tabItem) {
            _selectTab(tabItem);
          },
        ),
      ),
    );
  }
}
