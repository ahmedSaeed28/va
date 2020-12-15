import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:va/contstants/StringConstants.dart';
import 'package:va/features/home/HomeScreen.dart';
import 'CommonImports.dart';

class Application extends StatefulWidget {
  @override
  ApplicationState createState() {
    return ApplicationState();
  }
}

class ApplicationState extends State<Application> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider<AppConfig>(
          create: (_) => AppConfig.shared,
          child: HomeScreen()
      ),
    );
  }
}
