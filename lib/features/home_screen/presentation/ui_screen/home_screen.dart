import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/home_screen/presentation/controler/cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getPosts(),
      child: SafeArea(
        child: Scaffold(
          body: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is HomeError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
            builder: (context, state) {
              var cubit = context.read<HomeCubit>();
              

              if (state is HomeSuccess) {
                var posts = state.posts;
            
                return ListView.separated(
                  itemCount: posts.length,
                  separatorBuilder: (context, index) => SizedBox(height: 5),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child:
                     Card(
                      elevation: 3,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                    posts[index]["userImage"] ??
                                        "https://tse1.mm.bing.net/th/id/OIP.yN8YpTjgLlVqQRY5gu3QHQAAAA?r=0&pid=Api&h=220&P=0",
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: .start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          posts[index]['userName'] ??
                                              "Unknown user",
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
                                      posts[index]['createdAt']
                                          .toDate()
                                          .toString(),
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
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                            child: Row(
                              mainAxisAlignment: .start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: .start,
                                    children: [
                                      SizedBox( width: MediaQuery.of(context).size.width - 50,
                                        child: Text(
                                          posts[index]['text'],
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 10,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      InkWell(
                                        onTap: () {},
                                        child: Wrap(
                                          spacing: 2,
                                          runSpacing: 2,
                                          children: [
                                            SizedBox( width: MediaQuery.of(context).size.width - 50,
                                              child: Text(
                                                posts[index]["tags"] ?? "",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w500,
                                                  
                                              
                                                ),maxLines: 5,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          if (posts[index]["imageUrl"] != null &&
                              posts[index]["imageUrl"].toString().isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 5,
                              ),
                              child: Card(
                                elevation: 2,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    posts[index]["imageUrl"],
                                  ),
                                ),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 4,
                            ),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.favorite_border_outlined,
                                      color: Colors.red,
                                      size: 18,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '${posts[index]["likesCount"] ?? 0}',
                                     
                                      style: TextStyle(
                                        color: Colors.black26,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                InkWell(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.comment,
                                        color: Colors.amber,
                                        size: 18,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "521 Comments",
                                        style: TextStyle(
                                          color: Colors.black26,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 18,
                                        backgroundImage: NetworkImage(
                                          posts[index]["userImage"] ??
                                              "https://tse1.mm.bing.net/th/id/OIP.yN8YpTjgLlVqQRY5gu3QHQAAAA?r=0&pid=Api&h=220&P=0",
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Write a Comment ...",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black26,
                                          fontWeight: .w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                      cubit.toggleLike(state.posts[index].id);
                                  
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.favorite_border_outlined,
                                        color: Colors.red,
                                        size: 18,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "Like",
                                        style: TextStyle(
                                          color: Colors.black26,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.share,
                                        color: Colors.lightGreen,
                                        size: 18,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "Share",
                                        style: TextStyle(
                                          color: Colors.black26,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                  
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
