import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_riverpod/legacy.dart";
import "package:dio/dio.dart";
import "package:fluxer_dart/export.dart";
import "package:shared_preferences/shared_preferences.dart";

// WIP Gatewayへの接続状況
final initialStateProvider = StateProvider<bool>((ref) {
  return true;
});

// NavigationBarの表示/非表示
final showNavStateProvider = StateProvider<bool>((ref) => true);

// 現在のサーバーID
final guildIdProvider = StateProvider<String?>((ref) => null);

// トークンの管理
final authProvider = NotifierProvider<AuthNotifier, String?>(AuthNotifier.new);

class AuthNotifier extends Notifier<String?> {
  @override
  String? build() {
    _load(); // 初期読み込み
    return null;
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getString("token");
  }

  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
    state = token; // ← UIも更新される
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    state = null;
  }
}

// クライアントオブジェクトの管理
final clientProvider = Provider((ref) {
  final authToken = ref.watch(authProvider);

  // セルフホストだと変わる
  final dio = Dio(BaseOptions(baseUrl: "https://api.fluxer.app/v1"));
  dio.options.headers["Authorization"] = authToken;
  final client = FluxerClient(dio);

  return client;
});

// ログイン中のユーザーの管理
final currentUserProvider = FutureProvider((ref) async {
  final client = ref.read(clientProvider);
  final user = await client.users.getCurrentUser();
  return user;
});

final guildListProvider = FutureProvider((ref) async {
  final client = ref.read(clientProvider);
  final guilds = await client.guilds.listGuilds();
  return guilds;
});

final channelListProvider = FutureProvider((ref) async {
  final client = ref.read(clientProvider);
  final guildId = ref.watch(guildIdProvider);
  // print("Current Guild ID: ${guildId}");

  if (guildId == null) return [];

  final channels = await client.guilds.listGuildChannels(guildId: guildId);

  return channels;
});
