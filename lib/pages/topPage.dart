import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../providers.dart";
import "../widgets/guildList.dart";
import "../widgets/channelList.dart";

// トップページ
class TopPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView(
      controller: PageController(),
      children: [
        Row(
          children: [
            Container(
              width: 72,
              decoration: BoxDecoration(
                color: Color(0xFFEBECEF),
                border: Border(
                  right: BorderSide(
                    width: 1,
                    color: Color(0xFFD3D5D8)
                  ),
                ),
              ),
              child: GuildList()
            ),
            Expanded(
              child: ChannelList()
            )
          ]
        ),
        Container(
          color: Color(0xFFF0F1F3),
          child: Center(child: Text("メッセージ"))
        )
      ],
      onPageChanged: (int index) {
        // indexが1(メッセージ欄なら隠す)
        if (index == 1) {
          ref.read(showNavStateProvider.notifier).state = false;
        } else {
          ref.read(showNavStateProvider.notifier).state = true;
        }
      },
    );
  }
}
