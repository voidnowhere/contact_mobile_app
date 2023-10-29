import 'package:contact_app/dialogs/contact_add_dialog.dart';
import 'package:contact_app/widgets/contact_box.dart';
import 'package:contact_app/models/contact.dart';
import 'package:contact_app/dialogs/contact_update_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class ContactManagement extends StatefulWidget {
  const ContactManagement({super.key});

  @override
  State<ContactManagement> createState() => _ContactManagementState();
}

class _ContactManagementState extends State<ContactManagement> {
  final _expandableFabKey = GlobalKey<ExpandableFabState>();
  List<Contact> contancts = [
    Contact(name: 'Ali', selected: false),
    Contact(name: 'Asta', selected: true),
  ];

  void deleteContact(Contact contact) {
    setState(() {
      contancts.remove(contact);
    });
  }

  void selectContact(int index) {
    Contact contact = contancts.elementAt(index);
    setState(() {
      contancts.elementAt(index).selected = !contact.selected;
    });
  }

  void addContact(String name) {
    setState(() {
      contancts.add(Contact(name: name, selected: false));
    });
  }

  void showAddContactDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ContactAddDialog(
        addContact: addContact,
      ),
    );
  }

  updateContact(int index, Contact contact) {
    setState(() {
      contancts.elementAt(index).name = contact.name;
    });
  }

  void showUpdateContactDialog(int index, Contact contact) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ContactUpdateDialog(
        contactIndex: index,
        contact: contact,
        updateContact: updateContact,
      ),
    );
  }

  void deleteSelectedContacts() {
    setState(() {
      contancts.removeWhere((c) => c.selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Contacts")),
      // floatingActionButton: FloatingActionButton(
      // onPressed: showAddContactDialog,
      // child: const Icon(Icons.add),
      // ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _expandableFabKey,
        distance: 75,
        type: ExpandableFabType.up,
        children: [
          FloatingActionButton.small(
            onPressed: () {
              showAddContactDialog();
              _expandableFabKey.currentState!.toggle();
            },
            child: const Icon(Icons.add),
          ),
          FloatingActionButton.small(
            onPressed: () {
              deleteSelectedContacts();
              _expandableFabKey.currentState!.toggle();
            },
            child: const Icon(Icons.delete),
          ),
        ],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => ContactBox(
          contactIndex: index,
          contact: contancts.elementAt(index),
          deleteContact: deleteContact,
          selectContact: selectContact,
          updateContact: updateContact,
        ),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: contancts.length,
      ),
    );
  }
}
