import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sochem/models/config.dart';
import 'package:sochem/screen/forum_page.dart';
import 'package:sochem/screen/home_screen.dart';
import 'package:sochem/screen/info.dart';
import 'package:sochem/screen/login_page.dart';
import 'package:sochem/screen/groups.dart';
import 'package:sochem/screen/feed.dart';
import 'package:sochem/screen/cloud.dart';
import 'package:sochem/screen/notif.dart';
import 'package:sochem/screen/onboarding_screen.dart';
import 'package:sochem/screen/people.dart';
import 'package:sochem/screen/profile.dart';
import 'package:sochem/screen/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sochem/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sochem/utils/endpoints.dart';
import 'package:sochem/widgets/error_messages.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(MaterialApp(
    title: "Sochem App",
    initialRoute: AppRoute,
    debugShowCheckedModeBanner: false,
    routes: <String, WidgetBuilder>{
      AppRoute: (context) => App(),
      HomeRoute: (context) => HomeScreen(),
      OnboardingRoute: (context) => OnboardingScreen(),
      FeedRoute: (context) => FeedScreen(),
      CloudRoute: (context) => CloudPage(),
      PeopleRoute: (context) => PeoplePage(),
      GroupRoute: (context) => GroupPage(),
      NotifRoute: (context) => Notif(),
      LoginRoute: (context) => LoginPage(),
      ProfileRoute: (context) => ProfilePage(),
      ForumRoute: (context) => ForumPage(),
      InfoRoute: (context) => Information(),
    },
  ));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late SharedPreferences pref;

  Future<Config> fetchConfig() async {
    var appVersion = dotenv.env[AppVersion]!;
    pref = await SharedPreferences.getInstance();

    if (pref.containsKey(AppVersion)) {
      appVersion = pref.getString(AppVersion)!;
    } else {
      pref.setString(AppVersion, appVersion);
    }

    Config config = Config(appVersion, false, false);
    var response = await http.get(Uri.parse(Endpoints.config));
    if (response.statusCode == 200) {
      config = Config.fromJson(json.decode(response.body));
    }
    return config;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      body: FutureBuilder(
        future: fetchConfig(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error.toString() + " error");
            return SomethingWentWrong();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            var config = snapshot.data as Config;
            var myAppVersion = pref.getString(AppVersion)!;

            if (config.maintenance) {
              return AppUnderMaintenance();
            }

            if (config.update &&
                myAppVersion.compareTo(config.appVersion) < 0) {
              return UpdateYourApp();
            }

            return SplashScreen();
          }

          return Loading();
        },
      ),
    );
  }
}

class UpdateYourApp extends StatelessWidget {
  const UpdateYourApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(SochemIcon),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "We have lauched a new version of our app. Please update!",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: tri1,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class AppUnderMaintenance extends StatelessWidget {
  const AppUnderMaintenance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(SochemIcon),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Sorry for the inconvinience! The app is under maintenance",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: tri1,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
