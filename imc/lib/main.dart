import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CALCULO IMC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'CALCULO IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

var _ctrPeso = new TextEditingController();
var _ctrAltura = new  TextEditingController();
String _retorno = '';
Color _corTexto = Colors.green;
GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: limparCampos),
        ],
        title: Center(child: Text(widget.title)),
      ),
      body: ListView(
        children: <Widget>[
          Form(
          key: _formKey,  
          child: Column(
            children: <Widget>[
             
              Center(
                
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                  size: 120,
                )
              ),
              
              Padding(
                padding: EdgeInsets.only(left: 50, top: 20, right: 50, bottom: 20),
                child: TextFormField(                
                  controller: _ctrPeso,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText:'Peso (Kg)',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25,
                    ),
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Informe seu Peso';
                    }
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 50, top: 20, right: 50, bottom: 20),
                child: TextFormField(                
                  controller: _ctrAltura,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText:'Altura (Cm)',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25,
                    ),
                  ),
                 validator: (value){
                    if(value.isEmpty){
                      return 'Informe seu Peso';
                    }
                 }, 
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 50, top: 20, right: 50, bottom: 20),
                child: Container(                
                
                width: MediaQuery.of(context).size.width,
                
                decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      
                      borderRadius: BorderRadius.circular(50)),
                
                child: FlatButton(
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      calculaIMC();
                    }
                  },
                  child: Text( 'CALCULAR' ),
                  textColor: Colors.white,
                )
                )
              ),
      
              Center(
                child: Text(
                  _retorno,
                  style: TextStyle(
                    fontSize:30,
                    fontWeight: FontWeight.bold,
                    color: _corTexto,
                  )
                )
              ),            
            
            ],
          )
          )
        ],
      ),
      
    );
  }


  limparCampos(){
    setState(() {
      
      _formKey.currentState.reset(); //da um reset em todo o Form
      
      _ctrPeso.clear();

      _ctrAltura = new TextEditingController();

      //2 maneiras de limpar o campo, via função clear() e Objeto

      _retorno = '';
    });
  }

 calculaIMC(){
   //IMC = Peso/Altura^2

   var peso = double.parse(_ctrPeso.text);
   var altura = double.parse(_ctrAltura.text) / 100;
   var resultado = peso / (altura * altura);

   setState(() {
     if(resultado < 18.5){
       _retorno = 'MAGRO';
     }else if(resultado < 25.0){
       _retorno = 'NORMAL';
     }else if(resultado < 30.0){
       _retorno = 'ACIMA DO PESO';
     }else{
       _retorno = 'PROCURE UM MÉDICO, OBESIDADE GRAVE';
     }
     
   });

 }


}
