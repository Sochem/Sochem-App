import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sochem/main.dart';
import 'package:sochem/models/post_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:sochem/utils/constants.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sochem/utils/endpoints.dart';
import 'package:sochem/widgets/error_messages.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<Post> _posts = [];
  late String token;
  Future<List<Post>> fetchPosts() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(isLoggedIn)!) {
      token = prefs.getString(DjangoToken)!;
    } else {
      token = dotenv.get(GuestToken);
    }
    var response = await http.get(
      Uri.parse(Endpoints.feed),
      headers: {HttpHeaders.authorizationHeader: token},
    );
    List<Post> posts = [];
    if (response.statusCode == 200) {
      var postsJson = json.decode(response.body);
      for (var postJson in postsJson) {
        posts.add(Post.fromJson(postJson));
      }
    }
    return posts;
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      image: AssetImage(SochemIcon),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              title: Text(
                'SoChem',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(_posts[index].date),
              //TODO: Adding sharing option for posts
              // trailing: IconButton(
              //   icon: Icon(Icons.share),
              //   color: Colors.black,
              //   onPressed: () => print('Share'),
              // ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
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
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: _posts[index].cover1 != null ||
                                  _posts[index].cover2 != null
                              ? NetworkImage(
                                  _posts[index].cover1 != null
                                      ? _posts[index].cover1
                                      : _posts[index].cover2,
                                )
                              : AssetImage(SochemIcon) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => viewPost(index),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Center(
                child: Text(
                  _posts[index].title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.13,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              color: kPrimaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: const Offset(1.0, 1.0), //Offset
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Center(
                child: Text(
                  'Your Feed',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      // letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.86,
            child: FutureBuilder(
              future: fetchPosts(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return SomethingWentWrong();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: _posts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildPost(index);
                      });
                }
                return Loading();
              },
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
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
            children: [
              _posts[index].cover2 != null
                  ? CachedNetworkImage(
                      imageUrl: _posts[index].cover2,
                    )
                  : Image.asset(SochemIcon),
              SizedBox(height: 10.0),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    _posts[index].title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Html(
                  data: _posts[index].description.replaceAll("â¢", "•"),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    _posts[index].file1 != null
                        ? TextButton(
                            onPressed: () {
                              launch(_posts[index].file1);
                            },
                            child: Container(
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    cardImageColor,
                                    Color.fromARGB(255, 128, 203, 196),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(5, 5),
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'View File',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Visibility(
                            child: TextButton(
                              onPressed: () {
                                launch(_posts[index].file2);
                              },
                              child: Container(
                                width: 200,
                                height: 50,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      cardImageColor,
                                      Color.fromARGB(255, 128, 203, 196),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(5, 5),
                                      blurRadius: 10,
                                    )
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    'View Second File',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            visible: _posts[index].file2 != null,
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
