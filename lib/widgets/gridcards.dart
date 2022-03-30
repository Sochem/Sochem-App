import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sochem/utils/constants.dart';

class HomeScreenGrid extends StatefulWidget {
  @override
  State<HomeScreenGrid> createState() => _HomeScreenGridState();
}

class _HomeScreenGridState extends State<HomeScreenGrid> {
  bool guest = true;

  @override
  void initState() {
    super.initState();
    _initialising();
  }

  void _initialising() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      guest = !prefs.getBool('isLoggedIn')!;
    });
  }

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
                route: '/feed',
                login: true,
              ),
              SingleCard(
                image: CloudIcon,
                title: "Cloud",
                route: '/cloud',
                login: !guest,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleCard(
                image: ForumIcon,
                title: "Forum",
                route: '/cloud',
                login: !guest,
              ),
              SingleCard(
                image: GroupIcon,
                title: "Groups",
                route: '/group',
                login: !guest,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleCard(
                image: ProfileIcon,
                title: "Profile",
                route: '/profile',
                login: !guest,
              ),
              SingleCard(
                image: PeopleIcon,
                title: "People",
                route: '/people',
                login: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SingleCard extends StatelessWidget {
  const SingleCard(
      {required this.image,
      required this.title,
      required this.route,
      required this.login});
  final String image;
  final String title;
  final String route;
  final bool login;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => login
          ? Navigator.pushNamed(
              context,
              route,
            )
          : ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 2),
                content: Text(
                  "You need to be signed in with your institute ID",
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Color(0xFFE8F1F8).withOpacity(0.8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                behavior: SnackBarBehavior.floating,
                elevation: 5,
              ),
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
