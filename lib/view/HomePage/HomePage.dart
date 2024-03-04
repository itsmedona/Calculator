import 'package:calc/view/Button/Buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import '../Button/customButtom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final buttonele = Buttons.buttonele;
  String Input = "";
  String Output = "";

  void Resetdisplay() {
    setState(() {
      Input = "";
      Output = "";
    });
  }

  void evaluate() {
    //if last is operator then dont do anything
    String lastchar = Input[Input.length - 1];
    if (!Checkoperator(lastchar)) {
      String eval = Input;
      eval = eval.replaceAll('x', '*');
      Parser parserobj = Parser();

      Expression expobj = parserobj.parse(eval);
      ContextModel cm = ContextModel();

      double evalres = expobj.evaluate(EvaluationType.REAL, cm);
      setState(() {
        //to show decimal if double other wise not
        if (evalres == evalres.toInt()) {
          Output = evalres.toInt().toString();
        } else {
          Output = evalres.toString();
        }
      });
    }
  }

  bool Checkoperator(String n) {
    if (n == "/" || n == "x" || n == "-" || n == "+" || n == "=") {
      return true;
    } else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
      ),
      body: Column(children: [
        Container(
          color: Colors.black,
          width: double.infinity,
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                height: 65,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  children: [
                    Text(
                      Input,
                      style: TextStyle(fontSize: 44, color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                Output,
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
        Expanded(
            flex: 2,
            child: Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: buttonele.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return CustomButton(
                          tap: () {
                            Resetdisplay();
                          },
                          colour: Color(0xFF9EA3A7),
                          text: buttonele[index],
                          textColor: Colors.black,
                        );
                      } else if (index == 1) {
                        return CustomButton(
                          tap: () {
                            setState(() {
                              Input = Input + buttonele[index];
                            });
                          },
                          colour: Color(0xFF9EA3A7),
                          text: buttonele[index],
                          textColor: Colors.black,
                        );
                      } else if (index == 2) {
                        return CustomButton(
                          tap: () {
                            setState(() {
                              // when length becomes zero then dont dont delete data
                              if (Input.length != 0)
                                Input = Input.substring(0, (Input.length - 1));
                            });
                          },
                          colour: Color(0xFF9EA3A7),
                          text: buttonele[index],
                          textColor: Colors.black,
                        );
                      } else if (index == 19) {
                        return CustomButton(
                          tap: () {
                            evaluate();
                          },
                          colour: Color(0xFF9EA3A7),
                          text: buttonele[index],
                          textColor: Colors.black,
                        );
                      } else {
                        return CustomButton(
                          tap: () {
                            if (Output == '') {
                              setState(() {
                                Input += buttonele[index];
                              });
                            } else {
                              if (Checkoperator(buttonele[index])) {
                                Input = Output + buttonele[index];
                                Output = '';
                              } else {
                                Input = '';
                                Output = '';
                                Input += buttonele[index];
                              }

                              setState(() {});
                            }
                          },
                          colour: Checkoperator(buttonele[index])
                              ? Color(0xFFFE9000)
                              : Color(0xFF333333),
                          text: buttonele[index],
                          textColor: Checkoperator(buttonele[index])
                              ? Colors.black
                              : Colors.white,
                        );
                      }
                    })))
      ]),
    );
  }
}
