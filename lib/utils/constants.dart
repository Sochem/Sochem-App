import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Images ->
const String SochemIcon = "assets/sochem.png";
const String BackIcon = "assets/back.png";
const String ExampleProfile = "assets/sampleprofile.jpeg";
const String BellIcon = "assets/bell.png";
const String MenuIcon = "assets/menu.png";
const String FeedIcon = "assets/feed.png";
const String CloudIcon = "assets/cloud.png";
const String ForumIcon = "assets/forum.png";
const String GroupIcon = "assets/group.png";
const String ProfileIcon = "assets/profile.png";
const String PeopleIcon = "assets/people.png";
const String Slideimg1 = "assets/slider/img1.png";
const String Slideimg2 = "assets/slider/img2.png";
const String Slideimg3 = "assets/slider/img3.png";

// Colors Used ->
const kPrimaryColor = Color(0xFF3449c0);
const kBackgroundColor = Color(0xFFd6e0f9);
const cardImageColor = Color(0xFF6282d3);
const highlighted = Color.fromRGBO(136, 144, 178, 1);
const unhighlighted = Color.fromRGBO(206, 209, 223, 1);
const Color tri1 = Color.fromARGB(255, 58, 110, 196);
const Color tri2 = Color.fromARGB(255, 86, 134, 182);
const Color tri3 = Color.fromARGB(255, 64, 99, 141);
const Color tri4 = Color.fromARGB(255, 58, 95, 176);
var blue1 = new Color.fromRGBO(22, 71, 119, 1);
var blue2 = new Color.fromRGBO(24, 134, 191, 1);
var blue3 = new Color.fromRGBO(39, 88, 124, 1);

// Route names ->
const String AppRoute = '/app';
const String FeedRoute = '/feed';
const String CloudRoute = '/cloud';
const String PeopleRoute = '/people';
const String GroupRoute = '/group';
const String NotifRoute = '/notif';
const String LoginRoute = '/login';
const String ProfileRoute = '/profile';

// Shared Prefs & Environment variables ->
const String AppVersion = 'app_version';
const String WebClientId = 'web_client_id';
const String GuestToken = 'guest_token';

final String isGuest = "guestLogIn";
final String isLoggedIn = "logIn";
final String hasOnboarded = "Notyet";
final String lastNotifId = "last_notif_id";
late String djangoToken;
String userEmail = '';
