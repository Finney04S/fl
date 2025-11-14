import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: UserListApp()));
}

class User {
  String name;
  int age;

  User({required this.name, required this.age});
}

class UserListApp extends StatefulWidget {
  const UserListApp({super.key});

  @override
  State<UserListApp> createState() => _UserListAppState();
}

class _UserListAppState extends State<UserListApp> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final List<User> users = [];

  void _addUser() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      int age = int.parse(_ageController.text);

      setState(() {
        users.add(User(name: name, age: age));
      });

      _nameController.clear();
      _ageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User List"), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Enter name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Enter a name";
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Enter age",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Enter age";
                      if (int.tryParse(value) == null) return "Enter a valid number";
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(onPressed: _addUser, child: const Text("Add User")),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(user.name),
                      subtitle: Text("Age: ${user.age}"),
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
