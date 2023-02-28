import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        baseColor: Colors.grey.shade300,
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      // ignore: prefer_const_constructors
      darkTheme: NeumorphicThemeData(
        baseColor: Color(0xFF292D32),
        lightSource: LightSource.topLeft,
        shadowDarkColor: Colors.black.withOpacity(0.4),
        intensity: 0.6,
        //variantColor: Colors.white.withOpacity(0.1),
        shadowLightColor: Colors.white.withOpacity(0.3),
        depth: 10,
      ),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 48.0;
  double resultFontSize = 58.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
      } else if (buttonText == "<") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll("x", "*");
        expression = expression.replaceAll("÷", "/");
        if(expression.contains("%")){
            expression = expression.replaceRange(0, null, "0." + expression);
            expression = expression.replaceAll("%", "*");
            //expression = "yes";
        }
        try {
          
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
        if(result.endsWith(".0")){
          result = result.substring(0, result.length - 2);
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  //Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
  /* return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      //color: buttonColor,
      margin: EdgeInsets.all(5),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: buttonColor,
          shape: CircleBorder(
            side: BorderSide(
              color: Colors.black,
              width: 1.0,
              style: BorderStyle.solid,
            )
          ),
          textStyle: const TextStyle(fontSize: 30.0),
          padding: EdgeInsets.all(16.0),
        ),
        onPressed: () => buttonPressed(buttonText),
        child: Text(buttonText, style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.normal, 
          color: Colors.white
        ),)),
    );
  } */

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      margin: EdgeInsets.all(5),
      child: NeumorphicButton(
        style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            boxShape: NeumorphicBoxShape.circle(),
            //depth: 8,
            //intensity: 0.3,
            color: _buttonColors(context),
            //lightSource: LightSource.topLeft
            ),
        //padding: EdgeInsets.only(top: 20),
        onPressed: () {
          final player = AudioPlayer();
          player.play(AssetSource('assets/button.mp3'));
          buttonPressed(buttonText);
          },
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,  
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ Text(
            buttonText,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: buttonColor,
          ))],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Simple Calculator")),
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 35),
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 10, top: 0, right: 0, bottom: 0),
          child: NeumorphicButton(
              onPressed: () {
                NeumorphicTheme.of(context)!.themeMode =
                    NeumorphicTheme.isUsingDark(context)
                        ? ThemeMode.light
                        : ThemeMode.dark;
              },
              style: NeumorphicStyle(
                  color: _buttonColors(context),
                  shape: NeumorphicShape.concave,
                  depth: 8,
                  intensity: 0.6,
                  boxShape: NeumorphicBoxShape.circle(),
                  lightSource: LightSource.topLeft),
              child: NeumorphicIcon(
                Icons.wb_sunny,
                size: 25,
                style: NeumorphicStyle(color: _textColor(context)),
              )),
        ),
        Container(
          margin: EdgeInsets.only(top: 0),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 0),
          child: Text(
            equation,
            style: TextStyle(color: _textColor(context), fontSize: equationFontSize),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(left: 10, top: 50, right: 10, bottom: 0),
          child: Text(
            result,
            style: TextStyle(color: _textColor(context), fontSize: resultFontSize),
          ),
        ),


        Expanded(
          child: Divider(
            color: _buttonColors(context),
          ),
        ),


        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 30),
              width: MediaQuery.of(context).size.width * .75,
              child: Table(
                children: [
                  TableRow(children: [
                    buildButton("AC", 1, Colors.grey),
                    buildButton("<", 1, Colors.grey),
                    buildButton("%", 1, Colors.grey),
                  ]),
                  TableRow(children: [
                    buildButton("7", 1, _textColor(context)),
                    buildButton("8", 1, _textColor(context)),
                    buildButton("9", 1, _textColor(context))
                  ]),
                  TableRow(children: [
                    buildButton("6", 1, _textColor(context)),
                    buildButton("5", 1, _textColor(context)),
                    buildButton("4", 1, _textColor(context))
                  ]),
                  TableRow(children: [
                    buildButton("3", 1, _textColor(context)),
                    buildButton("2", 1, _textColor(context)),
                    buildButton("1", 1, _textColor(context))
                  ]),
                  TableRow(
                    children: [
                    buildButton("0", 1, _textColor(context)),
                    buildButton("00", 1, _textColor(context)),
                    buildButton(".", 1, _textColor(context)),
                  ])
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              width: MediaQuery.of(context).size.width * .25,
              child: Table(
                children: [
                  TableRow(
                    children: [
                      buildButton("÷", 1, Colors.orange),
                    ],
                  ),
                  TableRow(
                    children: [
                      buildButton("+", 1, Colors.orange),
                    ],
                  ),
                  TableRow(
                    children: [
                      buildButton("-", 1, Colors.orange),
                    ],
                  ),
                  TableRow(
                    children: [
                      buildButton("x", 1, Colors.orange),
                    ],
                  ),
                  TableRow(
                    children: [
                      buildButton("=", 1, Colors.orange),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ]),
    );
    // ignore: dead_code
    
    
  }
  Color? _buttonColors(BuildContext context) {
      final theme = NeumorphicTheme.of(context);
      if (theme!.isUsingDark) {
        return theme.current?.baseColor;
      } else {
        return null;
      }
    }

    Color _textColor(BuildContext context){
      if(NeumorphicTheme.isUsingDark(context)){
        return Colors.grey.shade300;
      }else{
        return Colors.grey.shade800;
      }
    }
}
      