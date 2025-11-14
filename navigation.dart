main.dart

import 'package:flutter/material.dart';
import 'package:samp/details.dart';
import 'package:samp/resultscreen.dart';
void main(){
  runApp(MaterialApp(
    title: "home screen",
    initialRoute: '/',
    routes: {
      '/':(context)=>Details(),
      '/res':(context)=>result(),
    },
  ));
}


details.dart
import 'package:flutter/material.dart';
import 'package:samp/budget.dart';

class Details extends StatefulWidget{
  Details({super.key});
  State<Details> createState()=>_DetailsState();
}

class _DetailsState extends State<Details>{
  final _formKey=GlobalKey<FormState>();
  final _n=TextEditingController();
  final _i=TextEditingController();
  final _r=TextEditingController();
  final _e=TextEditingController();

  void _cal(){
    if(_formKey.currentState!.validate()){
      final dat=Budget(name: _n.text, 
                        income: double.parse(_i.text), 
                        rent: double.parse(_r.text), 
                        expense: double.parse(_e.text));
      Navigator.pushNamed(
        context,
        '/res',
        arguments: dat
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("enter detail",style: TextStyle(color:Colors.pink,)),
        backgroundColor: Colors.black,
      ),
      body:Form(
        key:_formKey,
        child: Column(
          children: [
            SizedBox(height: 30,),
            TextFormField(
              controller: _n,
              decoration:const InputDecoration(labelText:"enter name",border:OutlineInputBorder()),
              validator: (value){
                if(value==null||value.isEmpty){
                  return "please enter";
                }
                else{
                  return null;
                }
              },
            ),
            SizedBox(height: 30,),
            TextFormField(
              controller: _i,
              decoration: const InputDecoration(labelText: "enter income",border: OutlineInputBorder()),
              validator: (value){
                if(value==null||value.isEmpty){
                  return "please enter";
                }
                else{
                  return null;
                }
              },
            ),
            SizedBox(height: 30,),
            TextFormField(
              controller: _r,
              decoration: const InputDecoration(labelText: "enter rent",border: OutlineInputBorder()),
              validator: (value){
                if(value==null||value.isEmpty){
                  return "please enter";
                }
                else{
                  return null;
                }
              },
            ),
            SizedBox(height: 30,),
            TextFormField(
              controller: _e,
              decoration:const InputDecoration(labelText:"enter other expense",border:OutlineInputBorder()),
              validator: (value){
                if(value==null||value.isEmpty){
                  return "please enter";
                }
                else{
                  return null;
                }
              },
            ),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: _cal, 
            child: Text("submit"))
          ],
        )),
    );
  }
}


resultscreen.dart

import 'package:flutter/material.dart';
import 'package:samp/budget.dart';

class result extends StatelessWidget {
  result({super.key});

  @override
  Widget build(BuildContext context) {
    final dat = ModalRoute.of(context)!.settings.arguments as Budget;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "results",
          style: TextStyle(color: Colors.yellow),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 5,
            child: ListTile(
              title: Text("Welcome"),
              subtitle: Text(dat.name),
            ),
          ),
          Card(
            elevation: 5,
            child: ListTile(
              title: Text("Income"),
              subtitle: Text(dat.income.toString()),
            ),
          ),
          Card(
            elevation: 5,
            child: ListTile(
              title: Text("Rent"),
              subtitle: Text(dat.rent.toString()),
            ),
          ),
          Card(
            elevation: 5,
            child: ListTile(
              title: Text("Expense"),
              subtitle: Text(dat.expense.toString()),
            ),
          ),
          Card(
            elevation: 0,
            child: ListTile(
              title: Text(
                (dat.income - dat.expense - dat.rent) > 0
                    ? "Success"
                    : "Over Spending",
                style: TextStyle(
                  color: (dat.income - dat.expense - dat.rent) > 0
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Back"),
          ),
        ],
      ),
    );
  }
}




budget.dartt


class Budget{
  String name;
  double income;
  double rent;
  double expense;
  Budget({required this.name, required this.income, required this.rent, required this.expense});
}
