import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sochem/utils/constants.dart';
import 'package:sochem/utils/onboarding_styles.dart';

List<Color> onboardingColor = [
  Color(0xFF7bc05b),
  Color(0xFFffb61d),
  Color(0xFF767bff),
];

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
        color: isActive ? onboardingColor[_currentPage] : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 10.0),
              Container(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => {
                    _pageController.jumpToPage(_numPages - 1),
                    setState(() {
                      _currentPage = _numPages - 1;
                    })
                  },
                  child: Visibility(
                    visible: _currentPage != _numPages - 1,
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: onboardingColor[_currentPage],
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: screenSize.height * 0.75,
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: <Widget>[
                    onboardingPage(
                      screenSize: screenSize,
                      image: 'assets/search.png',
                      title: 'Discover!\nA new door of possibilities',
                      desc:
                          'Having trouble getting resources?\nYou will find it all here. From Books to Roadmaps, be it helping with your Core Subjects or Preparation for others. \nWe got you all covered!',
                    ),
                    onboardingPage(
                      screenSize: screenSize,
                      image: 'assets/Technology.png',
                      title: 'Connect!\nWith our Society',
                      desc:
                          'Find your Group, Colleagues or \neven Connect with our Alumni?\n An eezy peezy way to do it all',
                    ),
                    onboardingPage(
                      screenSize: screenSize,
                      image: 'assets/Food.png',
                      title:
                          'Experience!\nUpdated and delivered at your Fingertips',
                      desc:
                          'Updates about Events and Activites now within your comfort and reach',
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
              Visibility(
                visible: _currentPage != _numPages - 1,
                child: Expanded(
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
                              color: onboardingColor[_currentPage],
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
                ),
              ),
              SizedBox(height: 10.0)
            ],
          ),
        ),
      ),
      bottomSheet: Visibility(
        visible: _currentPage == _numPages - 1,
        child: Container(
          height: 60.0,
          width: double.infinity,
          color: Colors.white,
          child: GestureDetector(
            onTap: () async {
              var prefs = await SharedPreferences.getInstance();
              prefs.setBool(isOnboarded, true);
              Navigator.pushReplacementNamed(context, LoginRoute);
            },
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
        ),
      ),
    );
  }
}

class onboardingPage extends StatelessWidget {
  const onboardingPage({
    Key? key,
    required this.screenSize,
    required this.image,
    required this.title,
    required this.desc,
  }) : super(key: key);

  final Size screenSize;
  final String image;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage(
                image,
              ),
              height: 300,
              width: 300,
            ),
          ),
          SizedBox(height: screenSize.height * 0.01),
          Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: kTitleStyle,
            ),
          ),
          SizedBox(height: screenSize.height * 0.05),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: kSubtitleStyle,
          ),
        ],
      ),
    );
  }
}
