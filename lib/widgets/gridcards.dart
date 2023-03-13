import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sochem/utils/constants.dart';

import '../utils/dialog.dart';

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
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     SingleCard(
        //       image: FeedIcon,
        //       title: "Feed",
        //       route: FeedRoute,
        //       allowed: true,
        //     ),
        //     SingleCard(
        //       image: CloudIcon,
        //       title: "Cloud",
        //       route: CloudRoute,
        //       allowed: loggedIn,
        //     ),
        //  SingleCard(
        //       image: ProfileIcon,
        //       title: "Profile",
        //       route: ProfileRoute,
        //       allowed: loggedIn,
        //     ),
        //   ],
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SingleCard(
              image: OsmozeIcon,
              title: "Osmoze",
              route: ForumRoute,
              allowed: loggedIn,
            ),
            SingleCard(
              image: EventsIcon,
              title: "Events",
              route: CloudRoute,
              allowed: loggedIn,
            ),
          ],
        ),
        Text(" "),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SingleCard(
              image: FamilyIcon,
              title: "Family",
              route: PeopleRoute,
              allowed: true,
            ),
            SingleCard(
              image: HouseCupIcon,
              title: "House Cup",
              route: GroupRoute,
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
      onTap: () =>
          allowed ? Navigator.pushNamed(context, route) : signinDialog(context),
      child: Container(
        height: size.height * 0.23,
        width: size.width * 0.40,
        decoration: BoxDecoration(
          color: Color.fromRGBO(31, 36, 54, 1),
          borderRadius: BorderRadius.circular(15),
          // boxShadow: [
          //   BoxShadow(
          //     offset: const Offset(1.0, 1.0), //Offset
          //     blurRadius: 5.0,
          //   ),
          // ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Image.asset(
                image,
                width: 170.0,
                height: 120.0,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(149, 204, 255, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
