import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sochem/models/post_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  //Posts ViewModel
  List<Post> _posts = [];
  Future<List<Post>> fetchPosts() async {
    var response =
        await http.get(Uri.parse('https://api.npoint.io/bf243fd49e6b8783f02b'));

    List<Post> books = [];
    if (response.statusCode == 200) {
      var booksJson = json.decode(response.body);
      for (var bookJson in booksJson) {
        books.add(Post.fromJson(bookJson));
      }
    }
    return books;
  }

  //Posts View
  @override
  void initState() {
    fetchPosts().then((value) {
      setState(() {
        _posts.addAll(value);
      });
    });
    super.initState();
  }

  Widget _buildPost(int index) {
    // var postCreatedAt = DateTime(
    //   _posts[index].timeAgo.year,
    //   _posts[index].timeAgo.month,
    //   _posts[index].timeAgo.day,
    // );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        child: ClipOval(
                          child: Image(
                            height: 50.0,
                            width: 50.0,
                            image: AssetImage(_posts[index].authorImageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      _posts[index].authorName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(DateFormat.yMMMMd('en_US')
                        .format(DateTime.now())
                        .toString()),
                    //TODO: Adding sharing option for posts

                    // trailing: IconButton(
                    //   icon: Icon(Icons.share),
                    //   color: Colors.black,
                    //   onPressed: () => print('Share'),
                    // ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    width: double.infinity,
                    height: 250.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 8.0,
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      child: Center(
                        child: Hero(
                          tag: "$index",
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.contain,
                              imageUrl: _posts[index].imageUrl,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => viewPost(index)),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      _posts[index].postHeading,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF0F6),
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              color: kPrimaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: const Offset(
                    1.0,
                    1.0,
                  ), //Offset
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Center(
                child: Text(
                  'Your Feed',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      fontSize: 37,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      // letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              child: ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (BuildContext context, int index) {
                  if (_posts.length == 0) {
                    return SizedBox(width: 10.0);
                  }
                  return _buildPost(index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget viewPost(int index) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: _posts[index].imageUrl,
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Text(
                _posts[index].postHeading,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Text(_posts[index].postDesc),
            ),
          ],
        ),
      ),
    );
  }
}
