import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
           ListView.separated(itemCount: 6,separatorBuilder: (context, index) => SizedBox(height: 5,),
            itemBuilder: (context, index) => 
            
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  elevation: 3,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                "https://images.squarespace-cdn.com/content/v1/52fd615de4b0feb85ec2833f/1583271314308-3ENJECU3U0MOMWTD36HW/Social+Media+Photography",
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: .start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Gehad Wael",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.blue,
                                      size: 15,
                                    ),
                                  ],
                                ),
                                Text(
                                  "August 15,2026 at 3:00 PM",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black26,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.more_horiz_rounded),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: .infinity, child: Divider()),
           
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, when designers at Letraset and James Mosley, the librarian at St Bride Printing Library in London",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Wrap(
                            spacing: 3,
                            runSpacing: 3,
                            children: [
                              Text(
                                "#Flutter",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "#Dart",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "#Flutter_Developer",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "#Mobile_App",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "#CS",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                        child: Card(elevation: 2,
                          child:ClipRRect(borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                            "https://photographyreference.com/wp-content/uploads/2022/11/social-media-photography-filming.jpg",
                          ),
                                        )
                             ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 4),
                      child: Row(
                        children: [
                      InkWell(
                          child: Row(
                            children: [Icon(Icons.favorite_border_outlined,color: Colors.red,size: 18,),
                            SizedBox(width: 5,),
                          Text("1200",style: TextStyle(color: Colors.black26,fontSize: 13),)
                          ],),
                        ),Spacer()
                       ,InkWell(
                          child: Row(
                            children: [Icon(Icons.comment,color: Colors.amber,size: 18,),
                            SizedBox(width: 5,),
                          Text("521 Comments",style: TextStyle(color: Colors.black26,fontSize: 13),)
                          ],),
                        )
                                 
                                     
                      ],),
                    )
                    ,Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           InkWell(
                             child: Row(
                               children: [
                                 CircleAvatar(
                                      radius: 18,
                                      backgroundImage: NetworkImage(
                                        "https://images.squarespace-cdn.com/content/v1/52fd615de4b0feb85ec2833f/1583271314308-3ENJECU3U0MOMWTD36HW/Social+Media+Photography",
                                      ),
                                    ),SizedBox(width: 10,),
                              Text("Write a Comment ...",style: TextStyle(fontSize: 12,color: Colors.black26,fontWeight: .w500),)
                               ],
                             ),
                           ),
                           InkWell(
                          child: Row(
                            children: [Icon(Icons.favorite_border_outlined,color: Colors.red,size: 18,),
                            SizedBox(width: 5,),
                          Text("Like",style: TextStyle(color: Colors.black26,fontSize: 13),)
                          ],),
                        ),
                         InkWell(
                          child: Row(
                            children: [Icon(Icons.share,color: Colors.lightGreen,size: 18,),
                            SizedBox(width: 5,),
                          Text("Share",style: TextStyle(color: Colors.black26,fontSize: 13),)
                          ],),
                        )
                       
                   
                      ],),
                    ),
                    SizedBox(height: 8,)
                    ],
                  ),
                ),
              ),
            
                 ),
         
       
    );
  }
}
