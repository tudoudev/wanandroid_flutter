class HttpUrlContant {
  static const String baseUrl = "https://www.wanandroid.com";

  //首页-banner
  static const String homeBanner = "/banner/json";

  //首页-置顶文章
  static const String articleTopJson = "/article/top/json";

  //首页-文章列表
  static const String articleList = "/article/list/{pageNum}/json";

  //广场-文章列表
  static const String userArticleList = "/user_article/list/{pageNum}/json";

  //公众号-列表
  static const String wxChapters = "/wxarticle/chapters/json";

  //公众号-某个公众号历史数据
  static const String wxArticleList = "/wxarticle/list/{id}/{pageNum}/json";

  //体系-体系数据
  static const String treeJson = "/tree/json";

  //体系-导航数据
  static const String naviJson = "/navi/json";

  //项目-项目分类
  static const String projectTreeJson = "/project/tree/json";
}
