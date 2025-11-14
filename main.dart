import 'package:flutter/material.dart';
void main() => runApp(MaterialApp(home: BMICalculator()));
class BMICalculator extends StatefulWidget {
  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}
class _BMICalculatorState extends State<BMICalculator> {
  final w = TextEditingController();
  final h = TextEditingController();
  String res = "";
  void calcBMI() {
    double? weight = double.tryParse(w.text);
    double? height = double.tryParse(h.text);
    if (weight != null && height != null && height > 0) {
      double bmi = weight / ((height / 100) * (height / 100));
      String status = "";
      if (bmi < 18.5)
        status = "Underweight";
      else if (bmi < 25)
        status = "Normal";
      else if (bmi < 30)
        status = "Overweight";
      else
        status = "Obese";
      setState(() {
        res = "BMI = ${bmi.toStringAsFixed(2)} ($status)";
      });
    } else {
      setState(() {
        res = "Enter valid numbers";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BMI Calculator")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: w, decoration: InputDecoration(labelText: "Weight (kg)")),
            TextField(controller: h, decoration: InputDecoration(labelText: "Height (cm)")),
            ElevatedButton(onPressed: calcBMI, child: Text("Calculate")),
            Text(res, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
