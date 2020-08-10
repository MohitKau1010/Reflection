class Constants{

  static Enviroment BUILD_CONFIG = Enviroment.DEV;
  static String newsListUrl = 'https://hacker-news.firebaseio.com/v0/topstories.json';


  //live link
  static String getStories = 'http://54.66.240.186:3000/stories';
  static String postStories = 'http://54.66.240.186:3000/stories/';
  static String getQuestions = 'http://54.66.240.186:3000/questions';

  static String newsUrl(int newsId) {
    return 'https://hacker-news.firebaseio.com/v0/item/$newsId.json';
  }

}

enum Enviroment {
  DEV,
  STAGING,
  PRODUCT,
}