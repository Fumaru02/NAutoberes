import 'package:shared_preferences/shared_preferences.dart';

import '../utils/preferences_key.dart';

class SharedPref {
  // instances
  final Future<SharedPreferences> _prefsInstance =
      SharedPreferences.getInstance();

  // save access token
  Future<void> writeAccessToken(String accesstoken) async {
    final SharedPreferences prefs = await _prefsInstance;
    prefs.setString(PreferencesKey.keyAccessToken, accesstoken);
  }

  // save refresh token
  Future<void> writeRefreshToken(String refreshToken) async {
    final SharedPreferences prefs = await _prefsInstance;
    prefs.setString(PreferencesKey.keyRefreshToken, refreshToken);
  }

  // save user profile
  Future<void> writeFullName(String fullNameParam) async {
    final SharedPreferences prefs = await _prefsInstance;
    prefs.setString(PreferencesKey.keyUserProfileName, fullNameParam);
  }

  // read access token
  Future<String?> readAccessToken() async {
    final SharedPreferences prefs = await _prefsInstance;
    final String? accessToken = prefs.getString(PreferencesKey.keyAccessToken);
    return accessToken;
  }

  // read refresh token
  Future<String?> readRefreshToken() async {
    final SharedPreferences prefs = await _prefsInstance;
    final String? refreshToken =
        prefs.getString(PreferencesKey.keyRefreshToken);
    return refreshToken;
  }

  Future<bool> hasData(String key) async {
    final SharedPreferences prefs = await _prefsInstance;
    return prefs.containsKey(key);
  }

  // remove access token
  Future<void> removeAccessToken() async {
    final SharedPreferences prefs = await _prefsInstance;
    prefs.remove(PreferencesKey.keyAccessToken);
  }

  // remove refresh token
  Future<void> removeRefreshsToken() async {
    final SharedPreferences prefs = await _prefsInstance;
    prefs.remove(PreferencesKey.keyRefreshToken);
  }

  // remove user profile
  Future<void> removeUserProfileName() async {
    final SharedPreferences prefs = await _prefsInstance;
    prefs.remove(PreferencesKey.keyUserProfileName);
  }
}
