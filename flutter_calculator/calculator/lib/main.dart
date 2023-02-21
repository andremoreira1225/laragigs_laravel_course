import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primaryColor: Colors.blue),
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

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "AC"){
        equation = "0";
        result = "0";
      }else if(buttonText == "←"){
        equation = equation.substring(0, equation.length-1);
        if(equation == ""){
          equation = "0";
        }
      }else if(buttonText == "="){
        expression = equation;
        expression = expression.replaceAll("x", "*");
        expression = expression.replaceAll("÷", "/");
        

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          
        }catch(e){  
          result = "Error";
        }
      }else{
        if(equation == "0"){
          equation = buttonText;
        }else{
          equation = equation + buttonText;
        } 
      }
    });
  }


  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Simple Calculator")),
      backgroundColor: Colors.black,
      body: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 40),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(left: 10, top: 40, right: 10, bottom: 0),
          child: Text(
            equation,
            style: TextStyle(color: Colors.white,fontSize: equationFontSize),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(left: 10, top: 50, right: 10, bottom: 0),
          child: Text(
            result,
            style: TextStyle(color: Colors.white, fontSize: resultFontSize),
          ),
        ),
        Expanded(
          child: Divider(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .75,
              child: Table(
                children: [
                  TableRow(
                    children: [
                      buildButton("AC",1, Colors.grey),
                      buildButton("←",1, Colors.grey),
                      buildButton("%",1, Colors.grey),
                      
                    ]
                  ),
                  TableRow(
                    children: [
                      buildButton("7",1, Colors.grey.shade800),
                      buildButton("8",1, Colors.grey.shade800),
                      buildButton("9",1, Colors.grey.shade800)
                    ]
                  ),
                  TableRow(
                    children: [
                      buildButton("6",1, Colors.grey.shade800),
                      buildButton("5",1, Colors.grey.shade800),
                      buildButton("4",1, Colors.grey.shade800)
                    ]
                  ),
                  TableRow(
                    children: [
                      buildButton("3",1, Colors.grey.shade800),
                      buildButton("2",1, Colors.grey.shade800),
                      buildButton("1",1, Colors.grey.shade800)
                    ]
                  ),
                  TableRow(
                    children: [
                      buildButton(".",1, Colors.grey.shade800),
                      buildButton("0",1, Colors.grey.shade800),
                      buildButton("00",1, Colors.grey.shade800)
                    ]
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .25,
              child: Table(
                children: [
                  TableRow(
                    children: [
                      buildButton("÷",1, Colors.orange),
                    ],                  
                  ),
                  TableRow(
                    children: [
                      buildButton("+",1, Colors.orange),
                    ],                  
                  ),
                  TableRow(
                    children: [
                      buildButton("-",1, Colors.orange),
                    ],                  
                  ),
                  TableRow(
                    children: [
                      buildButton("x",1, Colors.orange),
                    ],                  
                  ),
                  TableRow(
                    children: [
                      buildButton("=",1, Colors.orange),
                    ],                  
                  ),
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
