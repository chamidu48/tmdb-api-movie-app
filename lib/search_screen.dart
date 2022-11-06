import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api_movie_app/dashboard_screen.dart';
import 'package:tmdb_api_movie_app/explore_screen.dart';
import 'package:tmdb_api_movie_app/post_screen.dart';

import 'Services/api_data.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key,}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}
class _SearchPageState extends State<SearchPage> {

  bool isLoading = true;
  List searchResults=[];
  final searchController = TextEditingController();

  ApiData searchInstance = new ApiData();

  void searchData(String Query)async{
    searchResults = await searchInstance.searchData(Query);

    if(searchResults.length>0){
      setState(() {
        isLoading = false;
      });
    }
    print(searchResults[1]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff343434),
          leading: IconButton(onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
              return Dashboard();
            }));
          },icon: Icon(Icons.arrow_back_ios),),
          title: Text('Search',textScaleFactor: 1,style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Color(0xffFCFAF1),
              letterSpacing: 1.2
          ),),
          elevation: 0,
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,color: Color(0xffFCFAF1)))
          ],
        ),
        backgroundColor: Color(0xff343434),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              height: 45,
              color: Color(0xffFCFAF1),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  searchData(value);
                },
                autofocus: true,
                cursorColor: Color(0xffF61010),
                decoration: InputDecoration(
                    hoverColor: Color(0xffF61010 ),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: Color(0xffCACACA)
                    ),
                    suffixIcon: Icon(Icons.search,color: Color(0xffCACACA),),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none
                ),
              )
            ),
            Expanded(child: searchResults.length<0?Center(child: Text('No results'))
            :ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: searchResults.length,
              itemBuilder: ((context, index) {
                return InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return Post(data: searchResults[index]);
                    }));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right:10),
                          height: 200,
                          width: 150,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                repeat: ImageRepeat.noRepeat,
                                image: NetworkImage('https://image.tmdb.org/t/p/w500'+searchResults[index]['poster_path']),
                              )
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              searchResults[index]['original_title']==null?Flexible(
                                child: Text(searchResults[index]['original_name'],
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    color: Colors.white
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,),
                              )
                                  :Flexible(
                                child: Text(searchResults[index]['original_title'],
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    color: Colors.white
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,),
                              ),
                              Flexible(
                                child: Text(searchResults[index]['overview'],
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300,
                                    color: Colors.white
                                  ),
                                  maxLines: 3,
                                  textScaleFactor: 1,
                                  overflow: TextOverflow.ellipsis,),
                              )
                            ],
                          ),
                          flex: 6,
                        )
                      ],
                    ),
                  ),
                );
              }),
            ))
          ],
        ),
      ),
    );
  }
}
