import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sochem/screen/login_page.dart';
import 'package:sochem/screen/models/slide.dart';
import 'package:sochem/utils/constants.dart';

class BoardingPage extends StatefulWidget {
  @override
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingPage> {
  int _currentPage = 0;
  List<Slide> _slides = [];
  PageController _pageController = PageController();

  @override
  void initState() {
    _currentPage = 0;
    _pageController = PageController(initialPage: _currentPage);
    super.initState();
  }

  List<Widget> _buildSlides() {
    _slides = [
      Slide(Slideimg1, "Replace this text with heading of first slide",
          "Replace this text with content of first slide"),
      Slide(Slideimg2, "Replace this text with heading of second slide",
          "Replace this text with content of second slide"),
      Slide(Slideimg3, "Replace this text with heading of third slide",
          "Replace this text with content of third slide"),
      Slide(SochemIcon, "Have Fun", "We hope you will find the App Useful"),
    ];
    return _slides.map(_buildSlide).toList();
  }

  Widget _buildSlide(Slide slide) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Image.asset(
              slide.image,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(horizontal: 70),
          child: Text(
            slide.heading,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(horizontal: 70),
          child: Text(
            slide.content,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Visibility(
          visible: _currentPage == (_slides.length - 1),
          child: Container(
            margin: EdgeInsets.only(top: 10),
            child: ElevatedButton(
              onPressed: () {
                setOnBoarding();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text("LET'S GO"),
            ),
          ),
        ),
        SizedBox(
          height: 200,
        )
      ],
    );
  }

  void setOnBoarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(hasOnboarded, true);
  }

  void _changePage(int page) {
    _pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  void _handlingOnPageChanged(int page) {
    setState(() => _currentPage = page);
  }

  Widget _buildPageIndicator() {
    Row row = Row(mainAxisAlignment: MainAxisAlignment.center, children: []);
    for (int i = 0; i < _slides.length; i++) {
      row.children.add(_buildPageIndicatorItem(i));
      if (i != _slides.length - 1) {
        row.children.add(SizedBox(width: 12));
      }
    }
    return row;
  }

  //page indicator circles
  Widget _buildPageIndicatorItem(int index) {
    return Container(
      width: index == _currentPage ? 8 : 5,
      height: index == _currentPage ? 8 : 5,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: index == _currentPage ? highlighted : unhighlighted,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            PageView(
              controller: _pageController,
              onPageChanged: _handlingOnPageChanged,
              physics: BouncingScrollPhysics(),
              children: _buildSlides(),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Visibility(
                visible: _currentPage != (_slides.length - 1),
                child: TextButton(
                  onPressed: () => _changePage(_slides.length - 1),
                  child: Text("Skip"),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: _buildPageIndicator(),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Visibility(
                visible: _currentPage != (_slides.length - 1),
                child: IconButton(
                  onPressed: () => _changePage(_currentPage + 1),
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
