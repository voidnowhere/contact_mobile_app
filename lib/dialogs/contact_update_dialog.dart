import 'package:contact_app/models/contact.dart';
import 'package:flutter/material.dart';

class ContactUpdateDialog extends StatelessWidget {
  final int contactIndex;
  final Contact contact;
  final controller = TextEditingController();
  final Function(int, Contact) updateContact;

  ContactUpdateDialog({
    super.key,
    required this.contactIndex,
    required this.contact,
    required this.updateContact,
  }) {
    controller.text = contact.name;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Contact'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Update name',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.cancel),
        ),
        TextButton(
          onPressed: () {
            contact.name = controller.text;
            updateContact(contactIndex, contact);
            Navigator.pop(context);
          },
          child: const Icon(Icons.edit),
        ),
      ],
    );
  }
}
