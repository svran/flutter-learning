import 'package:svran_flutter_study/douban/config/config.dart';
import 'package:svran_flutter_study/douban/model/home_model.dart';
import 'package:svran_flutter_study/ext/http/http_request.dart';

import '../../public_code.dart';

class HomeRequest {
  static Future<List<DataItem?>?> requestMovieList(int start, int cid) async {
    // final movieUrl = "https://douban-api.uieee.com/v2/movie/top250?$start=0&count=${HomeConfig.movieCount}";
    final movieUrl = "https://www.wanandroid.com/project/list/$start/json?cid=$cid&page_size=${HomeConfig.movieCount}";
    final jsonRes = await HttpRequest.request(movieUrl);
    Project p = Project.fromJson(jsonRes);
    return p.data?.datas;
  }
}
