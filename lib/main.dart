import 'package:flutter/material.dart';
import 'package:viewy_digital/data/datasource/dummy_contacts.dart';
import 'package:viewy_digital/data/model/Chat_message_model.dart';
import 'package:viewy_digital/data/datasource/dummy_chats.dart';
import 'package:viewy_digital/presentation/widgets/chat_list.dart';
import 'package:viewy_digital/presentation/widgets/contact_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 2, child: ChatScreen(chats: chats, contacts: contacts)),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final List<Chat> chats;
  final List<Chat> contacts;

  const ChatScreen({super.key, required this.chats, required this.contacts});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _tabController =
        TabController(length: 2, vsync: this); // 2 tabs: Chats and Contacts
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WhatsApp"),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            // Swiped from left to right (go to previous tab)
            _pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else if (details.primaryVelocity! < 0) {
            // Swiped from right to left (go to next tab)
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              const SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("Scrollable App Bar"),
                ),
              ),
            ];
          },
          body: Column(
            children: [
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: "Chats"),
                  Tab(text: "Contacts"),
                ],
                onTap: (index) {
                  setState(() {
                    _currentPage = index;
                    _pageController.animateToPage(
                      _currentPage,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  });
                },
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final page = index == 0
                        ? ChatList(chats: widget.chats)
                        : ContactList(contacts: widget.contacts);

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: page,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
