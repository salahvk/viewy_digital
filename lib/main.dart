import 'package:flutter/material.dart';
import 'package:viewy_digital/data/datasource/dummy_chats.dart';
import 'package:viewy_digital/presentation/chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
          length: 2, child: ChatScreen(chats: chats, contacts: chats)),
    );
  }
}
