import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api_movie_app/Services/api_data.dart';
import 'package:tmdb_api_movie_app/Services/send_receive_data.dart';
import 'package:tmdb_api_movie_app/post_screen.dart';
import 'package:tmdb_api_movie_app/search_screen.dart';
import 'package:tmdb_api_movie_app/see_all.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {

  bool isLoading = true;//--set this as true
  List trending=[];
  List popular=[];
  List movies = [];
  List tv = [];

  ApiData instance = new ApiData();

  void getData()async{
    await instance.getData();
    trending = instance.getTrending();
    popular = instance.getPopular();
    movies = instance.getMovies();
    tv = instance.getTV();

    if(trending.length>0 && popular.length>0){
      setState(() {
        isLoading = false;
      });
      // Navigator.pushNamed(context,'/' ,
      //     arguments: ReceiveData(trending: trending,popular: popular)
      // );
    }
    print(tv[2]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  double ActiveIndex = 2;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff343434),
          title: Text('MovieHub',textScaleFactor: 1,style: TextStyle(
              fontFamily: 'Inika',
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: Color(0xffFCFAF1),
              letterSpacing: 1.2
          ),),
          elevation: 0,
          leading: IconButton(onPressed: (){
            Scaffold.of(context).openDrawer();
          }, icon: Icon(Icons.menu,color: Color(0xffFCFAF1),)),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.notifications,color: Color(0xffFCFAF1)))
          ],
        ),
        backgroundColor: Color(0xff343434),
        body: isLoading? Center(child: CircularProgressIndicator(color: Colors.red,),)
            :ListView(
          padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
          children: [
            InkWell(
              splashColor: Colors.transparent,
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return SearchPage();
                }));
              },
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              child: Container(
                  margin: EdgeInsets.only(top: 0,bottom: 10,left: 10,right: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  height: 45,
                  color: Color(0xffFCFAF1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Search Movies, TV Shows',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13,
                            color: Color(0xffbbbbbb)
                        ),),
                      Icon(Icons.search,color: Color(0xffCACACA),)
                    ],
                  ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Whats New !',textScaleFactor: 1,style: TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0xffFCFAF1),
                      fontWeight: FontWeight.w600,
                      fontSize: 15
                  ),),
                  TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return SeeAll(data: trending);
                        }));
                      },
                      child: Text('See all',style: TextStyle(
                          fontFamily: 'Inika',
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          color: Color(0xffF61010),
                          letterSpacing: 1.2
                      ),),
                  )
                ],
              )
            ),
            //movies
            Container(
              height: 210,
              margin: EdgeInsets.only(top: 0),
              child: CarouselSlider.builder(
                  itemCount: trending.length,
                  options: CarouselOptions(
                    autoPlay: true,
                    padEnds: false,
                    pauseAutoPlayOnTouch: true,
                    viewportFraction: 0.9,
                    onPageChanged: (index,reason){
                      setState(() {
                        ActiveIndex = index.toDouble();
                      });
                    },
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.antiAlias,
                  ),
                  itemBuilder: (context, index, realIndex) {
                    return Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.antiAlias,
                        children:[
                          Container(
                            margin: EdgeInsets.only(right: 0,left: 10),
                            height: 200,
                            width: 350,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage('https://image.tmdb.org/t/p/w500'+trending[index]['backdrop_path']),
                                    fit: BoxFit.cover,
                                    repeat: ImageRepeat.noRepeat
                                )
                            ),
                          ),
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Color(0xff363636).withOpacity(0.8),Color(0xff363636).withOpacity(0.1)],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 30, 10, 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    trending[index]['title'] ==null?Flexible(
                                      child: Text(trending[index]['name']
                                        ,style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16
                                        ),textScaleFactor: 1,overflow: TextOverflow.ellipsis,maxLines: 1,),
                                    )
                                        :Flexible(
                                      child: Text(trending[index]['title'],style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16
                                      ),textScaleFactor: 1,overflow: TextOverflow.ellipsis,maxLines: 1,),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.star,color: Colors.yellow,size: 20,),
                                        SizedBox(width: 2),
                                        Text(trending[index]['vote_average'].toString().substring(0,3),style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16
                                        ),textScaleFactor: 1,overflow: TextOverflow.ellipsis,maxLines: 1,),
                                      ],
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                ),
                              ],
                            ),
                          ),
                        ]
                    );
                  }),
            ),
            //indicator
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DotsIndicator(
                    dotsCount: trending.length,
                    position: ActiveIndex,
                    decorator: DotsDecorator(
                      color: Colors.white,
                      activeColor: Color(0xffF61010 ),
                      size: const Size.square(5.0),
                      activeSize: const Size(12.0, 5.0),
                      spacing: EdgeInsets.all(3),
                      activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                    ),)
                ],
              ),
            ),

            //popular
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Popular',textScaleFactor: 1,style: TextStyle(
                        fontFamily: 'Inter',
                        color: Color(0xffFCFAF1),
                        fontWeight: FontWeight.w600,
                        fontSize: 15
                    ),),
                    TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return SeeAll(data: popular);
                        }));
                      },
                      child: Text('See all',style: TextStyle(
                          fontFamily: 'Inika',
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          color: Color(0xffF61010),
                          letterSpacing: 1.2
                      ),),
                    )
                  ],
                )
            ),
            SizedBox(height: 5,),
            //posts
            Container(
              height: 230,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return Post(data: popular[index]);
                        }));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 180,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 190,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage('https://image.tmdb.org/t/p/w500'+popular[index]['poster_path']),
                                      fit: BoxFit.cover,
                                      repeat: ImageRepeat.noRepeat
                                  )
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: popular[index]['title']==null?Text(popular[index]['name'],style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500
                                  ),
                                    textScaleFactor: 1,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ):Text(popular[index]['title'],style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500
                                  ),
                                    textScaleFactor: 1,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                Text(popular[index]['release_date'].toString().substring(0,4),style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Action/Sci-fi',style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12
                                ),),
                                Row(
                                  children: [
                                    Icon(Icons.star,color: Colors.yellow,size: 12,),
                                    SizedBox(width: 2),
                                    Text(popular[index]['vote_average'].toString(),style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12
                                    ),),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(height: 10,),

            //movies
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Movies',textScaleFactor: 1,style: TextStyle(
                        fontFamily: 'Inter',
                        color: Color(0xffFCFAF1),
                        fontWeight: FontWeight.w600,
                        fontSize: 15
                    ),),
                    TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return SeeAll(data: movies);
                        }));
                      },
                      child: Text('See all',style: TextStyle(
                          fontFamily: 'Inika',
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          color: Color(0xffF61010),
                          letterSpacing: 1.2
                      ),),
                    )
                  ],
                )
            ),
            SizedBox(height: 5,),
            //posts
            Container(
              height: 230,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return Post(data: movies[index]);
                        }));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 180,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 190,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage('https://image.tmdb.org/t/p/w500'+movies[index]['poster_path']),
                                      fit: BoxFit.cover,
                                      repeat: ImageRepeat.noRepeat
                                  )
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: movies[index]['title']==null?Text(movies[index]['name'],style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500
                                  ),
                                    textScaleFactor: 1,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ):Text(movies[index]['title'],style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500
                                  ),
                                    textScaleFactor: 1,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                Text(movies[index]['release_date'].toString().substring(0,4),style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Action/Sci-fi',style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12
                                ),),
                                Row(
                                  children: [
                                    Icon(Icons.star,color: Colors.yellow,size: 12,),
                                    SizedBox(width: 2),
                                    Text(movies[index]['vote_average'].toString(),style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12
                                    ),),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(height: 10,),

            //tv
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('TV Shows',textScaleFactor: 1,style: TextStyle(
                        fontFamily: 'Inter',
                        color: Color(0xffFCFAF1),
                        fontWeight: FontWeight.w600,
                        fontSize: 15
                    ),),
                    TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return SeeAll(data: tv);
                        }));
                      },
                      child: Text('See all',style: TextStyle(
                          fontFamily: 'Inika',
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          color: Color(0xffF61010),
                          letterSpacing: 1.2
                      ),),
                    )
                  ],
                )
            ),
            SizedBox(height: 5,),
            //posts
            Container(
              height: 230,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return Post(data: tv[index]);
                        }));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 180,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 190,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage('https://image.tmdb.org/t/p/w500'+tv[index]['poster_path']),
                                      fit: BoxFit.cover,
                                      repeat: ImageRepeat.noRepeat
                                  )
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: tv[index]['title']==null?Text(tv[index]['name'],style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500
                                  ),
                                    textScaleFactor: 1,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ):Text(tv[index]['title'],style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500
                                  ),
                                    textScaleFactor: 1,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                Text(tv[index]['release_date'].toString().substring(0,4),style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Action/Sci-fi',style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12
                                ),),
                                Row(
                                  children: [
                                    Icon(Icons.star,color: Colors.yellow,size: 12,),
                                    SizedBox(width: 2),
                                    Text(tv[index]['vote_average'].toString(),style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12
                                    ),),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(height: 10,),

          ],
        ),
      ),
    );
  }
}
