import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../providers.dart";

// チャンネル一覧
class ChannelList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channels = ref.watch(channelListProvider);

    return Column(
      children: [
        // サーバー名
        Container(
          height: 48,
          color: Color(0xFFEBECEF),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "サーバー名",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          )
        ),
        // チャンネル一覧
        Expanded(
          child: channels.when(
            data: (data) {
              return ListView.builder(
                itemCount: 50,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(6),
                    color: Color(0xFFEBECEF),
                    height: 40,
                    child: Text(
                      "# チャンネル ${index}",
                      style: TextStyle(
                        fontSize: 16
                      ),
                    )
                  );
                }
              );
            },
            loading: () => CircularProgressIndicator(),
            error: (e, _) => Text("Error")
          )
        ),
      ],
    );
  }
}
