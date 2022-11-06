import 'package:flutter/material.dart';
import 'package:tmdb_api_movie_app/post_screen.dart';
class SeeAll extends StatelessWidget {
  var data;
  SeeAll({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.popAndPushNamed(context, '/');
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: Color(0xff343434),
          elevation: 0,
          title: Text('See All',style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.white
          ),),
          centerTitle: true,
        ),
        backgroundColor: Color(0xff343434),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Expanded(child: data.length<0?Center(child: Text('No results'))
                  :ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: data.length,
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return Post(data: data[index]);
                      }));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
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
                                  image: NetworkImage('https://image.tmdb.org/t/p/w500'+data[index]['poster_path']),
                                )
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                data[index]['original_title']==null?Flexible(
                                  child: Text(data[index]['original_name'],
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
                                  child: Text(data[index]['original_title'],
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
                                  child: Text(data[index]['overview'],
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
      ),
    );
  }
}
