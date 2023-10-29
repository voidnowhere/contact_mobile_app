import 'package:flutter/material.dart';

class ContactAddDialog extends StatelessWidget {
  final controller = TextEditingController();
  final Function(String) addContact;

  ContactAddDialog({super.key, required this.addContact});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Contact'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter name',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.cancel),
        ),
        TextButton(
          onPressed: () {
            addContact(controller.text);
            Navigator.pop(context);
          },
          child: const Icon(Icons.add_box),
        ),
      ],
    );
  }
}
