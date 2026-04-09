import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../providers.dart";
import "dmIcon.dart";
import "guildIcon.dart";

// サーバー一覧
class GuildList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guilds = ref.watch(guildListProvider);

    return Container(
      child: guilds.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return DMIcon();
              } else if (index == 1) {
                return Padding(
                  padding: EdgeInsets.only(top: 9),
                  child: Divider(
                    height: 2,
                    indent: 20,
                    endIndent: 20,
                    color: Color(0xFFD3D5D8)
                  )
                );
              } else {
                return GuildIcon(guild: data[index - 2]);
              }
            }
          );
        },
        loading: () => CircularProgressIndicator(),
        error: (e, _) => Text("Error")
      )
    );
  }
}
