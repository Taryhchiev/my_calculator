import 'package:flutter/material.dart';
import 'package:my_calculator/buttons.dart';
import 'package:math_expressions/math_expressions.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var userQuestion = '';
  var userAnswer = '';

  final myTetxStyle = TextStyle(fontSize: 30, color: Colors.deepPurple[900]);

  final List<String> buttons = [
    'C', 'DEL', '%', '/',
    '9', '8', '7', 'x',
    '6', '5', '4', '-',
    '3', '2', '1', '+',
    '0', '.', 'ANS', '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 50,),
                  Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Text(userQuestion, style: TextStyle(fontSize: 20),),
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(userAnswer, style: TextStyle(fontSize: 20),),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {

                    if (index == 0) {
                      return MyButton(
                        buttenTapped: () {
                          setState(() {
                            userQuestion = '';
                            userAnswer = '';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.green,
                        textcolor: Colors.white,
                      );
                    }

                    else if (index == 1) {
                      return MyButton(
                        buttenTapped: () {
                          setState (() {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);
                           });
                          },
                        buttonText: buttons[index],
                        color: Colors.red,
                        textcolor: Colors.white,
                      );
                    }
                    else if (index == buttons.length-1) {
                      return MyButton(
                        buttenTapped: () {
                          setState (() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.deepPurple,
                        textcolor: Colors.white,
                      );
                    }

                     else {
                      return MyButton(
                        buttenTapped: (){
                          setState(() {
                            userQuestion += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.deepPurple
                            : Colors.grey,
                        textcolor: isOperator(buttons[index])
                            ? Colors.lightGreenAccent
                            : Colors.black,
                      );
                    }
                  }),
            ),
          ),
        ],
      ),

    );
  }
  bool isOperator(String x){
    if(x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }
  void equalPressed () {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');

     Parser p = Parser();
     Expression exp = p.parse(finalQuestion);
     ContextModel cm = ContextModel();
     double eval = exp.evaluate(EvaluationType.REAL, cm);

     userAnswer = eval.toString();
  }
}