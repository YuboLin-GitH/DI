import 'package:flutter/material.dart';
import 'package:nav_responsive/views/HomeScreen.dart';
import 'package:nav_responsive/views/SearchScreen.dart';
import 'package:nav_responsive/views/SettingsScreen.dart';


class ResponsiveMainScreen extends StatefulWidget {
  const ResponsiveMainScreen({super.key});

  @override
  State<ResponsiveMainScreen> createState() => _ResponsiveMainScreenState();
}

class _ResponsiveMainScreenState extends State<ResponsiveMainScreen> {
  int _selectedIndex = 0;

  // 引用拆分后的页面
  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const SettingsScreen(),
  ];

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 核心逻辑：判断屏幕宽度是否大于 600 像素
    bool isLargeScreen = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      appBar: AppBar(title: const Text("Responsive Navigation")),
      
      // 布局逻辑
      body: Row(
        children: [
          // 1. 如果是大屏幕，显示左侧导航轨 (Rail)
          if (isLargeScreen)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onDestinationSelected,
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home), 
                  label: Text("Home")
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.search), 
                  label: Text("Search")
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings), 
                  label: Text("Settings")
                ),
              ],
            ),
          
          // 2. 如果是大屏幕，加一条分割线（可选，为了好看）
          if (isLargeScreen)
            const VerticalDivider(thickness: 1, width: 1),

          // 3. 显示具体页面内容
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),

      // 4. 如果是小屏幕，显示底部导航栏；否则隐藏 (null)
      bottomNavigationBar: isLargeScreen
          ? null
          : BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onDestinationSelected,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home), 
                  label: "Home"
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search), 
                  label: "Search"
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings), 
                  label: "Settings"
                ),
              ],
            ),
    );
  }
}