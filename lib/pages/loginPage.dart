import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../providers.dart";

// ログインページ
class LoginPage extends ConsumerWidget {
  late String token;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "トークン"
            ),
            onChanged: (text) {
              token = text;
            }
          ),
          ElevatedButton(
            child: Text("ログイン"),
            onPressed: () {
              ref.read(authProvider.notifier).setToken(token);
            },
          )
        ]
      )
    );
  }
}
