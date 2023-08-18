import 'package:flutter/material.dart';
import 'package:viewy_digital/data/model/Chat_message_model.dart';

import 'package:viewy_digital/presentation/widgets/chat_list.dart';
import 'package:viewy_digital/presentation/widgets/contact_list.dart';
import 'package:viewy_digital/presentation/widgets/popup_menu.dart';
import 'package:viewy_digital/utils/manager/asset_manager.dart';
import 'package:viewy_digital/utils/manager/color_manager.dart';
import 'package:viewy_digital/utils/manager/style_manager.dart';

const List<Tab> tabs = <Tab>[
  Tab(text: 'Chats'),
  Tab(text: 'Contacts'),
];

class ChatScreen extends StatefulWidget {
  final List<Chat> chats;
  final List<Chat> contacts;

  const ChatScreen({super.key, required this.chats, required this.contacts});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.only(
                      left: 0,
                    ),
                    title: const TabBar(
                        // controller: _tabController,
                        tabs: tabs),
                    background: Stack(
                      children: [
                        Image.asset(
                          AssetManager.ocean,
                          width: size.width,
                          fit: BoxFit.cover,
                        ),
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          'https://imgs.search.brave.com/Jd9cmJ8xRGjCY4MTCiU1J6i9dB0bMtBiN-lYDtBwOgI/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzLzFjL2Jh/LzE0LzFjYmExNDhj/MTk2NDk4YTk2NjBj/ZWI1ODNkNGZjM2Uz/LS1maXNodGFpbC1o/YWlyc3R5bGVzLWVt/bWEtd2F0c29uLWhh/aXJzdHlsZXMuanBn'),
                                      radius: 25,
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    Text(
                                      'Viewy digital',
                                      style: getMediumtStyle(
                                          color: ColorManager.white,
                                          fontSize: 20),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                    const PopupMenuExample()
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ))),
          ];
        },
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  ChatList(chats: widget.chats),
                  ContactList(contacts: widget.contacts)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
