import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sochem/utils/constants.dart';

class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: <Widget>[
                  Image.asset("assets/sochem.png", height: 220),
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

                        // letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  AppDevTile(
                    pic: 'assets/arjun.jpg',
                    name: 'Arjun Gupta',
                    designation: 'Technical Team Lead',
                    fb: '',
                    insta: '',
                    linkedin: '',
                  ),
                  AppDevTile(
                    pic: 'assets/aditya.jpeg',
                    name: 'Aditya Kumar Singh',
                    designation: 'Technical Executive',
                    fb: '',
                    insta: '',
                    linkedin: '',
                  ),
                  AppDevTile(
                    pic: 'assets/devansh.jpeg',
                    name: 'Devansh Mishra',
                    designation: 'Technical Executive',
                    fb: '',
                    insta: '',
                    linkedin: '',
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  child: CircleAvatar(
                      radius: 30,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(300),
                          child: Image.asset(pic))),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
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
                  Divider(),
                  Text(
                    designation,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: null,
                          icon: Icon(FontAwesomeIcons.instagram,
                              color: Colors.white, size: 25.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: null,
                          icon: Icon(FontAwesomeIcons.linkedin,
                              color: Colors.white, size: 25.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: null,
                          icon: Icon(FontAwesomeIcons.facebook,
                              color: Colors.white, size: 25.0),
                        ),
                      )
                    ],
                  ),
                ],
              ),
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
