import 'package:wanandroid_flutter/generated/json/base/json_convert_content.dart';
import 'package:wanandroid_flutter/page/home/model/integrate_entity.dart';

IntegrateEntity $IntegrateEntityFromJson(Map<String, dynamic> json) {
  final IntegrateEntity integrateEntity = IntegrateEntity();
  final String? coinCount = jsonConvert.convert<String>(json['coinCount']);
  if (coinCount != null) {
    integrateEntity.coinCount = coinCount;
  }
  final int? date = jsonConvert.convert<int>(json['date']);
  if (date != null) {
    integrateEntity.date = date;
  }
  final String? desc = jsonConvert.convert<String>(json['desc']);
  if (desc != null) {
    integrateEntity.desc = desc;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    integrateEntity.id = id;
  }
  final String? reason = jsonConvert.convert<String>(json['reason']);
  if (reason != null) {
    integrateEntity.reason = reason;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    integrateEntity.type = type;
  }
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    integrateEntity.userId = userId;
  }
  final String? userName = jsonConvert.convert<String>(json['userName']);
  if (userName != null) {
    integrateEntity.userName = userName;
  }
  return integrateEntity;
}

Map<String, dynamic> $IntegrateEntityToJson(IntegrateEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['coinCount'] = entity.coinCount;
  data['date'] = entity.date;
  data['desc'] = entity.desc;
  data['id'] = entity.id;
  data['reason'] = entity.reason;
  data['type'] = entity.type;
  data['userId'] = entity.userId;
  data['userName'] = entity.userName;
  return data;
}

extension IntegrateEntityExtension on IntegrateEntity {
  IntegrateEntity copyWith({
    String? coinCount,
    int? date,
    String? desc,
    int? id,
    String? reason,
    int? type,
    int? userId,
    String? userName,
  }) {
    return IntegrateEntity()
      ..coinCount = coinCount ?? this.coinCount
      ..date = date ?? this.date
      ..desc = desc ?? this.desc
      ..id = id ?? this.id
      ..reason = reason ?? this.reason
      ..type = type ?? this.type
      ..userId = userId ?? this.userId
      ..userName = userName ?? this.userName;
  }
}