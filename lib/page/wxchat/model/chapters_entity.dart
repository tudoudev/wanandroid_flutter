import 'dart:convert';

import 'package:wanandroid_flutter/generated/json/base/json_field.dart';
import 'package:wanandroid_flutter/generated/json/chapters_entity.g.dart';

@JsonSerializable()
class ChaptersEntity {
	late List<dynamic> articleList = [];
	late String author = '';
	late List<ChaptersEntity> children = [];
	late int courseId = 0;
	late String cover = '';
	late String desc = '';
	late int id = 0;
	late String lisense = '';
	late String lisenseLink = '';
	late String name = '';
	late int order = 0;
	late int parentChapterId = 0;
	late int type = 0;
	late bool userControlSetTop = false;
	late int visible = 0;

	ChaptersEntity();

	factory ChaptersEntity.fromJson(Map<String, dynamic> json) => $ChaptersEntityFromJson(json);

	Map<String, dynamic> toJson() => $ChaptersEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}