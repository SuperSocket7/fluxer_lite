import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_svg/svg.dart";

import "../providers.dart";

class DMIcon extends ConsumerWidget {
  const DMIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget icon = SvgPicture.asset(
      "assets/fluxer.svg",
      semanticsLabel: "Fluxer Logo"
    );
    
    return Padding(
      padding: EdgeInsets.only(top: 9),
      child: SizedBox(
        width: 44,
        height: 44,
        child: Center(
          child: IconButton.filledTonal(
            icon: ClipOval(child: icon),
            onPressed: () {
              ref.read(guildIdProvider.notifier).state = "@me";
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
