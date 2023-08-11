import 'package:flutter/material.dart';
import 'package:viewy_digital/data/model/Chat_message_model.dart';

class ChatList extends StatelessWidget {
  final List<Chat> chats;

  const ChatList({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];

        return ListTile(
          leading: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: chat.hasUnreadMessages ? 48 : 36,
            child: CircleAvatar(
              backgroundImage: NetworkImage(chat.profileImage),
            ),
          ),
          title: Text(chat.name),
          subtitle: Text(chat.subtitle),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(chat.lastMessage),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (chat.isMessageSent) const Icon(Icons.check, size: 16),
                  if (chat.isMessageDelivered)
                    const Icon(Icons.check, size: 16),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
