import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "pages/topPage.dart";

void main() {
  runApp(const ProviderScope(child: FluxerApp()));
}

class FluxerApp extends StatelessWidget {
  const FluxerApp({super.key});

  // 初期化
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Fluxer",
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Color(0xFF413CDD)),
      ),
      home: const RootView(),
    );
  }
}

// ルートビュー
class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> with TickerProviderStateMixin {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TopPage()
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "ホーム"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "通知"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "あなた"
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      )
    );
  }
}
