import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hepius/models/user.dart';
import 'package:hepius/providers/auth.dart';
import 'package:hepius/providers/consult.dart';
import 'package:hepius/providers/drug_provider.dart';
import 'package:hepius/providers/favorites.dart';
import 'package:hepius/providers/guidelines.dart';
import 'package:hepius/providers/patient_provider.dart';
import 'package:hepius/providers/pharmacy_provider.dart';
import 'package:hepius/providers/prescription_provider.dart';
import 'package:hepius/switcher.dart';
import 'package:hepius/ui/auth/login.dart';
import 'package:hepius/ui/auth/sign_up.dart';
import 'package:hepius/ui/dashboard.dart';
import 'package:hepius/ui/welcome.dart';
import 'package:hepius/util/shared_preference.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Directory dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<User> getUserData() => UserPreferences().getUser();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ConsultProvider()),
        ChangeNotifierProvider(create: (_) => DrugProvider()),
        ChangeNotifierProvider(create: (_) => PrescriptionProvider()),
        ChangeNotifierProvider(create: (_) => PatientProvider()),
        ChangeNotifierProvider(create: (_) => GuidelinesProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => PharmacyProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: FutureBuilder(
              future: getUserData(),
              builder: (context, snapshot) {
                // print("object ${snapshot.data}");
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else if (snapshot.data.name == null)
                      return Login();
                    else
                      Switcher(user: snapshot.data);
                    return Switcher(user: snapshot.data);
                }
              }),
          routes: {
            '/dashboard': (context) => DashBoard(),
            '/login': (context) => Login(),
            '/register': (context) => Register(),
            'welcome': (context) => Welcome()
          }),
    );
  }
}
