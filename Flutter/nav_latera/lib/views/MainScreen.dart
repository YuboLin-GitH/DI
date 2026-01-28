import 'package:flutter/material.dart';
import 'package:nav_latera/views/HomeScreen.dart';
import 'package:nav_latera/views/transaccionesView.dart';
import 'package:nav_latera/views/SettingsScreen.dart';


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
    const transaccionesView(),
    const SettingsScreen(),
  ];

  // 标题列表（为了让 AppBar 标题随页面变化）
  final List<String> _titles = [
    "Home",
    "Transactions",
    "Settings"
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // 🔥 重要：点击后关闭侧边栏
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar 会自动显示一个“汉堡菜单”图标来打开 Drawer
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]), 
      ),
      
      body: _screens[_selectedIndex],
      
      // 🔥 这里是侧边导航的核心
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // 移除顶部默认的 padding
          children: [
            // 1. 侧边栏头部
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.account_circle, size: 60, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'Menu Lateral',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
            ),

            // 2. 菜单项 - Home
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              selected: _selectedIndex == 0, // 高亮当前选中项
              selectedTileColor: Colors.blue.shade100, // 高亮背景色
              onTap: () => _onItemTapped(0),
            ),

            // 3. 菜单项 - Profile
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Transactions'),
              selected: _selectedIndex == 1,
              selectedTileColor: Colors.blue.shade100,
              onTap: () => _onItemTapped(1),
            ),

            // 4. 菜单项 - Settings
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              selected: _selectedIndex == 2,
              selectedTileColor: Colors.blue.shade100,
              onTap: () => _onItemTapped(2),
            ),
          ],
        ),
      ),
    );
  }
}