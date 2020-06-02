import 'package:trends/data/models/article.dart';

class ArticleRepository {
  Future<List<Article>> fetchRealtimeArticle(String categoryId) {
    return Future(() {
      List<Article> dummyData = [
        Article(
          id: '0',
          url:
              "https://vnexpress.net/hdbank-tung-uu-dai-dip-quoc-te-thieu-nhi-4108718.html",
          imagePath:
              "https://cdnmedia.thethaovanhoa.vn/Upload/tyTrfgkgEUQwPYuvZ4Kn1g/files/2020/06/0106/loi-chuc-quoc-te-thieu-nhi.jpg",
          date: DateTime.now(),
          title: "Ưu đãi dịp quốc tế thiếu nhi",
          source: "VN Express",
          snippet: "Ưu đãi dịp quốc tế thiếu nhi snippet"
        ),
        Article(
          id: '0',
          url:
              "https://vnexpress.net/hdbank-tung-uu-dai-dip-quoc-te-thieu-nhi-4108718.html",
          imagePath:
              "https://vnn-imgs-f.vgcloud.vn/2020/05/26/19/nhung-loi-chuc-cho-be-yeu-ngay-quoc-te-thieu-nhi.jpg",
          date: DateTime.now(),
          title: "01/06/2020 QT thiếu nhi",
          source: "Báo mới",
          snippet: "Ưu đãi dịp quốc tế thiếu nhi snippet"
        ),
        
      ];
      return dummyData;
    });
  }

  Future<List<Article>> fetchDailyArticle() {
    return Future(() {
      return [];
    });
  }
}
