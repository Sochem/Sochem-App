import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sochem/utils/constants.dart';
import 'package:sochem/utils/onboarding_styles.dart';

List<Color> onboardingColor = [
   Color.fromARGB(255, 57, 122, 235),
   Color.fromARGB(255, 57, 122, 235),
   Color.fromARGB(255, 57, 122, 235)
   
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
      width: isActive ? 40.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Color.fromARGB(255, 57, 122, 235) : Colors.white,
        borderRadius: isActive?BorderRadius.all(Radius.circular(400)):BorderRadius.all(Radius.circular(3)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 49, 74, 201),
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color.fromARGB(255, 22, 38, 114),Color.fromARGB(255, 10, 16, 49)])),
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
                        color: Colors.white,
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
                      image: 'assets/discover.png',
                      title: 'Discover',
                      desc:
                          'A one-stop-shop for\neverything atomic! From books to\nroadmaps and professors...',
                    ),
                    onboardingPage(
                      screenSize: screenSize,
                      image: 'assets/connect.png',
                      title: 'Connect',
                      desc:
                          'An eezy-peezy way to find\nyour colleagues or even connect\nand network with our Alumni...',
                    ),
                    onboardingPage(
                      screenSize: screenSize,
                      image: 'assets/experience.png',
                      title:
                          'Experience',
                      desc:
                      'Get updated about all the\n events and activities now within\nyour comfort & reach!',
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
              // Visibility(
              //   visible: _currentPage != _numPages - 1,
              //   child: Expanded(
              //     child: Align(
              //       alignment: FractionalOffset.bottomRight,
              //       child: TextButton(
              //         onPressed: () {
              //           _pageController.nextPage(
              //             duration: Duration(milliseconds: 500),
              //             curve: Curves.ease,
              //           );
              //         },
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           mainAxisSize: MainAxisSize.min,
              //           children: <Widget>[
              //             Text(
              //               'Next',
              //               style: TextStyle(
              //                 color: onboardingColor[_currentPage],
              //                 fontSize: 22.0,
              //               ),
              //             ),
              //             SizedBox(width: 10.0),
              //             Icon(
              //               Icons.arrow_forward,
              //               color: Colors.white,
              //               size: 30.0,
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: 10.0)
            ],
          ),
        ),
      ),
      bottomSheet: Visibility(
        visible: _currentPage == _numPages - 1,
        child: Container(
               decoration: BoxDecoration(gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color.fromARGB(255, 13, 23, 70),Color.fromARGB(255, 9, 18, 61)])),
              height: 60.0,
              width: double.infinity,
          
          
          child: GestureDetector(
            onTap: () async {
              var prefs = await SharedPreferences.getInstance();
              prefs.setBool(isOnboarded, true);
              Navigator.pushReplacementNamed(context, LoginRoute);
            },
            child: Center(
              child: Container(
                height: 40,
                width: 300,
                  decoration: BoxDecoration(
                  color: Color.fromARGB(255, 57, 122, 235),
                  borderRadius: BorderRadius.all(Radius.circular(20)),),
                   child:Center(
                     child: Text(
                                     'Explore',
                                     style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                                   ),
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
      padding: EdgeInsets.fromLTRB(10.0,0.0,10.0,0.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[ SizedBox(height: screenSize.height * 0.05),
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style:TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 28, fontStyle: FontStyle.normal),
              ),
            ),
            Center(
              child: Image(
                image: AssetImage(
                  image,
                ),
                height: 300,
                width: 300,
              ),
            ),
            Text(
              '\n'+desc,
              textAlign: TextAlign.center,
                style:TextStyle(fontSize: 18,color:Color.fromARGB(255, 57, 122, 235)),
            ),
          ],
        ),
      ),
    );
  }
}
