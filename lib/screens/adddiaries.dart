import 'package:flutter/material.dart';

class AddDiariesForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
            width: 340,
            child: Center(
                child: Column(
                children: [
            const SizedBox(
              height: 200,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'What do people call you?',
                labelText: 'Name *',
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                return (value != null && value.contains('@'))
                    ? 'Do not use the @ char.'
                    : null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'What do people call you?',
                labelText: 'Name *',
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                return (value != null && value.contains('@'))
                    ? 'Do not use the @ char.'
                    : null;
              },
            ),
                ],
              )),
          ),
        ));
  }
}
