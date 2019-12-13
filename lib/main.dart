import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Container de Pessoas",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _infoText = "Informe seus dados!";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields() {
    setState(() {
      weightController.text = "";
      heightController.text = "";
      _infoText = "Informe seus dados!";
    });
  }

  void _calculate() {
   setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text)/100;
      double imc = weight / (height * height);
      if(imc < 18.6) {
        _infoText = "Abaixo do peso! (${imc.toStringAsPrecision(4)})";
      }
      else if(imc < 24.9) {      
        _infoText = "Dentro do peso ideal! (${imc.toStringAsPrecision(4)})";
      }
      else if(imc < 29.9) {      
        _infoText = "Levemente acima do peso! (${imc.toStringAsPrecision(4)})";
      }
      else if(imc < 34.9) {      
        _infoText = "Obesidade grau I! (${imc.toStringAsPrecision(4)})";
      }
      else if(imc < 39.9) {      
        _infoText = "Obesidade grau II! (${imc.toStringAsPrecision(4)})";
      }
      else {
        _infoText = "Obesidade grau III! (${imc.toStringAsPrecision(4)})";
      }
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),  
            onPressed: _resetFields,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline, size: 120.0, color: Colors.deepPurple),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.deepPurple),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.deepPurple, fontSize: 25.0),
                  controller: weightController,
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira seu peso!";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.deepPurple),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.deepPurple, fontSize: 25.0),
                  controller: heightController,
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira sua altura!";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child:
                      RaisedButton(
                        onPressed: (){
                          if(_formKey.currentState.validate()) {
                             _calculate();
                          }
                        },
                        child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 25.0)),
                        color: Colors.deepPurple,
                      ),
                  ),
                ),
                Text(
                  "$_infoText",
                  style: TextStyle(color: Colors.deepPurple, fontSize: 25.0),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          
        ),
      )
    );
  }
}