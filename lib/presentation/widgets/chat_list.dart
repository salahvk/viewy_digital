import 'package:flutter/material.dart';
import 'package:viewy_digital/data/model/Chat_message_model.dart';
import 'package:animations/animations.dart';
import 'package:viewy_digital/presentation/chat_page.dart';
import 'package:viewy_digital/presentation/widgets/animation_widget.dart';

class ChatList extends StatelessWidget {
  final List<Chat> chats;

  const ChatList({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    ContainerTransitionType _transitionType = ContainerTransitionType.fade;
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        final milliseconds = 1000 + index * 200;
        return Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
            child: OpenContainer<bool>(
              transitionType: _transitionType,
              openBuilder: (BuildContext _, VoidCallback openContainer) {
                return const ChatPage();
              },
              // onClosed: _showMarkedAsDoneSnackbar,
              tappable: false,
              closedShape: const RoundedRectangleBorder(),
              closedElevation: 0.0,
              closedBuilder: (BuildContext _, VoidCallback openContainer) {
                return InkWell(
                  onTap: openContainer,
                  child: TranslateLeftAnimation(
                    duration: Duration(milliseconds: milliseconds),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          color: const Color.fromARGB(220, 235, 232, 232)),
                      child: ListTile(
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
                                if (chat.isMessageSent)
                                  const Icon(Icons.check, size: 16),
                                if (chat.isMessageDelivered)
                                  const Icon(Icons.check, size: 16),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ));
      },
    );
  }
}
