import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sochem/utils/constants.dart';
// import 'package:sochem/view/people.dart';

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
                // route: PeoplePage(),
              ),
              SingleCard(
                image: CloudIcon,
                title: "Cloud",
                // route: PeoplePage(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleCard(
                image: ForumIcon,
                title: "Forum",
                // route: PeoplePage(),
              ),
              SingleCard(
                image: GroupIcon,
                title: "Groups",
                // route: PeoplePage(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleCard(
                image: ProfileIcon,
                title: "Profile",
                // route: PeoplePage(),
              ),
              SingleCard(
                image: PeopleIcon,
                title: "People",
                // route: PeoplePage(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SingleCard extends StatelessWidget {
  const SingleCard({required this.image, required this.title});
// const SingleCard({required this.image, required this.title, required this.route});
  final String image;
  final String title;
  // final Widget route;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      // onTap: () => Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => route,
      //   ),
      // ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
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
                padding: const EdgeInsets.only(top: 10.0),
                child: Center(
                  child: Image.asset(
                    image,
                    width: 60.0,
                    height: 60.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  title,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 20,

                      fontWeight: FontWeight.w600,
                      color: Colors.black,
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
