import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: NumberListApp()));
}

class NumberListApp extends StatefulWidget {
  const NumberListApp({super.key});

  @override
  State<NumberListApp> createState() => _NumberListAppState();
}

class _NumberListAppState extends State<NumberListApp> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  final List<int> numbers = [];

  void _addNumber() {
    if (_formKey.currentState!.validate()) {
      int value = int.parse(_controller.text);
      setState(() {
        numbers.add(value); // append to the list
      });
      _controller.clear(); // clear input field
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Number List"), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Enter number",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Enter a number";
                        if (int.tryParse(value) == null) return "Enter a valid number";
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(onPressed: _addNumber, child: const Text("Add"))
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: numbers.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(numbers[index].toString()),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
