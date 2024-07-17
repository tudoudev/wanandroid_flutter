/*
 * Description：<网络请求响应解析的基类-paging分页>
 * Created by：zzl
 * Time：2024/3/15  9:53 AM
 */
class BasePaging {
  int? curPage;
  int? offset;
  bool? over;
  int? pageCount;
  int? size;
  int? total;

  BasePaging.fromJson(dynamic json) {
    curPage = json['curPage'] as int?;
    offset = json['offset'] as int?;
    over = json['over'] as bool?;
    pageCount = json['pageCount'];
    size = json['size'];
    total = json['total'];
  }
}
