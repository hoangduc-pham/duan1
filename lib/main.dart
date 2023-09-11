import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void main() {
  runApp(SocialNetworkApp());
}

class SocialNetworkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Network App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FocusNode commentFocusNode = FocusNode();
  List<Post> posts = [
    Post(
      username: 'Pham Anh Cuong',
      content: 'Toi thay cac ban rat dang yeu va dep mat, toi se dem con cho nha toi sang nha ban de no di choi cung!',
      likes: 15,
      comments: 5,
      dislike: 9,
    ),
    Post(
      username: 'jane_smith',
      content: 'Hello, my name is jane !',
      likes: 10,
      comments: 2,
      dislike: 9,
    ),
    Post(
      username: 'Pham Duc Hoang',
      content: 'Hom nay troi dep vai ca lon',
      likes: 10,
      comments: 2,
      dislike: 9,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mang xa hoi facebook'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostCard(post: posts[index], commentFocusNode: commentFocusNode);
        },
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;
  final TextEditingController commentController = TextEditingController();
  final FocusNode commentFocusNode;

  PostCard({required this.post, required this.commentFocusNode})
      : super(key: ObjectKey(post));

  void _showUserProfile(BuildContext context) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) {
        return UserProfilePage(userName: post.username);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                _showUserProfile(context);
              },
              child: Text(
                post.username,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            Text(post.content),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.thumb_up_alt_outlined),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            Icon(Icons.favorite, color: Colors.redAccent),
                            SizedBox(width: 5),
                            Text('Liked', style: TextStyle(color: Colors.redAccent)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Text('${post.likes} Likes'),
                IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: () {},
                ),
                Text('${post.comments} comments'),
                IconButton(
                  icon: Icon(Icons.thumb_down),
                  onPressed: () {},
                ),
                Text('${post.dislike} dislike'),
              ],
            ),
            TextField(
              focusNode: commentFocusNode,
              decoration: InputDecoration(
                hintText: 'Viet binh luan di...',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserProfilePage extends StatelessWidget {
  final String userName;

  UserProfilePage({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hồ sơ người dùng'),
      ),
      body: Center(
        child: Text(
          'Hồ sơ của $userName',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class Post {
  final String username;
  final String content;
  final int likes;
  final int comments;
  final int dislike;

  Post({
    required this.username,
    required this.content,
    required this.likes,
    required this.comments,
    required this.dislike,
  });
}
