import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sochem/utils/constants.dart';
import 'package:sochem/widgets/error_messages.dart';

class HomeScreenGrid extends StatefulWidget {
  @override
  State<HomeScreenGrid> createState() => _HomeScreenGridState();
}

class _HomeScreenGridState extends State<HomeScreenGrid> {
  bool loggedIn = false;

  @override
  void initState() {
    super.initState();
    _initialising();
  }

  void _initialising() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      loggedIn = prefs.getBool(isLoggedIn)!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SingleCard(
              image: FeedIcon,
              title: "Feed",
              route: FeedRoute,
              allowed: true,
            ),
            SingleCard(
              image: CloudIcon,
              title: "Cloud",
              route: CloudRoute,
              allowed: loggedIn,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SingleCard(
              image: ForumIcon,
              title: "Forum",
              route: ForumRoute,
              allowed: loggedIn,
            ),
            SingleCard(
              image: GroupIcon,
              title: "Groups",
              route: GroupRoute,
              allowed: true,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SingleCard(
              image: ProfileIcon,
              title: "Profile",
              route: ProfileRoute,
              allowed: loggedIn,
            ),
            SingleCard(
              image: PeopleIcon,
              title: "People",
              route: PeopleRoute,
              allowed: true,
            ),
          ],
        ),
      ],
    );
  }
}

class SingleCard extends StatelessWidget {
  const SingleCard({
    required this.image,
    required this.title,
    required this.route,
    required this.allowed,
  });
  final String image;
  final String title;
  final String route;
  final bool allowed;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => allowed
          ? Navigator.pushNamed(context, route)
          : showRequireLogin(context),
      child: Container(
        height: size.height * 0.15,
        width: size.width * 0.40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: cardImageColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              offset: const Offset(1.0, 1.0), //Offset
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Image.asset(
                image,
                width: 45.0,
                height: 45.0,
                color: Colors.white70,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
