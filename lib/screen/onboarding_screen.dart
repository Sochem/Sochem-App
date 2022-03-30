import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sochem/utils/onboarding_styles.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1, 0.4, 0.7, 0.9],
          colors: [
            Color(0xFF3594DD),
            Color(0xFF4563DB),
            Color(0xFF5036D5),
            Color(0xFF5B16D0),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: screensize.height * 0.04,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => {
                    _pageController.jumpToPage(
                      2,
                    ),
                    setState(() {
                      _currentPage = 2;
                    })
                  },
                  child: _currentPage != 2
                      ? Text(
                          'Skip',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        )
                      : Text(''),
                ),
              ),
              Container(
                height: screensize.height * 0.75,
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Image(
                              image: AssetImage(
                                'assets/varanasi.jpg',
                              ),
                              height: 300,
                              width: 300,
                            ),
                          ),
                          SizedBox(height: screensize.height * 0.01),
                          Text(
                            'Connect people\naround the world',
                            style: kTitleStyle,
                          ),
                          SizedBox(height: 1.0),
                          Text(
                            'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                            style: kSubtitleStyle,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Image(
                              image: AssetImage(
                                'assets/chemical_iit_bhu.png',
                              ),
                              height: 300.0,
                              width: 300.0,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Text(
                            'Live your life smarter\nwith us!',
                            style: kTitleStyle,
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                            style: kSubtitleStyle,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Image(
                              image: AssetImage(
                                'assets/sochem.jpeg',
                              ),
                              height: 300.0,
                              width: 300.0,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Text(
                            'Get a new experience\nof imagination',
                            style: kTitleStyle,
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                            style: kSubtitleStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
              _currentPage != _numPages - 1
                  ? Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'Next',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 30.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Text(''),
            ],
          ),
        ),
        bottomSheet: _currentPage == _numPages - 1
            ? Container(
                height: 60.0,
                width: double.infinity,
                color: Colors.white,
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/login',
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Get started',
                        style: TextStyle(
                          color: Color(0xFF5B16D0),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Text(''),
      ),
    );
  }
}
