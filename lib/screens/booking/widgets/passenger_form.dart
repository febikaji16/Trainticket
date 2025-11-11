import 'package:flutter/material.dart';

class PassengerForm extends StatefulWidget {
  const PassengerForm({super.key});

  @override
  State<PassengerForm> createState() => _PassengerFormState();
}

class _PassengerFormState extends State<PassengerForm> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  int? age;
  String? gender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Name'),
            validator: (value) => value!.isEmpty ? 'Enter name' : null,
            onSaved: (value) => name = value,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Age'),
            keyboardType: TextInputType.number,
            validator: (value) => value!.isEmpty ? 'Enter age' : null,
            onSaved: (value) => age = int.tryParse(value ?? '0'),
          ),
          DropdownButtonFormField<String>(
            initialValue: gender,
            items: ['Male', 'Female', 'Other']
                .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                .toList(),
            onChanged: (val) => setState(() => gender = val),
            decoration: const InputDecoration(labelText: 'Gender'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Navigator.pop(context, {
                  'name': name,
                  'age': age,
                  'gender': gender,
                });
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
