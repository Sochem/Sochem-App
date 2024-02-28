import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sochem/utils/constants.dart';

import '../utils/dialog.dart';

class HomeScreenBar extends StatefulWidget {
  @override
  State<HomeScreenBar> createState() => _HomeScreenBarState();
}

class _HomeScreenBarState extends State<HomeScreenBar> {
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
      children: [
        Divider(
          color: Color.fromRGBO(42, 107, 255, 1),
          thickness: 0.3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BarCard(
              image: HomeIcon,
              title: "Home",
              route: HomeRoute,
              allowed: true,
            ),
            BarCard(
              image: eventIcon,
              title: "Events",
              route: EventsRoute,
              allowed: true,
            ),
            BarCard(
              image: VaultIcon,
              title: "Vault",
              route: CloudRoute,
              allowed: loggedIn,
            ),
            BarCard(
              image: EventsIcon,
              title: "You",
              route: ProfileRoute,
              allowed: loggedIn,
            ),
          ],
        ),
      ],
    );
  }
}

class BarCard extends StatelessWidget {
  const BarCard({
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
    final currentRouteName = ModalRoute.of(context)?.settings.name;
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () =>
          allowed ? Navigator.pushNamed(context, route) : signinDialog(context),
      child: Container(
        height: 41,
        width: 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Image.asset(
                image,
                color: (currentRouteName == route)
                    ? Color.fromRGBO(83, 141, 255, 1)
                    : Colors.white,
                width: 30.0,
                height: 24.0,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              title,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: (currentRouteName == route)
                      ? Color.fromRGBO(83, 141, 255, 1)
                      : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
