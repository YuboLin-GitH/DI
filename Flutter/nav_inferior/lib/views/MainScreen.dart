import 'package:flutter/material.dart';
import 'package:nav_inferior/views/HomeScreen.dart';
import 'package:nav_inferior/views/SearchScreen.dart';
import 'package:nav_inferior/views/SettingsScreen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // 页面列表
  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Navegación Inferior")),
      
      // 这里不再需要 Row 和 NavigationRail，直接显示当前页面
      body: _screens[_selectedIndex],
      
      // 始终显示底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue, // 选中时的颜色
        onTap: _onItemTapped,
      ),
    );
  }
}