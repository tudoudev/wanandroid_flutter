/*
 * Description：<网络请求响应解析的基类>
 * 这里T为泛型
 * Created by：zzl
 * Time：2024/3/11  17:09
 */

import 'package:wanandroid_flutter/generated/json/base/json_convert_content.dart';
import 'package:wanandroid_flutter/page/home/model/article_entity.dart';

import '../page/home/model/integrate_entity.dart';

/*
 * Description：<网络请求响应解析的基类>
 * 这里T为泛型
 * Created by：zzl
 * Time：2024/3/15  9:53 AM
 */
class BaseEntity<T> {
  int? errorCode;
  String errorMsg = '';
  T? data;

  BaseEntity.fromJson(dynamic json) {
    errorCode = json['errorCode'] as int?;
    errorMsg = json['errorMsg'];
    if (json['data'] != null && json['data'] != 'null') {
      if (T.toString().startsWith((PagingEntity).toString().split('<').first)) {
        String lastType = T.toString().split('<').last.split('>').first;
        data = PagingEntity.map[lastType]!(json['data']);
      } else {
        data = JsonConvert.fromJsonAsT<T>(json['data']);
      }
    }
  }
}

/*
 * Description：<网络请求响应解析的基类-paging分页>
 * 这里T为泛型
 * Created by：zzl
 * Time：2024/3/15  9:53 AM
 */
class PagingEntity<T> {
  int? curPage;
  int? offset;
  bool? over;
  int? pageCount;
  int? size;
  int? total;
  List<T>? datas;

  PagingEntity.fromJson(dynamic json) {
    curPage = json['curPage'] as int?;
    offset = json['offset'] as int?;
    over = json['over'] as bool?;
    curPage = json['curPage'] as int?;
    pageCount = json['pageCount'];
    size = json['size'];
    total = json['total'];
    if (json['datas'] != null && json['datas'] != 'null') {
      datas = JsonConvert.fromJsonAsT<List<T>>(json['datas']);
    }
  }

  //实体map
  static Map<String, JsonConvertFunction> map = {
    (ArticleEntity).toString(): PagingEntity<ArticleEntity>.fromJson,
    (IntegrateEntity).toString(): PagingEntity<IntegrateEntity>.fromJson,
  };
}
