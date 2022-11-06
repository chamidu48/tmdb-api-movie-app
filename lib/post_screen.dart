import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'explore_screen.dart';

class Post extends StatelessWidget {
  var data;
  Post({
    required this.data,
    Key? key,
  }) : super(key: key);

  List<String> casts = ['a.jpg','b.jpg','c.jpg','d.jpg','d.jpg','d.jpg'];

  String title(var dataList){
    String Title;
    if(dataList["title"]!=null){
      Title=dataList["title"];
    }else if(dataList["name"]!=null){
      Title=dataList["name"];
    }else Title = "No results";
    print(Title);
    print(data);
    return Title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff343434),
      body: Stack(
        children: [
          //--bg--
          Column(
            children: [
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage('https://image.tmdb.org/t/p/w500'+data['poster_path']),
                        repeat: ImageRepeat.noRepeat,
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xff343434).withOpacity(1),
                              Color(0xff343434).withOpacity(0.3)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter
                        ),
                      ),
                    )
                  ]
                ),
              ),
              Expanded(
                flex: 3,
                  child: Container(
                    color: Color(0xff343434),
                  ))
            ],
          ),
          SafeArea(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(onPressed: (){
                        Navigator.of(context).pop(MaterialPageRoute(builder: (context){
                          return ExploreScreen();
                        }));
                      }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                      Flexible(child: Text(
                        title(data),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 16
                      ),
                          textScaleFactor: 1,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                      )),
                      IconButton(onPressed: (){}, icon: Icon(Icons.share,color: Colors.white,))
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  margin: EdgeInsets.only(top: 150,bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex:2,
                        child: Container(
                        height: 200,
                        width: 140,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage('https://image.tmdb.org/t/p/w500'+data['poster_path']),
                            )
                        ),
                      ),),
                      SizedBox(width: 5,),
                      Expanded(
                        flex:3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(child: Text(
                            title(data),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 19
                            ),
                            textScaleFactor: 1,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.star,color: Colors.yellow,size: 18,),
                              SizedBox(width: 3,),
                              Text(data["vote_average"].toString(),style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12
                              )),
                              SizedBox(width: 20,),
                              IconButton(onPressed: (){}, icon:Icon(Icons.favorite_outline,color: Colors.white,size: 18,))
                            ],
                          ),
                          Row(
                            children:[
                              Text("Year ",style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14
                              )),
                              Text(data["first_air_date"].toString().substring(0,4),style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14
                              ),)
                            ],
                          ),
                          Row(
                            children:[
                              Text("Genre ",style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14
                              )),
                              Text(data["first_air_date"].toString().substring(0,4),style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14
                              ),)
                            ],
                          ),
                          Row(
                            children:[
                              Text("Duration ",style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14
                              )),
                              Text(data["first_air_date"].toString().substring(0,4),style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14
                              ),)
                            ],
                          ),
                          Row(
                            children:[
                              Text("Language ",style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14
                              )),
                              Text(data["first_air_date"].toString().substring(0,4),style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14
                              ),)
                            ],
                          )
                        ],
                      ),)
                    ],
                  ),
                ),

                //about
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 20,bottom: 10),
                          alignment:Alignment.centerLeft,
                          child: Text("About",style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 14
                          )),
                        ),
                        Text(data["overview"],style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w300,
                            fontSize: 12
                        ),textAlign: TextAlign.justify,),
                        Container(
                          padding: EdgeInsets.only(top: 20,bottom: 10),
                          alignment:Alignment.centerLeft,
                          child: Text("Cast",style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 14
                          )),
                        ),
                        Container(
                          height:180,
                          padding: EdgeInsets.only(bottom: 80),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: casts.length,
                            itemBuilder: ((context, index) => Row(
                              children: [
                                CircleAvatar(
                                  minRadius: 30,
                                  maxRadius: 40,
                                  backgroundColor: Colors.grey,
                                ),
                                SizedBox(width: 10,)
                              ],
                            )),
                          ),
                        )
                      ],
                    ),
                  )
                ),

                //--actors--
              ],
            ),
          ),
          Positioned(
            left: 0,right: 0,
            bottom: 0,
              child:ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffF61010),
                  minimumSize:Size.fromHeight(65),
                ),
                child: Text("Download",style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                )),
              ))
        ],
      ),
    );
  }
}
