import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:sprintf/sprintf.dart";

import "../providers.dart";

class GuildIcon extends ConsumerWidget {
  const GuildIcon({Key? key, required this.guild}) : super(key: key);

  final guild;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget icon;
    if (guild.icon != null) {
      // セルフホストだと変わるかも
      final iconUrl = sprintf("https://fluxerusercontent.com/icons/%s/%s.webp", [guild.id, guild.icon]);
      icon = Image.network(iconUrl, fit: BoxFit.cover);
    } else {
      icon = SizedBox(
        width: 44,
        height: 44,
        child: Center(
          child: Text(
            guild.name[0],
            style: TextStyle(
              fontSize: 16,
            )
          )
        )
      );
    }
    
    return Padding(
      padding: EdgeInsets.only(top: 9),
      child: SizedBox(
        width: 44,
        height: 44,
        child: Center(
          child: IconButton.filledTonal(
            icon: ClipOval(child: icon),
            onPressed: () {
              ref.read(guildIdProvider.notifier).state = guild.id;
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            style: IconButton.styleFrom(
              foregroundColor: Color(0xFF413CDD),
              backgroundColor: Color(0xFFE5E6E9),
              hoverColor: Color(0xFF413CDD),
              focusColor: Color(0xFF413CDD),
              highlightColor: Color(0xFF413CDD),
            )
          )
        ),
      )
    );
  }
}
