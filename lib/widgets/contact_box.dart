import 'package:contact_app/models/contact.dart';
import 'package:contact_app/dialogs/contact_update_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ContactBox extends StatelessWidget {
  final int contactIndex;
  final Contact contact;
  final Function(Contact) deleteContact;
  final Function(int) selectContact;
  final Function(int, Contact) updateContact;

  const ContactBox({
    super.key,
    required this.contactIndex,
    required this.contact,
    required this.deleteContact,
    required this.selectContact,
    required this.updateContact,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            icon: Icons.delete,
            backgroundColor: Colors.red,
            onPressed: (context) {
              deleteContact(contact);
            },
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Checkbox(
              value: contact.selected,
              onChanged: (value) {
                selectContact(contactIndex);
              },
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => ContactUpdateDialog(
                    contactIndex: contactIndex,
                    contact: contact,
                    updateContact: updateContact,
                  ),
                );
              },
              child: Text(contact.name),
            ),
          ],
        ),
      ),
    );
  }
}
