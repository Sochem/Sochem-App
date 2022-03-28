import 'package:flutter/material.dart';
import 'package:sochem/screen/groups.dart';
import 'package:sochem/screen/feed.dart';
import 'package:sochem/screen/cloud.dart';
import 'package:sochem/screen/notif.dart';
import 'package:sochem/screen/people.dart';
import 'package:sochem/screen/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/services.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(MaterialApp(
    title: "Sochem App",
    initialRoute: '/app',
    routes: <String, WidgetBuilder>{
      '/app': (context) => App(),
      '/feed': (context) => FeedScreen(),
      '/cloud': (context) => CloudPage(),
      '/people': (context) => PeoplePage(),
      '/group': (context) => GroupPage(),
      '/notif': (context) => Notif(),
    },
  ));
}

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [App] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  // final Future<int> _initialization = Future.delayed(Duration(seconds: 2));

  Future<int> _demoInitializationFunction() async {
    await Future.delayed(Duration(seconds: 2));
    return 1;
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
    // return LoginPage();
    return Scaffold(
      body: FutureBuilder(
        // Initialize FlutterFire:
        future: _demoInitializationFunction(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return SomethingWentWrong();
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return SplashScreen();
            //return BoardingPage();
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Loading();
        },
      ),
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Something Went Wrong")),
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
