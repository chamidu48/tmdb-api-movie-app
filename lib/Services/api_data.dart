import 'package:tmdb_api/tmdb_api.dart';

class ApiData{
  String apiKey = 'f7ef0857a9d6d81c2cf476891b47258a';
  String readAccessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmN2VmMDg1N2E5ZDZkODFjMmNmNDc2ODkxYjQ3MjU4YSIsInN1YiI6IjYzMDc5ZTRlNDgxMzgyMDA3ZTg3ZTlmMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.J_cJPVbNJ69Ws0k2mdEOSm2gJh8CHU04HqH-WBXAwJ4';
  List trendingData = [];
  List popularData = [];
  List populartv = [];
  List popularmovies = [];
  List searchResults = [];

  Future<void> getData()async{

    try{
      final tmdbWithCustomLogs = TMDB( //TMDB instance
          ApiKeys(apiKey, readAccessToken),
          logConfig: ConfigLogger(
            showLogs: true,
            showErrorLogs: true,
          )
      );
      Map trending = await tmdbWithCustomLogs.v3.trending.getTrending();
      Map popular = await tmdbWithCustomLogs.v3.trending.getTrending();
      Map tv = await tmdbWithCustomLogs.v3.tv.getPopular();
      Map movies = await tmdbWithCustomLogs.v3.movies.getPopular();

      trendingData = trending['results'];
      popularData = popular['results'];
      populartv = tv['results'];
      popularmovies = movies['results'];

    }catch(e){
      print(e);
    }

    // print(trendingMovies['results']);
    // for (var i =0;i<trendingMoviesList.length;i++){
    //   print(trendingMovies[i]);
    // }
  }

  Future<List> searchData(String Query)async{
    try{
      final tmdbWithCustomLogs = TMDB( //TMDB instance
          ApiKeys(apiKey, readAccessToken),
          logConfig: ConfigLogger(
            showLogs: true,
            showErrorLogs: true,
          )
      );
      Map search = await tmdbWithCustomLogs.v3.search.queryMulti(Query);

      searchResults.clear();
      searchResults = search["results"];
      for(int i=0;i<searchResults.length;i++){
        if(searchResults[i]["poster_path"]==null){
          searchResults.removeAt(i);
        }
      }


    }catch(e){
      print(e);
    }
    return searchResults;
  }

  List getTrending(){
    return trendingData;
  }

  List getPopular(){
    return popularData;
  }

  List getMovies(){
    return popularmovies;
  }

  List getTV(){
    return populartv;
  }

}