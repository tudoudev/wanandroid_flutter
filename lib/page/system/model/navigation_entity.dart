import 'dart:convert';

import 'package:wanandroid_flutter/generated/json/base/json_field.dart';
import 'package:wanandroid_flutter/generated/json/navigation_entity.g.dart';
import 'package:wanandroid_flutter/page/home/model/article_entity.dart';

export 'package:wanandroid_flutter/generated/json/navigation_entity.g.dart';

@JsonSerializable()
class NavigationEntity {
	late List<ArticleEntity> articles = [];
	late int cid = 0;
	late String name = '';

	NavigationEntity();

	factory NavigationEntity.fromJson(Map<String, dynamic> json) => $NavigationEntityFromJson(json);

	Map<String, dynamic> toJson() => $NavigationEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}