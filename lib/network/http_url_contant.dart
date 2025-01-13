class HttpUrlContant {
  static const String baseUrl = "https://www.wanandroid.com";

  //main
  static const String lgCoinList = "/lg/coin/list/{pageNum}/json"; //获取个人积分获取列表
  static const String login = "/user/login"; //登录
  static const String register = "/user/register"; //注册
  static const String collect = "/lg/collect/{id}/json"; //收藏
  static const String uncollect = "/lg/uncollect_originId/{id}/json"; //取消收藏
  static const String collectList = "/lg/collect/list/{pageNum}/json"; //收藏列表

  //首页
  static const String homeBanner = "/banner/json"; //banner
  static const String articleTopJson = "/article/top/json"; //置顶文章
  static const String articleList = "/article/list/{pageNum}/json"; //文章列表

  //广场
  static const String userArticleList = "/user_article/list/{pageNum}/json"; //文章列表

  //公众号
  static const String wxChapters = "/wxarticle/chapters/json"; //列表
  static const String wxArticleList = "/wxarticle/list/{id}/{pageNum}/json"; //某个公众号历史数据

  //体系
  static const String treeJson = "/tree/json"; //体系数据
  static const String naviJson = "/navi/json"; //导航数据

  //项目
  static const String projectTreeJson = "/project/tree/json"; //项目分类
}
