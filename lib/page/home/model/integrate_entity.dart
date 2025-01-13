import 'package:wanandroid_flutter/generated/json/base/json_field.dart';
import 'package:wanandroid_flutter/generated/json/integrate_entity.g.dart';
import 'dart:convert';
export 'package:wanandroid_flutter/generated/json/integrate_entity.g.dart';

@JsonSerializable()
class IntegrateEntity {
	late String coinCount = '';
	late int date = 0;
	late String desc = '';
	late int id = 0;
	late String reason = '';
	late int type = 0;
	late int userId = 0;
	late String userName = '';

	IntegrateEntity();

	factory IntegrateEntity.fromJson(Map<String, dynamic> json) => $IntegrateEntityFromJson(json);

	Map<String, dynamic> toJson() => $IntegrateEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}