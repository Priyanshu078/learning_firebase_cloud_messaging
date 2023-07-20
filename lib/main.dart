import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notifications_firebase/firebase_code.dart';
import 'package:notifications_firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextButton(
              onPressed: () async {
                var dio = Dio();
                await dio.post("https://fcm.googleapis.com/fcm/send",
                    options: Options(
                      headers: {
                        "Content-Type": "application/json",
                        "Authorization":
                            "key=AAAAf85OzIE:APA91bH2CPA7wn4pZ35SMj_8XZOo-h0zBBKxGwsg0nNqUE4xn3SGAzSuKUdI0SeZjP_8Qjye2fHsuYwz3GDyVWnpiUz-8cn7-MXJDHlxUePcDzuq6H1ZBO2ee_y1iM_IWxYio5AnS70E"
                      },
                    ),
                    data: {
                      "notification": {
                        "title": "Priyanshu paliwal liked you image",
                        "image":
                            "https://firebase.google.com/images/social.png",
                        "body": "You are in a beach",
                        "message": "Hello how are you?"
                      },
                      "to":
                          "dQiJ4TqPSvSBh8VhHXc6fv:APA91bHgdlIHIydVb8tqJOwM22mnafd1Vq4wQFvuMVZBo51yqObi5mXCCUYQ109HyhP8e-mqMM_t9bUAlNYvAkfQYEIXKA7E5_wNe91oCgLHzn7s3cWhjEuU1lU2wcKCtMwHt0UXwmaM"
                    });
              },
              child: const Text("Send Notification"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
