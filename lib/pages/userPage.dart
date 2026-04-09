import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:sprintf/sprintf.dart";

import "../providers.dart";

// ユーザーページ
class UserPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    return Container(
      child: currentUser.when(
        data: (data) {
          final iconUrl = sprintf("https://fluxerusercontent.com/avatars/%s/%s.webp", [data.id, data.avatar]);
          Widget icon = Image.network(iconUrl, fit: BoxFit.cover);
          return Padding(
            padding: EdgeInsets.all(6),
            child: Column(
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: ClipOval(child: icon)
                ),
                Text(
                  data.globalName ?? data.username
                ),
                ElevatedButton(
                  child: Text("ログアウト"),
                  onPressed: () {
                    ref.read(authProvider.notifier).logout();
                  },
                )
              ]
            )
          );
        },
        loading: () => CircularProgressIndicator(),
        error: (e, _) => Text("Error")
      )
    );
  }
}
