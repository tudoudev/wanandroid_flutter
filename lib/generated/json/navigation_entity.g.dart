import 'package:wanandroid_flutter/generated/json/base/json_convert_content.dart';
import 'package:wanandroid_flutter/page/system/model/navigation_entity.dart';
import 'package:wanandroid_flutter/page/home/model/article_entity.dart';


NavigationEntity $NavigationEntityFromJson(Map<String, dynamic> json) {
  final NavigationEntity navigationEntity = NavigationEntity();
  final List<ArticleEntity>? articles = (json['articles'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<ArticleEntity>(e) as ArticleEntity).toList();
  if (articles != null) {
    navigationEntity.articles = articles;
  }
  final int? cid = jsonConvert.convert<int>(json['cid']);
  if (cid != null) {
    navigationEntity.cid = cid;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    navigationEntity.name = name;
  }
  return navigationEntity;
}

Map<String, dynamic> $NavigationEntityToJson(NavigationEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['articles'] = entity.articles.map((v) => v.toJson()).toList();
  data['cid'] = entity.cid;
  data['name'] = entity.name;
  return data;
}

extension NavigationEntityExtension on NavigationEntity {
  NavigationEntity copyWith({
    List<ArticleEntity>? articles,
    int? cid,
    String? name,
  }) {
    return NavigationEntity()
      ..articles = articles ?? this.articles
      ..cid = cid ?? this.cid
      ..name = name ?? this.name;
  }
}