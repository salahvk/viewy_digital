import 'package:flutter/material.dart';
import 'package:viewy_digital/data/model/Chat_message_model.dart';
import 'package:viewy_digital/presentation/widgets/animation_widget.dart';

class ContactList extends StatelessWidget {
  final List<Chat> contacts;

  const ContactList({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return TranslateUpAnimation(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(contact.profileImage),
            ),
            title: Text(contact.name),
            subtitle: Text(contact.subtitle),
          ),
        );
      },
    );
  }
}
