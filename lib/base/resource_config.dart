//拼接本地图片路径
String getImgPath(String name, {String format = 'png'}) {
  return 'lib/res/images/$name.$format';
}

//拼接icon路径
String getIconPath(String name, {String format = 'png'}) {
  return 'lib/res/icon/$name.$format';
}
