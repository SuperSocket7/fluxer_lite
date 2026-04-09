import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "providers.dart";
import "pages/loginPage.dart";
import "pages/topPage.dart";
import "pages/notificationPage.dart";
import "pages/userPage.dart";

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
class RootView extends ConsumerStatefulWidget {
  const RootView({super.key});

  @override
  ConsumerState<RootView> createState() => _RootViewState();
}

class _RootViewState extends ConsumerState<RootView> with TickerProviderStateMixin {
  String _currentAppBarTitle = "Fluxer";
  bool _showAppBar = false;
  int _selectedIndex = 0;
  final List _pagesIndex = [
    TopPage(),
    NotificationPage(),
    UserPage()
  ];

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    if (authState != null) {
      final showNavBar = ref.watch(showNavStateProvider);
      return Scaffold(
        appBar: _showAppBar ? AppBar(
          backgroundColor: Color(0xFFEBECEF),
          title: Text(_currentAppBarTitle)
        ) : null,
        body: SafeArea(
          child: _pagesIndex[_selectedIndex]
        ),
        bottomNavigationBar: AnimatedContainer(
          height: showNavBar ? kBottomNavigationBarHeight : 0,
          duration: Duration(milliseconds: 180),
          child: Wrap(
            children: [
              BottomNavigationBar(
                items: [
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
                onTap: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  setState(() {
                    if (index == 0) {
                      _showAppBar = false;
                    } else {
                      _showAppBar = true;
                    }
                    if (index == 1) {
                      _currentAppBarTitle = "通知";
                    } else if (index == 2) {
                      _currentAppBarTitle = "ユーザー設定";
                    }
                  });
                },
              )
            ]
          )
        )
      );
    } else {
      // トークン未設定(ログアウト状態)
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFEBECEF),
          title: Text("ログイン")
        ),
        body: SafeArea(
          child: LoginPage()
        )
      );
    }
  }
}
