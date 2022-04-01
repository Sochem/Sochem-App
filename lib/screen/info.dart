import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sochem/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: <Widget>[
                  Image.asset(SochemIcon, height: 220),
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'So',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: Color(0xFF174374),
                              fontSize: 50,
                              fontWeight: FontWeight.w800,

                              // letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: 'Chem',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF1894d0)
                                // letterSpacing: 1.2,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Who we are",
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,

                        // letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Divider(),
                  Text(
                    "The Society of Chemical Engineers, a.k.a SoChem, is a professional organization of chemical engineers. SoChem is a society run by the department students for the department's students.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "What we do",
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,

                        // letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Divider(),
                  Text(
                    "SoChem works hard to ensure that every student in the department gets the most out of their experience at IIT(BHU) Varanasi. SoChem is there to help with everything from lavish festival dinners to essential job searches. We are a very active society regarding social skill development and industrial exposure.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "App Development Team",
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  AppDevTile(
                    pic: 'assets/arjun.jpg',
                    name: 'Arjun Gupta',
                    designation: 'Technical Team Lead',
                    fb: 'https://www.facebook.com/arjun.manas.1',
                    insta: 'https://www.instagram.com/arjupta/',
                    linkedin: 'https://www.linkedin.com/in/arjupta/',
                  ),
                  AppDevTile(
                    pic: 'assets/aditya.jpeg',
                    name: 'Aditya Kumar Singh',
                    designation: 'Technical Executive',
                    fb: 'https://www.facebook.com/profile.php?id=100004271555775',
                    insta: 'https://www.instagram.com/itsadityaksingh/',
                    linkedin: 'https://www.linkedin.com/in/itsadityaksingh/',
                  ),
                  AppDevTile(
                    pic: 'assets/devansh.jpeg',
                    name: 'Devansh Mishra',
                    designation: 'Technical Executive',
                    fb: 'https://www.facebook.com/profile.php?id=100008164635361',
                    insta: 'https://www.instagram.com/keshavmishra_2612/',
                    linkedin:
                        'https://www.linkedin.com/in/devansh-mishra-3a6138203/',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppDevTile extends StatelessWidget {
  const AppDevTile(
      {required this.pic,
      required this.name,
      required this.designation,
      required this.fb,
      required this.insta,
      required this.linkedin});
  final String designation;
  final String name;
  final String fb;
  final String insta;
  final String linkedin;
  final String pic;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Container(
        height: 280,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(pic),
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  name,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(),
                ),
                Text(
                  designation,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () => launch(insta),
                      icon: Icon(
                        FontAwesomeIcons.instagram,
                        color: Colors.black,
                        size: 25.0,
                      ),
                    ),
                    IconButton(
                      onPressed: () => launch(linkedin),
                      icon: Icon(
                        FontAwesomeIcons.linkedin,
                        color: Colors.black,
                        size: 25.0,
                      ),
                    ),
                    IconButton(
                      onPressed: () => launch(fb),
                      icon: Icon(
                        FontAwesomeIcons.facebook,
                        color: Colors.black,
                        size: 25.0,
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFECDF), kBackgroundColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: const Offset(1.0, 1.0), //Offset
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}
