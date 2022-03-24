import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sochem/models/books.dart';
import 'package:sochem/utils/constants.dart';
import 'package:sochem/widgets/cloud_carousel.dart';
import 'package:http/http.dart' as http;

class CloudPage extends StatefulWidget {
  const CloudPage({Key? key}) : super(key: key);

  @override
  State<CloudPage> createState() => _CloudPageState();
}

class _CloudPageState extends State<CloudPage> {
  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: <Widget>[
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  color: kPrimaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: const Offset(
                        1.0,
                        1.0,
                      ), //Offset
                      blurRadius: 30.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                padding: EdgeInsets.only(top: 30.0),
                height: screensize.height * 0.35,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: null,
                          icon: ImageIcon(
                            AssetImage(BackIcon),
                            size: 50.0,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              "Cloud",
                              textAlign: TextAlign.left,
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
                        RotatedBox(
                          quarterTurns: 2,
                          child: IconButton(
                            onPressed: null,
                            icon: ImageIcon(
                              AssetImage(BackIcon),
                              size: 50.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: CloudCarousel(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            height: screensize.height * 0.635,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                GenreTitle(
                  title: 'Books/Novels',
                ),
                BooksHorizontal(
                    genreURL: 'https://api.npoint.io/ce067c8d01658dad23b7'),
                GenreTitle(
                  title: 'Code',
                ),
                BooksHorizontal(
                    genreURL: 'https://api.npoint.io/ce067c8d01658dad23b7'),
                GenreTitle(
                  title: 'Core',
                ),
                BooksHorizontal(
                    genreURL: 'https://api.npoint.io/ce067c8d01658dad23b7'),
                GenreTitle(
                  title: 'GATE',
                ),
                BooksHorizontal(
                    genreURL: 'https://api.npoint.io/ce067c8d01658dad23b7'),
                GenreTitle(
                  title: 'GRE',
                ),
                BooksHorizontal(
                    genreURL: 'https://api.npoint.io/ce067c8d01658dad23b7'),
                GenreTitle(
                  title: 'HULM',
                ),
                BooksHorizontal(
                    genreURL: 'https://api.npoint.io/ce067c8d01658dad23b7'),
                GenreTitle(
                  title: 'Online Courses',
                ),
                BooksHorizontal(
                    genreURL: 'https://api.npoint.io/ce067c8d01658dad23b7'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BooksHorizontal extends StatefulWidget {
  const BooksHorizontal({required this.genreURL});
  final String genreURL;

  @override
  State<BooksHorizontal> createState() => _BooksHorizontalState();
}

class _BooksHorizontalState extends State<BooksHorizontal> {
  //Books viewmodel
  List<Book> _books = [];
  Future<List<Book>> fetchBooks() async {
    var response = await http.get(Uri.parse(widget.genreURL));

    List<Book> books = [];
    if (response.statusCode == 200) {
      var booksJson = json.decode(response.body);
      for (var bookJson in booksJson) {
        books.add(Book.fromJson(bookJson));
      }
    }
    return books;
  }

  //Books View
  @override
  void initState() {
    fetchBooks().then((value) {
      setState(() {
        _books.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Container(
          height: 200.0,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  margin: EdgeInsets.only(
                    left: 10,
                    top: 5,
                    bottom: 5,
                  ),
                  decoration: BoxDecoration(
                    image: new DecorationImage(
                        image: NetworkImage(_books[index].imageAddress),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.red,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 5.0,
                        spreadRadius: 0.0,
                        offset: Offset(0.5, 0.5),
                      ),
                    ],
                  ),
                  width: screensize.width * 0.36,
                ),
              );
            },
            itemCount: _books.length,
            scrollDirection: Axis.horizontal,
          )
          // This next line does the trick.

          ),
    );
  }
}

class GenreTitle extends StatelessWidget {
  const GenreTitle({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Text(
          '$title',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
