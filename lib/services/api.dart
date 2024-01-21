// API Class for initialize url api, client id and client secret
import '../utils/enums.dart';

class API {
// live client:
  /// client id & client secret: used for header data validation

  static String host = 'https://fumaru02.github.io/api-wilayah-indonesia/';

  // API endpoint
  String? endPoint(EndPointName endPointName, [String? query]) {
    final Map<EndPointName, String> urlAPI = <EndPointName, String>{
      // request post authorize, access token and refresh token
      EndPointName.profiency: 'api/provinces.json'
      // EndPointName.authorize: '/team/authorize',
      // EndPointName.accessToken: '/team/access-token',
      // EndPointName.refreshToken: '/team/refresh-token',
      // EndPointName.applicationInfo: '/application/info',
      // EndPointName.home: '/team/home',
      // EndPointName.subdistrict: '/subdistrict/data-select',
      // EndPointName.village: '/village/data-select?subdistrict_id=$query',
      // EndPointName.dptList: '/dpt/list?$query',
      // EndPointName.dptAdd: '/dpt/add',
      // EndPointName.logout: '/team/logout',
    };

    // return endpoint
    return urlAPI[endPointName];
  }
}
