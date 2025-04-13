import "package:http/http.dart" as http;
import "dart:convert";


typedef PlayerData = Map<String, dynamic>;

class RpgDatabase {
  const RpgDatabase._();

  static const _baseUrl = "https://easy-rpg-ever-default-rtdb.firebaseio.com/";


  static Future<List<PlayerData>> fetchPlayersData() async {
    final url = Uri.parse("$_baseUrl/players.json");

    try {
      final http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        print(response.body);

        return Future.delayed(const Duration(seconds: 1)).then((value) {
          return [
            {"this": "that"}
          ];
        });
      } else {
        throw Exception("Failed to fetch player data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  static Future<PlayerData> fetchPlayerData({
    required String playerId,
    String databaseSecret = "",
  }) async {
    final url = Uri.parse("$_baseUrl/players/$playerId.json?auth=$databaseSecret");

    try {
      final http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception("Failed to fetch player data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}