import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sochem/utils/constants.dart';

// for linking pages uncoment route and pass your pages in the section
class HomeScreenGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleCard(
                image: FeedIcon,
                title: "Feed",
                route: '/people',
              ),
              SingleCard(
                image: CloudIcon,
                title: "Cloud",
                route: '/people',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleCard(
                image: ForumIcon,
                title: "Forum",
                route: '/people',
              ),
              SingleCard(
                image: GroupIcon,
                title: "Groups",
                route: '/people',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleCard(
                image: ProfileIcon,
                title: "Profile",
                route: '/people',
              ),
              SingleCard(
                image: PeopleIcon,
                title: "People",
                route: '/people',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SingleCard extends StatelessWidget {
  // const SingleCard({required this.image, required this.title});
  const SingleCard(
      {required this.image, required this.title, required this.route});
  final String image;
  final String title;
  final String route;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        route,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 11.0, 15.0, 0.0),
        child: Container(
          height: size.height * 0.15,
          width: size.width * 0.40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: cardImageColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                offset: const Offset(
                  1.0,
                  1.0,
                ), //Offset
                blurRadius: 5.0,
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Image.asset(
                    image,
                    width: 45.0,
                    height: 45.0,
                    color: Colors.white70,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  title,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 25,

                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      // letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
