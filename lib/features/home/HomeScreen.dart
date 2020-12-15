import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:va/base/app/CommonImports.dart';
import 'package:va/utilities/locationHelper.dart';
import 'package:va/widgets/ButtonWidget.dart';
import 'package:va/widgets/EquationWidget.dart';
import 'package:va/widgets/PaneWidget.dart';

void main() => runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen()
    )
);

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{

  final TextEditingController _firstNumberController =  TextEditingController();
  final TextEditingController _secondNumberController =  TextEditingController();
  final TextEditingController _delayController =  TextEditingController();
  final key = new GlobalKey<ScaffoldState>();

  initState() {
    super.initState();
    AppConfig.shared.addListener(() => setState(() {}));
  }

  Future<void> _getCurrentLocation() async {
    await LocationHelper.getCurrentLocation().then((value) =>
        key.currentState.showSnackBar(SnackBar(
          content: Text(
            value.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: blueGrayColor
            ),
          ),
        ))
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    width = width - 50;

    return Scaffold(
      key: key,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: greenColor,
        title: Text(appName),
      ),
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                PaneWidget(
                  title: pendingEquations,
                  list: ListView.builder(
                    itemCount: AppConfig.shared.getPendingEquations().length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          AppConfig.shared.getPendingEquations()[i].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: blueGrayColor
                          ),
                        ),
                      );
                    },
                  ),
                  width: width/2,
                ),
                PaneWidget(
                  title: finishedEquations,
                  list: ListView.builder(
                    itemCount: AppConfig.shared.getFinishedEquations().length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          AppConfig.shared.getFinishedEquations()[i].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: blueGrayColor
                          ),
                        ),
                      );
                    },
                  ),
                  width: width/2,
                )
              ],
            ),
            EquationWidget(
              firstNumberController: _firstNumberController,
              secondNumberController: _secondNumberController,
              delayController: _delayController,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonWidget(
                text: calculate,
                function: (){
                  Equation equation = Equation.origin(
                      int.parse(_firstNumberController.text),
                      int.parse(_secondNumberController.text),
                      AppConfig.shared.getCurrentOperationType(),
                      DateTime.now().add(Duration(seconds: int.parse(_delayController.text))).toString());
                  AppConfig.shared.addEquation(equation);
                  _firstNumberController.text = "";
                  _secondNumberController.text = "";
                  _delayController.text = "";
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonWidget(
                text: getCurrentLocation,
                function: (){
                  setState(() {
                    _getCurrentLocation();
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
