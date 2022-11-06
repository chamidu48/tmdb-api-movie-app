import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class buildDrawer extends StatelessWidget {
  const buildDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Color(0xff393939),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(width: 20,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('John Alexi',style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white
                            ),),
                            Text('Online',style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                color: Colors.green
                            ),)
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 2,
                    color: Color(0xffF61010),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    onTap: (){},
                    title: Text('Home',style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                    ),),
                  ),
                  ListTile(
                    onTap: (){},
                    title: Text('Search',style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                    ),),
                  ),
                  ListTile(
                    onTap: (){},
                    title: Text('Saved',style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                    ),),
                  ),
                  ListTile(
                    onTap: (){},
                    title: Text('Settings',style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                    ),),
                  )
                ],
              ),
              Text('Designed and developed by Chamidu Shilakshitha',style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 12
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
