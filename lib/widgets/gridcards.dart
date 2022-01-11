import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sochem/utils/constants.dart';

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
              SingleCard(image: FeedIcon, title: "Feed"),
              SingleCard(image: CloudIcon, title: "Cloud"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleCard(image: ForumIcon, title: "Forum"),
              SingleCard(image: GroupIcon, title: "Groups"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleCard(image: ProfileIcon, title: "Profile"),
              SingleCard(image: PeopleIcon, title: "People"),
            ],
          ),
        ],
      ),
    );
  }
}

class SingleCard extends StatelessWidget {
  const SingleCard({required this.image, required this.title});

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
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
    );
  }
}
