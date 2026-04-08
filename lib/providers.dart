import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_riverpod/legacy.dart";
import "package:dio/dio.dart";
import "package:fluxer_dart/export.dart";

final clientProvider = Provider((ref) {
  // Fluxerのトークン
  final String TOKEN = "";
  final dio = Dio(BaseOptions(baseUrl: "https://api.fluxer.app/v1"));
  dio.options.headers["Authorization"] = TOKEN;

  final client = FluxerClient(dio);
  // final user = await client.users.getCurrentUser();
  return client;
});

final guildListProvider = FutureProvider((ref) async {
  final client = ref.read(clientProvider);
  final guilds = await client.guilds.listGuilds();
  return guilds;
});

final guildIdProvider = StateProvider<String?>((ref) => null);

final channelListProvider = FutureProvider((ref) async {
  final client = ref.read(clientProvider);
  final guildId = ref.watch(guildIdProvider);
  print("Current Guild ID: ${guildId}");

  if (guildId == null) return [];

  final channels = await client.guilds.listGuildChannels(guildId: guildId);

  return channels;
});
